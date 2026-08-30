import 'package:catlog/src/sync/tls.dart';

/// One small identity for every LAN test — RSA 1024 keeps generation
/// under a second; the app itself uses 2048.
TlsIdentity? _identity;
TlsIdentity testIdentity() => _identity ??= generateIdentity(keySize: 1024);
