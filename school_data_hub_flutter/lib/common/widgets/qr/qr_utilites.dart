import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

final _notificationService = di<NotificationService>();

Future<void> showQrCode(String qr, BuildContext context) async {
  final qrImageKey = GlobalKey();
  final mediaQuery = MediaQuery.of(context);
  final maxWidth =
      mediaQuery.size.width * 0.8; // Adjust the multiplier as needed
  final maxHeight = mediaQuery.size.height * 0.8; //
  //final RenderBox box = context.findRenderObject() as RenderBox;
  //final Offset offset = box.localToGlobal(Offset.zero);
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              key: qrImageKey,
              child: QrImageView(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white,
                data: qr,
                version: QrVersions.auto,
                size: min(maxWidth, maxHeight),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    saveQrCode(qr, context, qrImageKey);
                  },
                  child: const Text('speichern'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    copyQrCodeToClipboard(qr, context, qrImageKey);
                  },
                  child: const Text('kopieren'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('fertig'),
                ),
                const Gap(10)
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> saveQrCode(
    String qr, BuildContext context, GlobalKey qrKey) async {
  final RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary; //final repaintBoundary = RepaintBoundary();
  // Wrap the QR image with a Container or SizedBox
  ui.Image image = await boundary.toImage();
  String? filePath =
      await FilePicker.platform.saveFile(allowedExtensions: ['png']);
  if (filePath == null) {
    // User canceled the file picker
    return;
  }
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();
  File imgFile = File(Platform.isWindows ? '$filePath.png' : filePath);
  await imgFile.writeAsBytes(pngBytes);

  // Show a success message
  _notificationService.showSnackBar(
      NotificationType.success, ' QR-Code gespeichert');
}

Future<void> copyQrCodeToClipboard(
    String qr, BuildContext context, GlobalKey qrKey) async {
  final RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary; //final repaintBoundary = RepaintBoundary();
  // Wrap the QR image with a Container or SizedBox
  ui.Image image = await boundary.toImage();

  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();
  Directory directory = await getTemporaryDirectory();

  String fileName =
      'school_data_qr_code_${DateTime.now().toUtc().millisecondsSinceEpoch}.png';
  String filePath = '${directory.path}/$fileName';
  File imgFile = File(filePath);
  await imgFile.writeAsBytes(pngBytes);

  await Pasteboard.writeFiles([filePath]);

  // Find and delete old QR code files, excluding the current imgFile
  final List<FileSystemEntity> files = directory.listSync();
  for (final file in files) {
    if (file.path.contains('school_data_qr_code') &&
        !file.path.contains(fileName)) {
      try {
        await File(file.path).delete();
      } catch (e) {
        // Handle the error or ignore
      }
    }
  }
  // Show a success message
  _notificationService.showSnackBar(
      NotificationType.success, ' QR-Code gespeichert');
}
