import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> uploadImageFile(context) async {
  XFile? image = await ImagePicker().pickImage(
      source: Platform.isWindows ? ImageSource.gallery : ImageSource.camera,
      preferredCameraDevice:
          Platform.isWindows ? CameraDevice.front : CameraDevice.rear);
  if (image == null) {
    return null;
  }

  // final MemoryImage? image = await Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => CropImagePage(image: xFile)),
  // );
  // if (image == null) {
  //   return null;
  // }
  // final imageFile = memoryImageToFile(image);
  // return imageFile;

  File imageFile = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CropAvatarView(image: image)),
  );
  return imageFile;
}

class CropAvatarView extends StatefulWidget {
  final XFile image;
  const CropAvatarView({super.key, required this.image});
  @override
  State<CropAvatarView> createState() => _CropAvatarState();
}

class _CropAvatarState extends State<CropAvatarView> {
  final controller = CropController(
    aspectRatio: 21.0 / 29.7,
    defaultCrop: const Rect.fromLTRB(0, 0, 1, 1),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   title: Text('Gesicht zentrieren'),
        // ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: CropImage(
              controller: controller,
              image: Image.file(File(widget.image.path)),
              paddingSize: 0,
              alwaysMove: true,
            ),
          ),
        ),
        bottomNavigationBar: _buildButtons(),
      );

  Widget _buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.rotate_90_degrees_ccw_outlined),
            onPressed: _rotateLeft,
          ),
          IconButton(
            icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
            onPressed: _rotateRight,
          ),
          TextButton(
            onPressed: _finished,
            child: const Text('Fertig'),
          ),
        ],
      );

  // Future<void> _aspectRatios() async {
  //   final value = await showDialog<double>(
  //     context: context,
  //     builder: (context) {
  //       return SimpleDialog(
  //         title: const Text('Select aspect ratio'),
  //         children: [
  //           // special case: no aspect ratio
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, -1.0),
  //             child: const Text('free'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 1.0),
  //             child: const Text('square'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 2.0),
  //             child: const Text('2:1'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 1 / 2),
  //             child: const Text('1:2'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 4.0 / 3.0),
  //             child: const Text('4:3'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 16.0 / 9.0),
  //             child: const Text('16:9'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   if (value != null) {
  //     controller.aspectRatio = value == -1 ? null : value;
  //     controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
  //   }
  // }

  Future<void> _rotateLeft() async => controller.rotateLeft();

  Future<void> _rotateRight() async => controller.rotateRight();

  Future<void> _finished() async {
    //final image = await controller.croppedImage();
    final bitmap = await controller.croppedBitmap(
      maxSize: 800,
      quality: FilterQuality.medium,
    );
    final imageBytes = await bitmap.toByteData(format: ImageByteFormat.png);
    final file = await imageToFile(bytes: imageBytes!);
    if (mounted) {
      Navigator.pop(context, file);
      controller.dispose();
    }

    // ignore: use_build_context_synchronously
    // await showDialog<bool>(
    //   context: context,
    //   builder: (context) {
    //     return SimpleDialog(
    //       contentPadding: const EdgeInsets.all(6.0),
    //       titlePadding: const EdgeInsets.all(8.0),
    //       title: const Text('Cropped image'),
    //       children: [
    //         Text('relative: ${controller.crop}'),
    //         Text('pixels: ${controller.cropSize}'),
    //         const SizedBox(height: 5),
    //         image,
    //         TextButton(
    //           onPressed: () => Navigator.pop(context, true),
    //           child: const Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  static Future<File> imageToFile({required ByteData bytes}) async {
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/temporaryProfile.jpeg');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }
}

Future<File> memoryImageToFile(MemoryImage memoryImage) async {
  // Get the bytes from the MemoryImage

  Uint8List bytes = memoryImage.bytes;

  // Get the temporary directory
  Directory tempDir = await getTemporaryDirectory();

  // Create a unique file path
  String filePath =
      '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';

  // Write the bytes to the file
  File file = File(filePath);
  await file.writeAsBytes(bytes);

  return file;
}
