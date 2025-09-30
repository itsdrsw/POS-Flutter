import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String? barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barcode Scanner"),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final barcode = capture.barcodes.first.rawValue;
              if (barcode != null) {
                Navigator.pop(
                  context,
                  barcode,
                ); // kirim hasil scan balik ke caller
              }
            },
          ),
          if (barcode != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Result: $barcode",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
