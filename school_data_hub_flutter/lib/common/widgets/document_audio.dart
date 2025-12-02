import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:school_data_hub_flutter/app_utils/download_and_decrypt_file.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class DocumentAudio extends StatefulWidget {
  const DocumentAudio({
    required this.documentId,
    required this.decrypt,
    super.key,
  });

  final String documentId;
  final bool decrypt;

  @override
  State<DocumentAudio> createState() => _DocumentAudioState();
}

class _DocumentAudioState extends State<DocumentAudio> {
  final AudioPlayer _player = AudioPlayer();
  bool _isLoading = true;
  bool _isPlaying = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAudio();
    _player.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying =
              state.playing &&
              state.processingState != ProcessingState.completed;
        });
      }
    });
  }

  Future<void> _loadAudio() async {
    try {
      final file = await downloadAndDecryptFile(
        documentId: widget.documentId,
        decrypt: widget.decrypt,
      );
      if (mounted) {
        if (file != null) {
          // Use LockCachingAudioSource to avoid platform channel threading issues on Windows
          // and for better performance with potentially large files.
          // However, since we already have a decrypted file, we can just use AudioSource.file
          // But given the threading errors, we might need to be careful.
          // The errors "channel sent a message from native to Flutter on a non-platform thread"
          // are usually harmless warnings in recent Flutter versions on Windows with just_audio,
          // but "Broadcast playback event error" suggests an issue.
          // Let's try wrap in try-catch for setFilePath and use AudioSource.file explicitly.

          try {
            await _player.setFilePath(file.path);
          } catch (e) {
            if (kDebugMode) {
              print("Error setting file path: $e");
            }
            // Fallback or retry if needed, but usually setFilePath is robust.
            throw e;
          }
        } else {
          _errorMessage = 'Fehler beim Laden';
        }
      }
    } catch (e) {
      if (mounted) {
        _errorMessage = 'Fehler: $e';
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (_errorMessage != null) {
      return Text(_errorMessage!, style: const TextStyle(color: Colors.red));
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.backgroundColor.withValues(alpha: 0.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (_isPlaying) {
                _player.pause();
              } else {
                _player.play();
              }
            },
          ),
        ],
      ),
    );
  }
}
