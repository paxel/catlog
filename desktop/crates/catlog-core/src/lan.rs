//! The in-person sync as the desk hosts it (#138): the same small HTTPS
//! server a phone runs, so a phone joins the desk exactly as it joins
//! another phone. The desk serves with a self-signed certificate made
//! once; the pair code carries its fingerprint, the PIN gates every
//! request, and a keeper's yes admits each unknown phone.
//!
//! The network runs on its own thread and never touches the Catalog:
//! every request that passed the PIN crosses a channel to whoever
//! polls [`Host::next_request`], who answers it through the store-side
//! handlers on [`Catalog`] and hands the response back.

use std::collections::{BTreeMap, HashMap};
use std::io::{BufRead, BufReader, Write};
use std::net::{IpAddr, Ipv4Addr, SocketAddr, TcpListener, TcpStream, UdpSocket};
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::mpsc::{Receiver, Sender, channel};
use std::sync::{Arc, Mutex};
use std::thread::JoinHandle;
use std::time::Duration;

use base64::Engine;
use base64::engine::general_purpose::STANDARD as BASE64;
use rustls::pki_types::{CertificateDer, PrivateKeyDer, PrivatePkcs8KeyDer};
use serde_json::{Value, json};
use sha2::{Digest, Sha256};

use crate::Result;
use crate::bundle::{MAX_BLOB_BYTES, MAX_ENTRIES_BYTES};
use crate::catalog::Catalog;
use crate::entry::Entry;
use crate::error::Error;
use crate::moments::{Moment, cause};
use crate::signing::{ImportReport, parse_keys};

/// The sync wire format this build speaks: format 2's payload over
/// TLS, as the phones do since 1.1.0.
pub const SYNC_FORMAT: i64 = 3;

/// How many wrong PINs one address may send before it is locked out,
/// and how many in total before the host stops serving.
pub const PIN_FAILURES_PER_ADDRESS: u32 = 5;
pub const PIN_FAILURES_TOTAL: u32 = 20;

/// How much of the fingerprint a typed code carries.
pub const TYPED_FINGERPRINT_BYTES: usize = 8;
const FULL_FINGERPRINT_BYTES: usize = 32;

/// Local settings holding this Catalog's certificate and key, DER in
/// base64.
pub const TLS_CERT_KEY: &str = "tls:cert";
pub const TLS_KEY_KEY: &str = "tls:key";

const PIN_HEADER: &str = "x-catlog-pin";
const DEVICE_HEADER: &str = "x-catlog-device";
const FORMAT_HEADER: &str = "x-catlog-format";

/// Local-setting key of a trusted joiner: `private|author|name|secret`.
pub fn trust_key(device_id: &str) -> String {
    format!("trust:{device_id}")
}

// ---------------------------------------------------------------- pair code

/// Crockford base32, lowercase, no i/l/o/u — as the phone writes it.
const ALPHABET: &[u8] = b"0123456789abcdefghjkmnpqrstvwxyz";

/// What a pair code names.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct PairInfo {
    pub host: String,
    pub port: u16,
    pub pin: String,
    /// The host certificate's SHA-256 fingerprint, or its first bytes
    /// from a typed code; none in a code from a version before TLS.
    pub fingerprint: Option<Vec<u8>>,
}

/// Host, port, PIN and fingerprint packed into base32, grouped in fives:
/// the QR carries the whole fingerprint, the typed code its first bytes.
pub fn encode_pair_code(
    host: Ipv4Addr,
    port: u16,
    pin: &str,
    fingerprint: Option<&[u8]>,
    typed: bool,
) -> String {
    let pin_number: u32 = pin.parse().unwrap_or(0);
    let mut bytes = host.octets().to_vec();
    bytes.extend_from_slice(&port.to_be_bytes());
    bytes.extend_from_slice(&pin_number.to_be_bytes()[1..]);
    if let Some(fp) = fingerprint {
        let take = if typed {
            TYPED_FINGERPRINT_BYTES
        } else {
            fp.len()
        };
        bytes.extend_from_slice(&fp[..take.min(fp.len())]);
    }
    let raw = to_base32(&bytes);
    raw.as_bytes()
        .chunks(5)
        .map(|c| String::from_utf8_lossy(c).into_owned())
        .collect::<Vec<_>>()
        .join("_")
}

/// The code's groups in lines of three, as the phone shows them.
pub fn pair_code_lines(code: &str) -> Vec<String> {
    code.split('_')
        .collect::<Vec<_>>()
        .chunks(3)
        .map(|c| c.join("_"))
        .collect()
}

/// Parses a code as typed: spaces, underscores, case and the classic
/// confusions are forgiven; none when it is not a code.
pub fn decode_pair_code(input: &str) -> Option<PairInfo> {
    let cleaned: String = input
        .to_lowercase()
        .chars()
        .filter(|c| !c.is_whitespace() && *c != '_' && *c != '-')
        .map(|c| match c {
            'i' | 'l' => '1',
            'o' => '0',
            'u' => 'v',
            other => other,
        })
        .collect();
    let bytes = from_base32(&cleaned)?;
    let shape = [4usize, 16]
        .iter()
        .flat_map(|a| {
            [0usize, TYPED_FINGERPRINT_BYTES, FULL_FINGERPRINT_BYTES]
                .into_iter()
                .map(move |fp| (*a, fp))
        })
        .find(|(a, fp)| ((a + 5 + fp) * 8).div_ceil(5) == cleaned.len())?;
    let (address_length, fp_length) = shape;
    if bytes.len() < address_length + 5 + fp_length {
        return None;
    }
    let host = if address_length == 4 {
        Ipv4Addr::new(bytes[0], bytes[1], bytes[2], bytes[3]).to_string()
    } else {
        let mut o = [0u8; 16];
        o.copy_from_slice(&bytes[..16]);
        std::net::Ipv6Addr::from(o).to_string()
    };
    let port = u16::from_be_bytes([bytes[address_length], bytes[address_length + 1]]);
    let pin = (u32::from(bytes[address_length + 2]) << 16)
        | (u32::from(bytes[address_length + 3]) << 8)
        | u32::from(bytes[address_length + 4]);
    if port == 0 || pin > 999_999 {
        return None;
    }
    let fingerprint =
        (fp_length > 0).then(|| bytes[address_length + 5..address_length + 5 + fp_length].to_vec());
    Some(PairInfo {
        host,
        port,
        pin: format!("{pin:06}"),
        fingerprint,
    })
}

