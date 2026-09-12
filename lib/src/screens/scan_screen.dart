import 'package:flutter/material.dart';

import '../help.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

import '../l10n.dart';

/// Fullscreen QR scanner; pops the first detected string.
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.scanCode),
        actions: [HelpButton(screenId: 'scan')],
      ),
      body: MobileScanner(
        onDetect: (capture) {
          if (_done) return;
          final value = capture.barcodes.firstOrNull?.rawValue;
          if (value != null && value.isNotEmpty) {
            _done = true;
            Navigator.of(context).pop(value);
          }
        },
      ),
    );
  }
}
