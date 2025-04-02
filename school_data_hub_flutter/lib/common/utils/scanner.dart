import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:school_data_hub_flutter/common/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

Future<String?> qrScanner(
    {required BuildContext context, required String overlayText}) async {
  if (Platform.isWindows) {
    di<NotificationService>().showSnackBar(NotificationType.error,
        'Scannen mit Windows ist zur Zeit nicht möglich.');

    return null;
  }
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.qrCode, BarcodeFormat.ean13],
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => Stack(
        children: [
          MobileScanner(
              controller: controller,
              // fit: BoxFit.contain,
              onDetect: (capture) {
                final Barcode barcode;
                barcode = capture.barcodes[0];

                Navigator.pop(context, barcode.displayValue);
                controller.dispose();
              }),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(overlayText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        backgroundColor: Colors.transparent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  return result;
}