fn to_base32(bytes: &[u8]) -> String {
    let mut out = String::new();
    let mut buffer: u32 = 0;
    let mut bits = 0;
    for &byte in bytes {
        buffer = (buffer << 8) | u32::from(byte);
        bits += 8;
        while bits >= 5 {
            out.push(ALPHABET[((buffer >> (bits - 5)) & 31) as usize] as char);
            bits -= 5;
        }
        buffer &= (1 << bits) - 1;
    }
    if bits > 0 {
        out.push(ALPHABET[((buffer << (5 - bits)) & 31) as usize] as char);
    }
    out
}

fn from_base32(s: &str) -> Option<Vec<u8>> {
    let mut out = Vec::new();
    let mut buffer: u32 = 0;
    let mut bits = 0;
    for c in s.bytes() {
        let value = ALPHABET.iter().position(|a| *a == c)? as u32;
        buffer = (buffer << 5) | value;
        bits += 5;
        if bits >= 8 {
            out.push(((buffer >> (bits - 8)) & 0xff) as u8);
            bits -= 8;
        }
        buffer &= (1 << bits) - 1;
    }
    Some(out)
}

// ------------------------------------------------------------------ identity

/// The certificate the host serves with and the key behind it; the
/// fingerprint is SHA-256 over the certificate's DER, what a joiner sees
/// in the handshake and what the pair code carries.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Identity {
    pub cert_der: Vec<u8>,
    pub key_der: Vec<u8>,
    pub fingerprint: Vec<u8>,
}

pub fn fingerprint_of(cert_der: &[u8]) -> Vec<u8> {
    Sha256::digest(cert_der).to_vec()
}

/// A fresh self-signed certificate, ECDSA P-256, valid for good.
pub fn generate_identity() -> Result<Identity> {
    let made = rcgen::generate_simple_self_signed(vec!["catlog".to_string()])
        .map_err(|e| Error::Invalid(format!("certificate: {e}")))?;
    let cert_der = made.cert.der().to_vec();
    Ok(Identity {
        fingerprint: fingerprint_of(&cert_der),
        cert_der,
        key_der: made.key_pair.serialize_der(),
    })
}

impl Catalog {
    /// This Catalog's identity, made on first hosting and kept.
    pub fn tls_identity(&self) -> Result<Identity> {
        if let (Some(cert), Some(key)) = (
            self.local_setting(TLS_CERT_KEY),
            self.local_setting(TLS_KEY_KEY),
        ) && let (Ok(cert_der), Ok(key_der)) = (BASE64.decode(cert), BASE64.decode(key))
        {
            return Ok(Identity {
                fingerprint: fingerprint_of(&cert_der),
                cert_der,
                key_der,
            });
        }
        let made = generate_identity()?;
        self.set_local_setting(TLS_CERT_KEY, &BASE64.encode(&made.cert_der))?;
        self.set_local_setting(TLS_KEY_KEY, &BASE64.encode(&made.key_der))?;
        Ok(made)
    }
}

// ---------------------------------------------------------------- requests

/// One request that passed the PIN, waiting for its answer.
#[derive(Debug)]
pub struct Request {
    pub method: String,
    pub path: String,
    headers: Vec<(String, String)>,
    pub body: Vec<u8>,
    pub from: IpAddr,
    reply: Sender<Response>,
}

impl Request {
    pub fn header(&self, name: &str) -> Option<&str> {
        self.headers
            .iter()
            .find(|(k, _)| k.eq_ignore_ascii_case(name))
            .map(|(_, v)| v.as_str())
    }

    /// Answers the joiner; a joiner gone meanwhile is nobody's problem.
    pub fn reply(self, response: Response) {
        let _ = self.reply.send(response);
    }
}

/// What goes back over the wire.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Response {
    pub status: u16,
    pub content_type: Option<String>,
    pub headers: Vec<(String, String)>,
    pub body: Vec<u8>,
}

impl Response {
    pub fn status(status: u16) -> Response {
        Response {
            status,
            content_type: None,
            headers: Vec::new(),
            body: Vec::new(),
        }
    }

    pub fn text(status: u16, body: &str) -> Response {
        Response {
            body: body.as_bytes().to_vec(),
            ..Response::status(status)
        }
    }

    pub fn json(status: u16, value: &Value) -> Response {
        Response {
            content_type: Some("application/json".to_string()),
            body: serde_json::to_vec(value).unwrap_or_default(),
            ..Response::status(status)
        }
    }

    pub fn bytes(body: Vec<u8>) -> Response {
        Response {
            content_type: Some("application/octet-stream".to_string()),
            body,
            ..Response::status(200)
        }
    }

    fn reason(&self) -> &'static str {
        match self.status {
            200 => "OK",
            403 => "Forbidden",
            404 => "Not Found",
            413 => "Payload Too Large",
            500 => "Internal Server Error",
            503 => "Service Unavailable",
            _ => "Unknown",
        }
    }

    fn write(&self, out: &mut impl Write) -> std::io::Result<()> {
        let mut head = format!("HTTP/1.1 {} {}\r\n", self.status, self.reason());
        if let Some(ct) = &self.content_type {
            head.push_str(&format!("Content-Type: {ct}\r\n"));
        }
        for (k, v) in &self.headers {
            head.push_str(&format!("{k}: {v}\r\n"));
        }
        head.push_str(&format!(
            "Content-Length: {}\r\nConnection: close\r\n\r\n",
            self.body.len()
        ));
        out.write_all(head.as_bytes())?;
        out.write_all(&self.body)?;
        out.flush()
    }
}

