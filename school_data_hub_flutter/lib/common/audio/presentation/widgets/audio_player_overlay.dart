import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/audio/data/audio_player_service.dart';
import 'package:school_data_hub_flutter/common/audio/presentation/audio_player_widget.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

/// An overlay that hosts an audio player with document metadata.
class AudioPlayerOverlay extends StatefulWidget {
  const AudioPlayerOverlay({
    required this.audioPlayerService,
    required this.createdBy,
    required this.createdAt,
    required this.onClose,
    super.key,
  });

  /// Pre-initialized [AudioPlayerService] for playback.
  final AudioPlayerService audioPlayerService;

  /// Who created the audio recording.
  final String createdBy;

  /// When the audio was created.
  final DateTime createdAt;

  /// Callback when the overlay should be closed.
  final VoidCallback onClose;

  @override
  State<AudioPlayerOverlay> createState() => _AudioPlayerOverlayState();
}

class _AudioPlayerOverlayState extends State<AudioPlayerOverlay> {
  @override
  void dispose() {
    widget.audioPlayerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Audioaufnahme',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(4),
                  Text(
                    '${widget.createdBy}, ${widget.createdAt.formatDateForUser()}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Gap(16),
                  AudioPlayerWidget(
                    audioPlayerService: widget.audioPlayerService,
                    autoPlay: true,
                  ),
                  const Gap(16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: widget.onClose,
                      child: const Text('Schließen'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows an audio player overlay as an [OverlayEntry].
void showAudioPlayerOverlay(
  BuildContext context, {
  required AudioPlayerService audioPlayerService,
  required String createdBy,
  required DateTime createdAt,
}) {
  final overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;

  void removeOverlay() {
    final entry = overlayEntry;
    if (entry == null) return;
    overlayEntry = null;
    entry.remove();
    entry.dispose();
  }

  overlayEntry = OverlayEntry(
    builder: (context) => AudioPlayerOverlay(
      audioPlayerService: audioPlayerService,
      createdBy: createdBy,
      createdAt: createdAt,
      onClose: removeOverlay,
    ),
  );

  overlayState.insert(overlayEntry!);
}
