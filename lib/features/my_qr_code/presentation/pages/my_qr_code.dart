import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_bank/core/resources/dimensions.dart';
import 'package:easy_bank/core/services/qr_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyQrCode extends StatelessWidget {
  final String qrUrl;
  final String accNo;

  MyQrCode({super.key, required this.qrUrl, required this.accNo});

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final decodedBytes = Base64Decoder().convert(
      qrUrl.split(',').last,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My QR Code'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(
            key: _repaintBoundaryKey,
            child: SizedBox(
              height: deviceHeight * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Easy Bank', style: Theme.of(context).textTheme.titleLarge),
                  Text(accNo, style: Theme.of(context).textTheme.titleMedium),
                  Center(
                    child: Image.memory(Uint8List.fromList(decodedBytes)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => QRService().saveQrToGallery(context,_repaintBoundaryKey),
            child: const Text('Save to Gallery'),
          ),
        ],
      ),
    );
  }

}
