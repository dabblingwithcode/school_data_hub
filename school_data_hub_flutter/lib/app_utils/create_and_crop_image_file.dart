import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:watch_it/watch_it.dart';

Future<File?> createAndCropImageFile(context) async {
  XFile? image = await ImagePicker().pickImage(
    source: Platform.isWindows || Platform.isMacOS
        ? ImageSource.gallery
        : ImageSource.camera,
    preferredCameraDevice: Platform.isWindows
        ? CameraDevice.front
        : CameraDevice.rear,
  );
  if (image == null) {
    return null;
  }

  File imageFile = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CropAvatarView(image: image)),
  );
  return imageFile;
}

class CropAvatarView extends WatchingWidget {
  final XFile image;
  const CropAvatarView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final controller = createOnce(
      () => CropController(
        aspectRatio: 21.0 / 29.7,
        defaultCrop: const Rect.fromLTRB(0, 0, 1, 1),
      ),
      dispose: (controller) => controller.dispose(),
    );

    Future<void> finished() async {
      final bitmap = await controller.croppedBitmap(
        maxSize: 800,
        quality: FilterQuality.medium,
      );
      final imageBytes = await bitmap.toByteData(format: ImageByteFormat.png);
      if (imageBytes == null) return;
      final file = await _imageToFile(bytes: imageBytes);
      if (context.mounted) {
        Navigator.pop(context, file);
      }
    }

    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: CropImage(
            controller: controller,
            image: Image.file(File(image.path)),
            paddingSize: 0,
            alwaysMove: true,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.rotate_90_degrees_ccw_outlined),
              onPressed: controller.rotateLeft,
            ),
            IconButton(
              icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
              onPressed: controller.rotateRight,
            ),
            TextButton(onPressed: finished, child: const Text('Fertig')),
          ],
        ),
      ),
    );
  }

  static Future<File> _imageToFile({required ByteData bytes}) async {
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File(p.join(tempPath, 'temporaryProfile.jpeg'));
    await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
    );
    return file;
  }
}