// -------------------------------------------------------------------- host

/// The server: a thread accepting joiners, one thread per connection,
/// every PIN-checked request handed over the channel.
pub struct Host {
    address: IpAddr,
    port: u16,
    pin: String,
    fingerprint: Vec<u8>,
    requests: Receiver<Request>,
    stop: Arc<AtomicBool>,
    locked: Arc<AtomicBool>,
    thread: Option<JoinHandle<()>>,
}

/// Wrong PINs so far, per address and in total.
#[derive(Default)]
struct Failures {
    per_address: HashMap<IpAddr, u32>,
    total: u32,
}

/// A six-digit PIN, never starting with zero.
pub fn new_pin() -> String {
    let mut random = [0u8; 4];
    let _ = getrandom::fill(&mut random);
    let n = u32::from_be_bytes(random) % 900_000 + 100_000;
    n.to_string()
}

/// A secret for a device allowed for good: 32 random bytes in hex.
fn new_secret() -> String {
    let mut random = [0u8; 32];
    let _ = getrandom::fill(&mut random);
    hex::encode(random)
}

/// The address this machine has on its local network, found without
/// sending anything; none without a network.
pub fn lan_address() -> Option<Ipv4Addr> {
    let socket = UdpSocket::bind("0.0.0.0:0").ok()?;
    socket.connect("10.255.255.255:1").ok()?;
    match socket.local_addr().ok()?.ip() {
        IpAddr::V4(ip) if !ip.is_loopback() && !ip.is_unspecified() => Some(ip),
        _ => None,
    }
}

impl Host {
    /// Binds and starts serving on `bind`, or on the LAN address (the
    /// loopback without a network), on a free port.
    pub fn start(identity: &Identity, pin: &str, bind: Option<IpAddr>) -> Result<Host> {
        let address = bind
            .or_else(|| lan_address().map(IpAddr::V4))
            .unwrap_or(IpAddr::V4(Ipv4Addr::LOCALHOST));
        let config = server_config(identity)?;
        let listener = TcpListener::bind(SocketAddr::new(address, 0))
            .map_err(|e| Error::Invalid(format!("bind: {e}")))?;
        listener
            .set_nonblocking(true)
            .map_err(|e| Error::Invalid(format!("bind: {e}")))?;
        let port = listener
            .local_addr()
            .map_err(|e| Error::Invalid(format!("bind: {e}")))?
            .port();
        let (tx, rx) = channel();
        let stop = Arc::new(AtomicBool::new(false));
        let locked = Arc::new(AtomicBool::new(false));
        let gate = Arc::new(Gate {
            pin: pin.to_string(),
            failures: Mutex::new(Failures::default()),
            locked: locked.clone(),
        });
        let thread = {
            let stop = stop.clone();
            std::thread::spawn(move || accept_loop(listener, config, tx, gate, stop))
        };
        Ok(Host {
            address,
            port,
            pin: pin.to_string(),
            fingerprint: identity.fingerprint.clone(),
            requests: rx,
            stop,
            locked,
            thread: Some(thread),
        })
    }

    pub fn address(&self) -> IpAddr {
        self.address
    }

    pub fn port(&self) -> u16 {
        self.port
    }

    pub fn pin(&self) -> &str {
        &self.pin
    }

    pub fn fingerprint(&self) -> &[u8] {
        &self.fingerprint
    }

    /// True once too many wrong PINs arrived: nothing is answered any
    /// more; hosting must start again with a new PIN.
    pub fn locked_out(&self) -> bool {
        self.locked.load(Ordering::Relaxed)
    }

    /// The pair code for this host: the whole fingerprint for a QR, its
    /// first bytes for typing.
    pub fn pair_code(&self, typed: bool) -> String {
        let host = match self.address {
            IpAddr::V4(ip) => ip,
            IpAddr::V6(_) => Ipv4Addr::LOCALHOST,
        };
        encode_pair_code(host, self.port, &self.pin, Some(&self.fingerprint), typed)
    }

    /// The next request that passed the PIN, if one waits.
    pub fn next_request(&self) -> Option<Request> {
        self.requests.try_recv().ok()
    }

    /// Stops accepting; connections in flight finish on their own.
    pub fn stop(&mut self) {
        self.stop.store(true, Ordering::Relaxed);
        if let Some(thread) = self.thread.take() {
            let _ = thread.join();
        }
    }
}

impl Drop for Host {
    fn drop(&mut self) {
        self.stop();
    }
}

/// The PIN and the wrong guesses counted against it.
struct Gate {
    pin: String,
    failures: Mutex<Failures>,
    locked: Arc<AtomicBool>,
}

impl Gate {
    /// Whether this request may pass: `Ok` when it did, else the answer
    /// to send instead.
    fn check(&self, from: IpAddr, pin: Option<&str>) -> std::result::Result<(), Response> {
        let mut failures = self.failures.lock().unwrap_or_else(|e| e.into_inner());
        let locked = failures.total >= PIN_FAILURES_TOTAL
            || failures.per_address.get(&from).copied().unwrap_or(0) >= PIN_FAILURES_PER_ADDRESS;
        if locked {
            return Err(Response::text(403, "locked"));
        }
        if pin != Some(self.pin.as_str()) {
            *failures.per_address.entry(from).or_insert(0) += 1;
            failures.total += 1;
            if failures.total >= PIN_FAILURES_TOTAL {
                self.locked.store(true, Ordering::Relaxed);
            }
            return Err(Response::status(403));
        }
        Ok(())
    }
}

