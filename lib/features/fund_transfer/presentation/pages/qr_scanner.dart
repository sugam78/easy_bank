
import 'package:easy_bank/core/services/qr_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () async {
              await QRService().pickQRFromGallery(context);
            },
          ),
        ],
      ),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              final qrData = QRService().parseQRData(barcode.rawValue!);
              context.pushNamed('transferAccountNo', extra: qrData['accNumber'].toString());
              break;
            }
          }
        },
      ),
    );
  }

}
