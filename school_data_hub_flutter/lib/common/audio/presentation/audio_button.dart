import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/audio/data/audio_player_service.dart';
import 'package:school_data_hub_flutter/common/audio/presentation/widgets/audio_player_overlay.dart';
import 'package:school_data_hub_flutter/common/audio/presentation/widgets/audio_thumbnail.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';

/// A button that displays an audio thumbnail and handles playback.
///
/// On tap, it pre-loads the audio and shows the player overlay.
/// On long press (admin only), it allows deletion of the audio file.
class AudioButton extends StatefulWidget {
  const AudioButton({
    required this.file,
    required this.onDelete,
    super.key,
  });

  /// The audio document to display and play.
  final HubDocument file;

  /// Callback when the audio should be deleted.
  final Future<void> Function(HubDocument file) onDelete;

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  bool _isLoading = false;

  Future<void> _handleTap() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final service = AudioPlayerService();
      final success = await service.loadAudio(
        documentId: widget.file.documentId,
        decrypt: true,
      );

      if (!mounted) {
        await service.dispose();
        return;
      }

      if (success) {
        showAudioPlayerOverlay(
          context,
          audioPlayerService: service,
          createdBy: widget.file.createdBy,
          createdAt: widget.file.createdAt,
        );
      } else {
        await service.dispose();
        if (mounted) {
          di<NotificationService>().showSnackBar(
            NotificationType.error,
            'Audio konnte nicht geladen werden',
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleLongPress() async {
    if (!di<HubSessionManager>().isAdmin) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Nur Admins können Dokumente löschen',
      );
      return;
    }

    final confirm = await confirmationDialog(
      context: context,
      title: 'Audio löschen',
      message: 'Audioaufnahme wirklich löschen?',
    );

    if (confirm == true) {
      await widget.onDelete(widget.file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      onLongPress: _handleLongPress,
      child: Stack(
        children: [
          AudioThumbnail(documentId: widget.file.documentId),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