fn server_config(identity: &Identity) -> Result<Arc<rustls::ServerConfig>> {
    let provider = Arc::new(rustls::crypto::ring::default_provider());
    let config = rustls::ServerConfig::builder_with_provider(provider)
        .with_safe_default_protocol_versions()
        .map_err(|e| Error::Invalid(format!("tls: {e}")))?
        .with_no_client_auth()
        .with_single_cert(
            vec![CertificateDer::from(identity.cert_der.clone())],
            PrivateKeyDer::Pkcs8(PrivatePkcs8KeyDer::from(identity.key_der.clone())),
        )
        .map_err(|e| Error::Invalid(format!("tls: {e}")))?;
    Ok(Arc::new(config))
}

fn accept_loop(
    listener: TcpListener,
    config: Arc<rustls::ServerConfig>,
    tx: Sender<Request>,
    gate: Arc<Gate>,
    stop: Arc<AtomicBool>,
) {
    while !stop.load(Ordering::Relaxed) {
        match listener.accept() {
            Ok((stream, peer)) => {
                let config = config.clone();
                let tx = tx.clone();
                let gate = gate.clone();
                std::thread::spawn(move || {
                    let _ = serve_connection(stream, peer, config, tx, gate);
                });
            }
            Err(e) if e.kind() == std::io::ErrorKind::WouldBlock => {
                std::thread::sleep(Duration::from_millis(50));
            }
            Err(_) => std::thread::sleep(Duration::from_millis(50)),
        }
    }
}

/// One joiner's connection: the request read, PIN-checked, answered by
/// whoever polls the host, and the connection closed after it.
fn serve_connection(
    stream: TcpStream,
    peer: SocketAddr,
    config: Arc<rustls::ServerConfig>,
    tx: Sender<Request>,
    gate: Arc<Gate>,
) -> std::io::Result<()> {
    stream.set_nodelay(true)?;
    stream.set_read_timeout(Some(Duration::from_secs(60)))?;
    stream.set_write_timeout(Some(Duration::from_secs(60)))?;
    let conn =
        rustls::ServerConnection::new(config).map_err(|e| std::io::Error::other(e.to_string()))?;
    let mut reader = BufReader::new(rustls::StreamOwned::new(conn, stream));
    let response = match read_request(&mut reader, peer.ip()) {
        Ok(Some(partial)) => match gate.check(partial.from, partial.header(PIN_HEADER)) {
            Err(refusal) => refusal,
            Ok(()) => {
                let (reply_tx, reply_rx) = channel();
                let request = Request {
                    reply: reply_tx,
                    ..partial
                };
                if tx.send(request).is_err() {
                    Response::status(503)
                } else {
                    reply_rx.recv().unwrap_or_else(|_| Response::status(503))
                }
            }
        },
        Ok(None) => Response::status(413),
        Err(_) => Response::status(500),
    };
    let stream = reader.get_mut();
    response.write(stream)?;
    stream.conn.send_close_notify();
    let _ = stream.conn.complete_io(&mut stream.sock);
    Ok(())
}

/// Reads one request; `None` once its body exceeds the limit for its
/// path (the rest is not read).
fn read_request<R: BufRead>(reader: &mut R, from: IpAddr) -> std::io::Result<Option<Request>> {
    let mut line = String::new();
    reader.read_line(&mut line)?;
    let mut parts = line.split_whitespace();
    let method = parts.next().unwrap_or("").to_string();
    let path = parts
        .next()
        .unwrap_or("")
        .split('?')
        .next()
        .unwrap_or("")
        .to_string();
    let mut headers = Vec::new();
    loop {
        let mut line = String::new();
        if reader.read_line(&mut line)? == 0 {
            break;
        }
        let line = line.trim_end_matches(['\r', '\n']);
        if line.is_empty() {
            break;
        }
        if let Some((k, v)) = line.split_once(':') {
            headers.push((k.trim().to_lowercase(), v.trim().to_string()));
        }
    }
    let header = |name: &str| {
        headers
            .iter()
            .find(|(k, _)| k == name)
            .map(|(_, v)| v.as_str())
    };
    let limit = if path.starts_with("/blob/") {
        MAX_BLOB_BYTES
    } else {
        MAX_ENTRIES_BYTES
    } as usize;
    let body = if header("transfer-encoding").is_some_and(|v| v.to_lowercase().contains("chunked"))
    {
        read_chunked(reader, limit)?
    } else {
        let length: usize = header("content-length")
            .and_then(|v| v.parse().ok())
            .unwrap_or(0);
        if length > limit {
            return Ok(None);
        }
        let mut body = vec![0u8; length];
        reader.read_exact(&mut body)?;
        Some(body)
    };
    let Some(body) = body else {
        return Ok(None);
    };
    let (reply, _) = channel();
    Ok(Some(Request {
        method,
        path,
        headers,
        body,
        from,
        reply,
    }))
}

/// A chunked body as the phone sends anything beyond a few kilobytes;
/// `None` past the limit.
fn read_chunked<R: BufRead>(reader: &mut R, limit: usize) -> std::io::Result<Option<Vec<u8>>> {
    let mut body = Vec::new();
    loop {
        let mut line = String::new();
        if reader.read_line(&mut line)? == 0 {
            return Err(std::io::Error::other("chunk cut short"));
        }
        let size_text = line.trim().split(';').next().unwrap_or("").trim();
        let size = usize::from_str_radix(size_text, 16)
            .map_err(|_| std::io::Error::other("bad chunk size"))?;
        if size == 0 {
            // Trailers up to the empty line.
            loop {
                let mut trailer = String::new();
                if reader.read_line(&mut trailer)? == 0 || trailer.trim().is_empty() {
                    break;
                }
            }
            return Ok(Some(body));
        }
        if body.len() + size > limit {
            return Ok(None);
        }
        let start = body.len();
        body.resize(start + size, 0);
        reader.read_exact(&mut body[start..])?;
        let mut crlf = [0u8; 2];
        reader.read_exact(&mut crlf)?;
    }
}

