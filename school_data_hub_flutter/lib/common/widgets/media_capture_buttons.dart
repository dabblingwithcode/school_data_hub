import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/app_utils/record_audio_file.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

/// A reusable camera button that captures and crops an image.
///
/// When pressed, opens the camera/gallery, allows the user to crop the image,
/// and executes the [onFileCaptured] callback with the resulting file.
class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
    required this.onFileCaptured,
    this.iconSize = 16,
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.all(8),
  });

  /// Callback executed when a file is successfully captured and cropped.
  /// The callback receives the captured [File] or null if cancelled.
  final void Function(File? file) onFileCaptured;

  /// Size of the camera icon. Defaults to 16.
  final double iconSize;

  /// Background color of the button. Defaults to [AppColors.backgroundColor].
  final Color? backgroundColor;

  /// Color of the camera icon. Defaults to [Colors.white].
  final Color iconColor;

  /// Padding inside the button. Defaults to EdgeInsets.all(8).
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final File? file = await createAndCropImageFile(context);
        onFileCaptured(file);
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.camera_alt_rounded, size: iconSize, color: iconColor),
      ),
    );
  }
}

/// A reusable microphone button that records audio.
///
/// When pressed, opens the audio recording dialog and executes the
/// [onFileRecorded] callback with the resulting file and optional file info.
class MicButton extends StatelessWidget {
  const MicButton({
    super.key,
    required this.onFileRecorded,
    this.iconSize = 16,
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.all(8),
    this.enabled = true,
  });

  /// Callback executed when an audio file is successfully recorded.
  /// The callback receives the recorded [File] and optional [String] file info,
  /// or null if cancelled.
  final void Function(File? file, String? fileInfo) onFileRecorded;

  /// Size of the microphone icon. Defaults to 16.
  final double iconSize;

  /// Background color of the button. Defaults to [AppColors.backgroundColor].
  final Color? backgroundColor;

  /// Color of the microphone icon. Defaults to [Colors.white].
  final Color iconColor;

  /// Padding inside the button. Defaults to EdgeInsets.all(8).
  final EdgeInsets padding;

  /// Whether the button is enabled. Defaults to true.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled
          ? () async {
              final result = await recordAudioFile(context);
              if (result != null) {
                onFileRecorded(result.file, result.fileInfo);
              } else {
                onFileRecorded(null, null);
              }
            }
          : null,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.mic, size: iconSize, color: iconColor),
      ),
    );
  }
}

class MediaCaptureButtons extends StatelessWidget {
  const MediaCaptureButtons({
    super.key,
    required this.onFileCaptured,
    required this.onFileRecorded,
    this.iconSize = 10,
    this.backgroundColor,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.all(11),
    this.micEnabled = true,
  });

  final void Function(File? file) onFileCaptured;
  final void Function(File? file, String? fileInfo) onFileRecorded;
  final double iconSize;
  final Color? backgroundColor;
  final Color iconColor;
  final EdgeInsets padding;
  final bool micEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CameraButton(
            onFileCaptured: onFileCaptured,
            iconSize: iconSize,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            padding: padding,
          ),
          const SizedBox(width: 20),
          MicButton(
            onFileRecorded: onFileRecorded,
            iconSize: iconSize,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            padding: padding,
            enabled: micEnabled,
          ),
        ],
      ),
    );
  }
}
