import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_vision/qr_code_vision.dart';

Future<String?> scanPickedQrImage() async {
  final ImagePicker picker = ImagePicker();

  final XFile? pickedImage = await picker.pickImage(
    source: ImageSource.gallery,
  );

  final qrCode = QrCode();

  if (pickedImage == null) {
    return null;
  }

  if (Platform.isWindows) {
    Uint8List data = await pickedImage.readAsBytes();

    final ui.Codec codec = await ui.instantiateImageCodec(data);

    final ui.FrameInfo frameInfo = await codec.getNextFrame();

    final ui.Image image = frameInfo.image;

    final byteData =
        (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!
            .buffer
            .asUint8List();

    qrCode.scanRgbaBytes(byteData, image.width, image.height);

    return qrCode.content?.text;
  }

  return null;
}

//