// ------------------------------------------------------------- store side

/// A joiner asking to sync, before the keeper said yes.
#[derive(Debug, Clone, PartialEq)]
pub struct JoinAsk {
    pub author: String,
    pub device_name: String,
    pub device_id: String,
    body: Value,
}

/// The keeper's answer to "may this device sync?".
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct JoinDecision {
    pub allow: bool,
    /// "Always allow this device": a secret is issued and kept, and the
    /// device passes without a question from then on.
    pub remember: bool,
}

/// What one joiner's session brought.
#[derive(Debug, Clone)]
pub struct Session {
    pub author: String,
    pub applied: Vec<Entry>,
    pub moment: Option<Moment>,
    pub report: ImportReport,
}

/// The host's answer to a request: sent, or a question first.
#[derive(Debug)]
pub enum Served {
    Reply(Response, Option<Session>),
    Ask(JoinAsk),
}

fn vector_of(value: Option<&Value>) -> BTreeMap<String, i64> {
    value
        .and_then(|v| v.as_object())
        .map(|m| {
            m.iter()
                .filter_map(|(k, v)| v.as_i64().map(|n| (k.clone(), n)))
                .collect()
        })
        .unwrap_or_default()
}

impl Catalog {
    /// Answers one request as the phone's host would; a `/sync` from a
    /// device not allowed for good comes back as a question.
    pub fn serve(&mut self, request: &Request, include_private: bool) -> Result<Served> {
        let path = request.path.as_str();
        Ok(match (request.method.as_str(), path) {
            ("GET", "/vector") => Served::Reply(self.serve_vector()?, None),
            ("POST", "/sync") => self.serve_sync(&request.body, include_private)?,
            ("GET", p) if p.starts_with("/blob/") => {
                Served::Reply(self.serve_blob_get(&p["/blob/".len()..]), None)
            }
            ("POST", p) if p.starts_with("/blob/") => Served::Reply(
                self.serve_blob_put(&p["/blob/".len()..], &request.body)?,
                None,
            ),
            _ => Served::Reply(Response::status(404), None),
        })
    }

    /// `/vector`: this Catalog's version vector, with the wire format
    /// and device in the headers.
    pub fn serve_vector(&self) -> Result<Response> {
        let mut response = Response::json(200, &json!(self.version_vector()?));
        response
            .headers
            .push((FORMAT_HEADER.to_string(), SYNC_FORMAT.to_string()));
        response
            .headers
            .push((DEVICE_HEADER.to_string(), self.device_id()));
        Ok(response)
    }

    /// `/sync`: refuses a format that would lose data, lets a device
    /// allowed for good straight in, and asks about anyone else.
    pub fn serve_sync(&mut self, body: &[u8], include_private: bool) -> Result<Served> {
        let body: Value = serde_json::from_slice(body)?;
        let joiner_format = body.get("format").and_then(|f| f.as_i64()).unwrap_or(1);
        // While no entry ever carried the reminder flag, the payload is
        // byte-identical to the old format: an older joiner syncs losslessly.
        if joiner_format != SYNC_FORMAT
            && !(joiner_format < SYNC_FORMAT && !self.has_reminders()?)
        {
            let response = if joiner_format == 1 {
                // A pre-1.0.0 joiner parses only this word.
                Response::text(403, "declined")
            } else {
                Response::json(
                    403,
                    &json!({
                        "refusal": if joiner_format < SYNC_FORMAT { "joiner-older" } else { "joiner-newer" },
                        "format": SYNC_FORMAT,
                    }),
                )
            };
            return Ok(Served::Reply(response, None));
        }
        let text = |key: &str, fallback: &str| {
            body.get(key)
                .and_then(|v| v.as_str())
                .unwrap_or(fallback)
                .to_string()
        };
        let ask = JoinAsk {
            author: text("author", "?"),
            device_name: text("deviceName", "?"),
            device_id: text("deviceId", ""),
            body: body.clone(),
        };
        let secret = body.get("trustSecret").and_then(|v| v.as_str());
        if self.trusted(&ask.device_id, secret) {
            let (response, session) = self.serve_join(
                &ask,
                JoinDecision {
                    allow: true,
                    remember: false,
                },
                include_private,
            )?;
            return Ok(Served::Reply(response, session));
        }
        Ok(Served::Ask(ask))
    }

    /// Whether the joiner's claim of trust matches the secret this host
    /// issued it; a stored trust without a secret counts as none.
    fn trusted(&self, device_id: &str, secret: Option<&str>) -> bool {
        let Some(secret) = secret.filter(|s| !s.is_empty()) else {
            return false;
        };
        if device_id.is_empty() {
            return false;
        }
        self.local_setting(&trust_key(device_id))
            .map(|stored| stored.splitn(4, '|').nth(3) == Some(secret))
            .unwrap_or(false)
    }

