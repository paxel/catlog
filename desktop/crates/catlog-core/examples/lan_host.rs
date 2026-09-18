//! A desk hosting an in-person session on the loopback, for the phone's
//! own `lanSync` to join (`test/lan_desk_test.dart`): the wire check
//! that the ureq joiner in the unit tests cannot be. Opens a Catalog at
//! the directory given, with a cat and a photo, prints `port
//! fingerprint-hex` on one line, allows every joiner for good, and
//! serves until stdin closes.

use std::io::Read;
use std::net::{IpAddr, Ipv4Addr};
use std::sync::Arc;
use std::sync::atomic::{AtomicBool, Ordering};
use std::time::Duration;

use catlog_core::Catalog;
use catlog_core::lan::{Host, JoinDecision, Served};

fn main() {
    let dir = std::env::args()
        .nth(1)
        .expect("a directory for the Catalog");
    let mut store = Catalog::open(std::path::Path::new(&dir)).expect("catalog");
    store.set_author("Desk").expect("author");
    store
        .create_cat("cat:desk-mia", "Mia", None, "cat")
        .expect("cat");
    store
        .add_image("cat:desk-mia", b"\xff\xd8\xff mia's photo")
        .expect("photo");
    let identity = store.tls_identity().expect("identity");
    let host =
        Host::start(&identity, "246810", Some(IpAddr::V4(Ipv4Addr::LOCALHOST))).expect("host");
    println!("{} {}", host.port(), hex::encode(host.fingerprint()));
    let done = Arc::new(AtomicBool::new(false));
    {
        let done = done.clone();
        std::thread::spawn(move || {
            let mut sink = Vec::new();
            let _ = std::io::stdin().read_to_end(&mut sink);
            done.store(true, Ordering::Relaxed);
        });
    }
    let decision = JoinDecision {
        allow: true,
        remember: true,
    };
    while !done.load(Ordering::Relaxed) {
        let Some(request) = host.next_request() else {
            std::thread::sleep(Duration::from_millis(10));
            continue;
        };
        match store.serve(&request, false).expect("serve") {
            Served::Reply(response, session) => {
                request.reply(response);
                if let Some(s) = session {
                    println!("session {} {}", s.author, s.applied.len());
                }
            }
            Served::Ask(ask) => {
                let (response, session) = store.serve_join(&ask, decision, false).expect("join");
                request.reply(response);
                if let Some(s) = session {
                    println!("session {} {}", s.author, s.applied.len());
                }
            }
        }
    }
}
