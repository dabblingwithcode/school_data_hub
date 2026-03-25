import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';

final _notificationService = di<NotificationManager>();

Future<String?> qrScanner({
  required BuildContext context,
  required String overlayText,
}) async {
  if (Platform.isWindows) {
    _notificationService.showSnackBar(
      NotificationType.error,
      'Scannen mit Windows ist zur Zeit nicht möglich.',
    );

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
    MaterialPageRoute<String?>(
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
            },
          ),
          //TODO: Style this better
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      overlayText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        backgroundColor: Colors.transparent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              color: Colors.red,

              onPressed: () {
                Navigator.pop(context);
                controller.dispose();
              },
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    ),
  );
  return result as String?;
}
