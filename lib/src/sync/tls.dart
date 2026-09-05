import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:catalog_core/catalog_core.dart';
import 'package:crypto/crypto.dart';

/// In-person sync over TLS (#92): the host serves with a self-signed
/// certificate made once per installation; the joiner pins it by the
/// fingerprint the pair code carries. No CA, no server, nothing to
/// renew — and nobody on the Wi-Fi reads what passes.
class TlsIdentity {
  final String certPem;
  final String keyPem;
  final Uint8List fingerprint;

  const TlsIdentity(this.certPem, this.keyPem, this.fingerprint);

  SecurityContext get context => SecurityContext()
    ..useCertificateChainBytes(utf8.encode(certPem))
    ..usePrivateKeyBytes(utf8.encode(keyPem));
}

const tlsCertKey = 'tls:cert';
const tlsKeyKey = 'tls:key';

/// SHA-256 over the certificate's DER bytes — what a joiner sees in
/// the handshake and what the pair code carries.
Uint8List fingerprintOf(String certPem) {
  final body = certPem
      .replaceAll(RegExp(r'-----[A-Z ]+-----'), '')
      .replaceAll(RegExp(r'\s'), '');
  return Uint8List.fromList(sha256.convert(base64.decode(body)).bytes);
}

/// The device's identity, made on first hosting (a few seconds, off the
/// UI isolate) and kept in the shared settings for every catalog.
Future<TlsIdentity> tlsIdentity(CatalogStore store, {int keySize = 2048}) async {
  final cert = store.localSetting(tlsCertKey);
  final key = store.localSetting(tlsKeyKey);
  if (cert != null && key != null) {
    return TlsIdentity(cert, key, fingerprintOf(cert));
  }
  final made = await Isolate.run(() => generateIdentity(keySize: keySize));
  if (store.isOpen) {
    store.setLocalSetting(tlsCertKey, made.certPem);
    store.setLocalSetting(tlsKeyKey, made.keyPem);
  }
  return made;
}

/// A fresh self-signed certificate; pure Dart, valid ten years.
TlsIdentity generateIdentity({int keySize = 2048}) {
  final pair = CryptoUtils.generateRSAKeyPair(keySize: keySize);
  final private = pair.privateKey as RSAPrivateKey;
  final public = pair.publicKey as RSAPublicKey;
  final csr = X509Utils.generateRsaCsrPem(
      {'CN': 'catlog', 'O': 'cat(a)log'}, private, public);
  final cert = X509Utils.generateSelfSignedCertificate(private, csr, 3650);
  final keyPem = CryptoUtils.encodeRSAPrivateKeyToPem(private);
  return TlsIdentity(cert, keyPem, fingerprintOf(cert));
}

/// Whether a certificate seen in the handshake is the one the pair code
/// named — the full fingerprint from a QR, its first bytes from a typed
/// code.
bool certificateMatches(X509Certificate cert, List<int> expected) {
  final actual = sha256.convert(cert.der).bytes;
  if (expected.length < typedFingerprintBytes) return false;
  for (var i = 0; i < expected.length && i < actual.length; i++) {
    if (actual[i] != expected[i]) return false;
  }
  return true;
}
