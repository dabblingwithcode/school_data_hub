import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

Future<String?> qrScanner(
    {required BuildContext context, required String overlayText}) async {
  if (Platform.isWindows) {
    _notificationService.showSnackBar(NotificationType.error,
        'Scannen mit Windows ist zur Zeit nicht möglich.');

    return null;
  }
  
  return await context.push<String>(
    '/scanner',
    extra: overlayText,
  );
}

class ScannerPage extends StatefulWidget {
  final String overlayText;
  const ScannerPage({required this.overlayText, super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      formats: [BarcodeFormat.qrCode, BarcodeFormat.ean13],
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
              controller: controller,
              // fit: BoxFit.contain,
              onDetect: (capture) {
                final Barcode barcode;
                barcode = capture.barcodes[0];

                if (mounted) {
                  context.pop(barcode.displayValue);
                }
              }),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.overlayText,
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
    );
  }
}