    /// The `/sync` answer once the keeper decided: the joiner's entries
    /// applied, ours since its vector sent back, with the photos each
    /// side wants and the keys both hold.
    pub fn serve_join(
        &mut self,
        ask: &JoinAsk,
        decision: JoinDecision,
        include_private: bool,
    ) -> Result<(Response, Option<Session>)> {
        if !decision.allow {
            return Ok((Response::text(403, "declined"), None));
        }
        let issued = if decision.remember && !ask.device_id.is_empty() {
            let secret = new_secret();
            let scope = if include_private { "private" } else { "public" };
            self.set_local_setting(
                &trust_key(&ask.device_id),
                &format!("{scope}|{}|{}|{secret}", ask.author, ask.device_name),
            )?;
            Some(secret)
        } else {
            None
        };
        let joiner_vector = vector_of(ask.body.get("vector"));
        let incoming: Vec<Entry> = ask
            .body
            .get("entries")
            .and_then(|e| e.as_array())
            .map(|list| {
                list.iter()
                    .filter_map(|e| serde_json::from_value(e.clone()).ok())
                    .collect()
            })
            .unwrap_or_default();
        // The joiner's own key, met over a session the pair code
        // authenticated, in the same room: verified. The keys it carries
        // for others stay on trust.
        let joiner_keys = ask
            .body
            .get("keys")
            .filter(|k| k.is_array())
            .map(|k| parse_keys(&k.to_string()))
            .unwrap_or_default();
        let mut report = ImportReport::default();
        let before = self.current_seq()?;
        let sender_vector: HashMap<String, i64> = joiner_vector.clone().into_iter().collect();
        let applied = self.apply_entries_from(
            incoming,
            &sender_vector,
            Some(&joiner_keys),
            (!ask.device_id.is_empty()).then_some(ask.device_id.as_str()),
            &mut report,
        )?;
        let moment =
            self.moment_for(before, !applied.is_empty(), cause::SYNC, Some(&ask.author))?;
        let mut answer = json!({
            "entries": self.entries_since(&joiner_vector, include_private)?,
            "wantBlobs": self.missing_blobs()?,
            "keys": self.key_records()?,
        });
        if let Some(secret) = issued {
            answer["trust"] = Value::String(secret);
        }
        Ok((
            Response::json(200, &answer),
            Some(Session {
                author: ask.author.clone(),
                applied,
                moment,
                report,
            }),
        ))
    }

    /// `GET /blob/<hash>`: the photo, or nothing.
    pub fn serve_blob_get(&self, hash: &str) -> Response {
        match self.image_bytes(hash) {
            Some(bytes) => Response::bytes(bytes),
            None => Response::status(404),
        }
    }

