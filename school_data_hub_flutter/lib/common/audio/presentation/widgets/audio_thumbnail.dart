import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/audio/domain/audio_helper.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

/// A small thumbnail for audio files that displays an icon and duration.
///
/// The duration is parsed from the documentId format:
/// "00-01_839400e1-12c2-4d3a-894f-a715eac9b1ee.m4a"
class AudioThumbnail extends StatelessWidget {
  const AudioThumbnail({
    required this.documentId,
    this.size = 70,
    super.key,
  });

  final String documentId;
  final double size;

  @override
  Widget build(BuildContext context) {
    final duration = parseDurationFromDocumentId(documentId);

    return SizedBox(
      height: size,
      width: (21 / 30) * size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.interactiveColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.interactiveColor.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.record_voice_over_rounded,
              size: size * 0.43,
              color: AppColors.interactiveColor,
            ),
            const SizedBox(height: 2),
            Text(
              duration,
              style: TextStyle(
                fontSize: size * 0.14,
                fontWeight: FontWeight.bold,
                color: AppColors.interactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
