import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';

void setAvatar({
  required BuildContext context,
  required PupilProxy pupil,
}) async {
  XFile? image;
  if (Platform.isWindows) {
    ImageSource source =
        ImageSource.gallery; // or ImageSource.camera based on your requirement
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;
    image = await picker.getImageFromSource(
      source: source,
      // options: ImagePickerOptions(
      //   maxWidth: maxWidth,
      //   maxHeight: maxHeight,
      //   imageQuality: quality,
      // ),
    );
    if (image == null) {
      return;
    }
  } else {
    image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: Platform.isWindows
          ? CameraDevice.front
          : CameraDevice.rear,
    );
    if (image == null) {
      return;
    }
  }
  if (!context.mounted) {
    return;
  }
  File? imageFile = await Navigator.push<File?>(
    context,
    MaterialPageRoute<File?>(builder: (context) => CropAvatarView(image: image!)),
  );
  if (imageFile == null) {
    return;
  }

  PupilMutator().updatePupilDocument(
    imageFile: imageFile,
    pupilProxy: pupil,
    documentType: PupilDocumentType.avatar,
  );
}

class CropAvatarView extends StatefulWidget {
  final XFile image;

  const CropAvatarView({super.key, required this.image});

  @override
  State<CropAvatarView> createState() => _CropAvatarState();
}

class _CropAvatarState extends State<CropAvatarView> {
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    // appBar: AppBar(
    //   title: Text('Gesicht zentrieren'),
    // ),
    body: Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
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

  Widget _buildButtons() => SizedBox(
    height: 60,
    child: Row(
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
        TextButton(onPressed: _finished, child: const Text('Fertig')),
      ],
    ),
  );

  Future<void> _rotateLeft() async => controller.rotateLeft();

  Future<void> _rotateRight() async => controller.rotateRight();

  Future<void> _finished() async {
    //final image = await controller.croppedImage();
    final bitmap = await controller.croppedBitmap(
      maxSize: 300,
      quality: FilterQuality.low,
    );
    final imageBytes = await bitmap.toByteData(format: ImageByteFormat.png);
    final file = await imageToFile(bytes: imageBytes!);
    if (context.mounted) {
      final localContext = context;
      Navigator.pop(localContext, file);
    }
  }

  static Future<File> imageToFile({required ByteData bytes}) async {
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/temporaryProfile.jpeg');
    await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
    );
    return file;
  }
}
