import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/audio/domain/audio_helper.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

/// Audio playback controls with play/pause button, progress slider, and time display.
class AudioControls extends StatelessWidget {
  const AudioControls({
    required this.isPlaying,
    required this.progress,
    required this.position,
    required this.duration,
    required this.onPlayPause,
    required this.onSeek,
    super.key,
  });

  final bool isPlaying;
  final double progress;
  final Duration position;
  final Duration duration;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.interactiveColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.interactiveColor.withValues(alpha: 0.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: AppColors.interactiveColor,
            ),
            onPressed: onPlayPause,
            iconSize: 28,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.interactiveColor,
                    inactiveTrackColor: AppColors.interactiveColor.withValues(
                      alpha: 0.15,
                    ),
                    thumbColor: AppColors.interactiveColor,
                    overlayColor: AppColors.interactiveColor.withValues(
                      alpha: 0.2,
                    ),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 14,
                    ),
                  ),
                  child: Slider(
                    value: progress.clamp(0.0, 1.0),
                    onChanged: onSeek,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(position),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        formatDuration(duration),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
