import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class CropImagePage extends StatefulWidget {
  final XFile image;

  const CropImagePage({
    required this.image,
    super.key,
  });

  @override
  CropImagePageState createState() => CropImagePageState();
}

class CropImagePageState extends State<CropImagePage> {
  late CustomImageCropController controller;

  final double _width = 21;
  final double _height = 29.7;

  @override
  void initState() {
    super.initState();
    controller = CustomImageCropController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomImageCrop(
              cropController: controller,
              outlineStrokeWidth: 2,
              // forceInsideCropArea: true,
              image: FileImage(File(widget.image.path)),
              shape: CustomCropShape.Ratio,
              ratio: Ratio(width: _width, height: _height),
              canRotate: true,
              canMove: true,
              canScale: true,
              borderRadius: 0,
              customProgressIndicator: const CupertinoActivityIndicator(),
              outlineColor: Colors.red,
              imageFit: CustomImageFit.fillVisibleWidth,
              imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Gap(10),
              IconButton(
                  icon: const Icon(Icons.refresh), onPressed: controller.reset),
              IconButton(
                  icon: const Icon(Icons.zoom_in),
                  onPressed: () =>
                      controller.addTransition(CropImageData(scale: 1.33))),
              IconButton(
                  icon: const Icon(Icons.zoom_out),
                  onPressed: () =>
                      controller.addTransition(CropImageData(scale: 0.75))),
              IconButton(
                  icon: const Icon(Icons.rotate_left),
                  onPressed: () =>
                      controller.addTransition(CropImageData(angle: -pi / 4))),
              IconButton(
                  icon: const Icon(Icons.rotate_right),
                  onPressed: () =>
                      controller.addTransition(CropImageData(angle: pi / 4))),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
                onPressed: () => Navigator.of(context).pop(null),
              ),
              IconButton(
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                onPressed: () async {
                  final image = await controller.onCropImage();

                  if (image != null && context.mounted) {
                    Navigator.of(context).pop(image);
                  }
                },
              ),
              const Gap(10),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