    /// `POST /blob/<hash>`: only a photo this Catalog's log mentions —
    /// anything else is storage filled by whoever holds the PIN.
    pub fn serve_blob_put(&self, hash: &str, bytes: &[u8]) -> Result<Response> {
        if !self.knows_image(hash)? {
            return Ok(Response::status(404));
        }
        self.put_blob(hash, bytes)?;
        Ok(Response::status(200))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Cursor;

    #[test]
    fn pair_codes_match_the_phone() {
        // Computed by the Dart core's encodePairCode.
        let fp: Vec<u8> = (0..32u32).map(|i| ((i * 7 + 3) & 0xff) as u8).collect();
        let host = Ipv4Addr::new(192, 168, 1, 23);
        assert_eq!(
            encode_pair_code(host, 45231, "042817", Some(&fp), false),
            "r2m02_5xgnw_0aeg8_3188h_g7s65_mt3pg_j9a1b_nwsbc_edx83_24fjt_et9ax_jq70c_fkpnv_g"
        );
        assert_eq!(
            encode_pair_code(host, 45231, "042817", Some(&fp), true),
            "r2m02_5xgnw_0aeg8_3188h_g7s65_mt0"
        );
        assert_eq!(
            encode_pair_code(Ipv4Addr::new(10, 0, 0, 5), 8080, "999999", None, false),
            "18000_18zj0_7m4fr"
        );
        let typed = decode_pair_code("R2M02 5XGNW 0AEG8 3188H G7S65 MTO").unwrap();
        assert_eq!(typed.host, "192.168.1.23");
        assert_eq!(typed.port, 45231);
        assert_eq!(typed.pin, "042817");
        assert_eq!(typed.fingerprint.as_deref(), Some(&fp[..8]));
        let full =
            decode_pair_code(&encode_pair_code(host, 45231, "042817", Some(&fp), false)).unwrap();
        assert_eq!(full.fingerprint.as_deref(), Some(fp.as_slice()));
        assert_eq!(
            pair_code_lines("r2m02_5xgnw_0aeg8_3188h_g7s65_mt0"),
            vec!["r2m02_5xgnw_0aeg8", "3188h_g7s65_mt0"]
        );
        assert!(decode_pair_code("nope").is_none());
    }

    #[test]
    fn a_chunked_body_is_read_as_the_phone_sends_it() {
        let raw = b"POST /sync HTTP/1.1\r\nHost: x\r\nTransfer-Encoding: chunked\r\nX-Catlog-Pin: 123456\r\n\r\n5\r\nhello\r\n6;ext=1\r\n world\r\n0\r\n\r\n";
        let request = read_request(&mut Cursor::new(&raw[..]), IpAddr::V4(Ipv4Addr::LOCALHOST))
            .unwrap()
            .unwrap();
        assert_eq!(request.method, "POST");
        assert_eq!(request.path, "/sync");
        assert_eq!(request.header("x-catlog-pin"), Some("123456"));
        assert_eq!(request.body, b"hello world");
        let plain = b"GET /vector?x=1 HTTP/1.1\r\nContent-Length: 3\r\n\r\nabc";
        let request = read_request(
            &mut Cursor::new(&plain[..]),
            IpAddr::V4(Ipv4Addr::LOCALHOST),
        )
        .unwrap()
        .unwrap();
        assert_eq!(request.path, "/vector");
        assert_eq!(request.body, b"abc");
    }

    fn agent() -> ureq::Agent {
        // The phone pins the certificate by its fingerprint; here the
        // loopback is trusted outright.
        let config = ureq::Agent::config_builder()
            .tls_config(
                ureq::tls::TlsConfig::builder()
                    .disable_verification(true)
                    .build(),
            )
            .http_status_as_error(false)
            .build();
        ureq::Agent::new_with_config(config)
    }

    /// What a joiner brought home: entries applied, the secret issued,
    /// photos in and out.
    #[derive(Debug)]
    struct Joined {
        applied: Vec<Entry>,
        trust: Option<String>,
        blobs_in: usize,
        blobs_out: usize,
    }

    /// Joins as the phone's `lanSync` does: vector, sync, then photos
    /// both ways; a refusal comes back as its text.
    fn join(
        store: &mut Catalog,
        port: u16,
        pin: &str,
        format: i64,
        trust_secret: Option<&str>,
    ) -> std::result::Result<Joined, String> {
        let agent = agent();
        let base = format!("https://127.0.0.1:{port}");
        let mut res = agent
            .get(format!("{base}/vector"))
            .header(PIN_HEADER, pin)
            .call()
            .map_err(|e| e.to_string())?;
        if res.status().as_u16() != 200 {
            return Err(format!(
                "{} {}",
                res.status().as_u16(),
                res.body_mut().read_to_string().unwrap_or_default()
            ));
        }
        let host_device = res
            .headers()
            .get(DEVICE_HEADER)
            .and_then(|v| v.to_str().ok())
            .unwrap_or("")
            .to_string();
        assert_eq!(
            res.headers()
                .get(FORMAT_HEADER)
                .and_then(|v| v.to_str().ok()),
            Some("3")
        );
        let host_vector: BTreeMap<String, i64> =
            serde_json::from_str(&res.body_mut().read_to_string().unwrap()).unwrap();
        let to_send = store.entries_since(&host_vector, false).unwrap();
        let mut body = json!({
            "format": format,
            "vector": store.version_vector().unwrap(),
            "entries": to_send,
            "author": store.author().unwrap_or_default(),
            "deviceName": "phone",
            "deviceId": store.device_id(),
            "keys": store.key_records().unwrap(),
        });
        if let Some(secret) = trust_secret {
            body["trustSecret"] = Value::String(secret.to_string());
        }
        let mut res = agent
            .post(format!("{base}/sync"))
            .header(PIN_HEADER, pin)
            .content_type("application/json")
            .send(serde_json::to_vec(&body).unwrap().as_slice())
            .map_err(|e| e.to_string())?;
        let text = res.body_mut().read_to_string().unwrap_or_default();
        if res.status().as_u16() != 200 {
            return Err(format!("{} {text}", res.status().as_u16()));
        }
        let answer: Value = serde_json::from_str(&text).unwrap();
        let received: Vec<Entry> = serde_json::from_value(answer["entries"].clone()).unwrap();
        let keys = parse_keys(&answer["keys"].to_string());
        let sender_vector: HashMap<String, i64> = host_vector.into_iter().collect();
        let applied = store
            .apply_entries_from(
                received,
                &sender_vector,
                Some(&keys),
                Some(&host_device),
                &mut ImportReport::default(),
            )
            .unwrap();
        let mut blobs_in = 0;
        for hash in store.missing_blobs().unwrap() {
            let mut res = agent
                .get(format!("{base}/blob/{hash}"))
                .header(PIN_HEADER, pin)
                .call()
                .map_err(|e| e.to_string())?;
            if res.status().as_u16() == 200 {
                store
                    .put_blob(&hash, &res.body_mut().read_to_vec().unwrap())
                    .unwrap();
                blobs_in += 1;
            }
        }
        let mut blobs_out = 0;
        for hash in answer["wantBlobs"].as_array().unwrap() {
            let hash = hash.as_str().unwrap();
            if let Some(bytes) = store.image_bytes(hash) {
                agent
                    .post(format!("{base}/blob/{hash}"))
                    .header(PIN_HEADER, pin)
                    .send(bytes.as_slice())
                    .map_err(|e| e.to_string())?;
                blobs_out += 1;
            }
        }
        Ok(Joined {
            applied,
            trust: answer["trust"].as_str().map(String::from),
            blobs_in,
            blobs_out,
        })
    }

    /// The host's side as the desk runs it: the store answers every
    /// request, and every unknown phone gets the keeper's fixed answer.
    fn serve_until(
        path: std::path::PathBuf,
        host: Host,
        decision: JoinDecision,
        stop: Arc<AtomicBool>,
    ) -> JoinHandle<(Vec<Session>, Vec<JoinAsk>)> {
        std::thread::spawn(move || {
            let mut store = Catalog::open(&path).unwrap();
            let mut sessions = Vec::new();
            let mut asks = Vec::new();
            while !stop.load(Ordering::Relaxed) {
                let Some(request) = host.next_request() else {
                    std::thread::sleep(Duration::from_millis(5));
                    continue;
                };
                match store.serve(&request, false).unwrap() {
                    Served::Reply(response, session) => {
                        sessions.extend(session);
                        request.reply(response);
                    }
                    Served::Ask(ask) => {
                        asks.push(ask.clone());
                        let (response, session) = store.serve_join(&ask, decision, false).unwrap();
                        sessions.extend(session);
                        request.reply(response);
                    }
                }
            }
            drop(host);
            (sessions, asks)
        })
    }

    #[test]
    fn a_phone_joins_the_desk_over_the_loopback() {
        let dir = tempfile::tempdir().unwrap();
        let host_path = dir.path().join("desk");
        let (identity, mia_hash) = {
            let mut desk = Catalog::open(&host_path).unwrap();
            desk.set_author("Bob").unwrap();
            desk.create_cat("cat:mia", "Mia", None, "cat").unwrap();
            let hash = desk.add_image("cat:mia", b"\xff\xd8mia").unwrap();
            (desk.tls_identity().unwrap(), hash)
        };
        let host = Host::start(&identity, "246810", Some(IpAddr::V4(Ipv4Addr::LOCALHOST))).unwrap();
        let port = host.port();
        assert_eq!(host.pair_code(true).len(), 33);
        assert_eq!(
            decode_pair_code(&host.pair_code(false))
                .unwrap()
                .fingerprint,
            Some(identity.fingerprint.clone())
        );
        let stop = Arc::new(AtomicBool::new(false));
        let served = serve_until(
            host_path.clone(),
            host,
            JoinDecision {
                allow: true,
                remember: true,
            },
            stop.clone(),
        );

        let mut phone = Catalog::open(&dir.path().join("phone")).unwrap();
        phone.set_author("Ada").unwrap();
        phone.create_cat("cat:tom", "Tom", None, "cat").unwrap();
        let tom_hash = phone.add_image("cat:tom", b"\xff\xd8tom").unwrap();

        // A wrong PIN is refused before anything is read from the store.
        assert_eq!(
            join(&mut phone, port, "000000", 3, None).unwrap_err(),
            "403 "
        );
        let first = join(&mut phone, port, "246810", 3, None).unwrap();
        assert!(!first.applied.is_empty());
        assert_eq!(
            phone.current("cat:mia", "name").unwrap().as_deref(),
            Some("Mia")
        );
        assert_eq!(phone.image_bytes(&mia_hash).unwrap(), b"\xff\xd8mia");
        assert_eq!((first.blobs_in, first.blobs_out), (1, 1));
        let secret = first.trust.expect("always allow issued a secret");
        // A second visit with the secret passes without a question.
        let again = join(&mut phone, port, "246810", 3, Some(&secret)).unwrap();
        assert!(again.applied.is_empty());
        assert!(again.trust.is_none());
        assert_eq!((again.blobs_in, again.blobs_out), (0, 0));

        stop.store(true, Ordering::Relaxed);
        let (sessions, asks) = served.join().unwrap();
        assert_eq!(asks.len(), 1, "the secret spared the second question");
        assert_eq!(asks[0].author, "Ada");
        assert_eq!(asks[0].device_name, "phone");
        assert_eq!(sessions.len(), 2);
        assert!(sessions[0].moment.is_some());
        assert_eq!(sessions[0].author, "Ada");
        assert!(sessions[1].applied.is_empty());
        let desk = Catalog::open(&host_path).unwrap();
        assert_eq!(
            desk.current("cat:tom", "name").unwrap().as_deref(),
            Some("Tom")
        );
        assert_eq!(desk.image_bytes(&tom_hash).unwrap(), b"\xff\xd8tom");
        let stored = desk.local_setting(&trust_key(&phone.device_id())).unwrap();
        assert_eq!(stored, format!("public|Ada|phone|{secret}"));
    }

    #[test]
    fn wrong_pins_lock_an_address_out() {
        let identity = generate_identity().unwrap();
        let host = Host::start(&identity, "111111", Some(IpAddr::V4(Ipv4Addr::LOCALHOST))).unwrap();
        let agent = agent();
        let url = format!("https://127.0.0.1:{}/vector", host.port());
        for _ in 0..PIN_FAILURES_PER_ADDRESS {
            let res = agent.get(&url).header(PIN_HEADER, "999999").call().unwrap();
            assert_eq!(res.status().as_u16(), 403);
        }
        let mut res = agent.get(&url).header(PIN_HEADER, "111111").call().unwrap();
        assert_eq!(res.status().as_u16(), 403);
        assert_eq!(res.body_mut().read_to_string().unwrap(), "locked");
        assert!(!host.locked_out(), "one address, not everyone");
    }

    #[test]
    fn the_format_gate_refuses_what_would_lose_reminders() {
        let dir = tempfile::tempdir().unwrap();
        let mut desk = Catalog::open(&dir.path().join("desk")).unwrap();
        desk.set_author("Bob").unwrap();
        let body = |format: i64| {
            serde_json::to_vec(&json!({
                "format": format, "vector": {}, "entries": [], "author": "Ada",
                "deviceName": "phone", "deviceId": "p1", "keys": [],
            }))
            .unwrap()
        };
        // Without a reminder the payload is the old one: served, asked about.
        assert!(matches!(
            desk.serve_sync(&body(2), false).unwrap(),
            Served::Ask(_)
        ));
        desk.append_at(
            "cat:a",
            "f:vet",
            Some("shots"),
            Some("2026-03-01T00:00:00Z"),
            true,
        )
        .unwrap();
        match desk.serve_sync(&body(2), false).unwrap() {
            Served::Reply(response, None) => {
                assert_eq!(response.status, 403);
                let refusal: Value = serde_json::from_slice(&response.body).unwrap();
                assert_eq!(refusal["refusal"], "joiner-older");
                assert_eq!(refusal["format"], 3);
            }
            other => panic!("{other:?}"),
        }
        // A pre-1.0.0 joiner hears only the word it knows.
        match desk.serve_sync(&body(1), false).unwrap() {
            Served::Reply(response, None) => {
                assert_eq!(
                    (response.status, response.body.as_slice()),
                    (403, &b"declined"[..])
                );
            }
            other => panic!("{other:?}"),
        }
        match desk.serve_sync(&body(4), false).unwrap() {
            Served::Reply(response, None) => {
                let refusal: Value = serde_json::from_slice(&response.body).unwrap();
                assert_eq!(refusal["refusal"], "joiner-newer");
            }
            other => panic!("{other:?}"),
        }
        // Declining answers the word the phone shows as "declined".
        let ask = match desk.serve_sync(&body(3), false).unwrap() {
            Served::Ask(ask) => ask,
            other => panic!("{other:?}"),
        };
        let (response, session) = desk
            .serve_join(
                &ask,
                JoinDecision {
                    allow: false,
                    remember: false,
                },
                false,
            )
            .unwrap();
        assert_eq!(
            (response.status, response.body.as_slice()),
            (403, &b"declined"[..])
        );
        assert!(session.is_none());
    }

    #[test]
    fn identities_are_made_once_and_fingerprinted() {
        let dir = tempfile::tempdir().unwrap();
        let store = Catalog::open(&dir.path().join("a")).unwrap();
        let first = store.tls_identity().unwrap();
        let again = store.tls_identity().unwrap();
        assert_eq!(first, again);
        assert_eq!(first.fingerprint.len(), 32);
        assert_eq!(first.fingerprint, fingerprint_of(&first.cert_der));
        assert_ne!(generate_identity().unwrap().fingerprint, first.fingerprint);
    }
}
