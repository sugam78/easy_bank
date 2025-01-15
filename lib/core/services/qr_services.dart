import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:easy_bank/shared/bloc/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_bank/core/common/widgets/custom_snackbar.dart';
import 'package:saver_gallery/saver_gallery.dart';
class QRService {
  Map<String, dynamic> parseQRData(String data) {
    try {
      return Map<String, dynamic>.from(json.decode(data));
    } catch (e) {
      return {};
    }
  }


  Future<void> pickQRFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        final File imageFile = File(image.path);

        final barcodeScanner = BarcodeScanner();

        final inputImage = InputImage.fromFile(imageFile);
        final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              final qrData = QRService().parseQRData(barcode.rawValue!);

              if(context.mounted){
                if(context.read<ProfileBloc>().state is ProfileLoaded){
                  final state = context.read<ProfileBloc>().state as ProfileLoaded;
                  if(state.profile.accNumber == qrData['accNumber'].toString()){
                    CustomSnackbar.show(context, message: 'Can\'t use own QR', type: SnackbarType.error);
                    context.pop();
                    return;
                  }
                }
                context.pushNamed('transferAccountNo', extra: qrData['accNumber'].toString());
              }
              return;
            }
          }
          }
        if(context.mounted){
          CustomSnackbar.show(context, message: 'No valid QR code found in the selected image.', type: SnackbarType.error);
        }
      } catch (e) {
        if(context.mounted){
          CustomSnackbar.show(context, message: 'Failed to process the QR code image. Please try again.', type: SnackbarType.error);
        }
      }
    }
  }

  Future<void> saveQrToGallery(BuildContext context,GlobalKey repaintBoundaryKey) async {
    try {
      final RenderRepaintBoundary boundary =
      repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await SaverGallery.saveImage(
        skipIfExists: true,
        pngBytes,
        fileName: "My_QR_Code",
      );

      if (result.isSuccess) {
        if(context.mounted){
          CustomSnackbar.show(context, message: 'QR Code saved to gallery!', type: SnackbarType.success);
        }

      } else {
        if(context.mounted){
          CustomSnackbar.show(context, message: 'Failed to save QR Code to gallery : ${result.errorMessage}', type: SnackbarType.success);
        }
      }
    } catch (e) {
      if(context.mounted){
        CustomSnackbar.show(context, message: 'Failed to save QR Code to gallery : $e', type: SnackbarType.success);
      }
    }
  }

}