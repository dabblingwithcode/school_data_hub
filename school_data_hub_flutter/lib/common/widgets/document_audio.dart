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
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAudio();
    _player.playerStateStream.listen((state) {
      if (!mounted) return;
      final playing =
          state.playing &&
          state.processingState != ProcessingState.completed;
      setState(() {
        _isPlaying = playing;
      });
      // Seek to start when playback completes so the user can replay.
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
    _player.positionStream.listen((pos) {
      if (mounted) {
        setState(() {
          _position = pos;
        });
      }
    });
    _player.durationStream.listen((dur) {
      if (mounted && dur != null) {
        setState(() {
          _duration = dur;
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
          try {
            await _player.setFilePath(file.path);
          } catch (e) {
            if (kDebugMode) {
              print("Error setting file path: $e");
            }
            rethrow;
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

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.interactiveColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.interactiveColor.withValues(alpha: 0.2),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.interactiveColor,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Lädt Audio...', style: TextStyle(fontSize: 13)),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    }

    final progress =
        _duration.inMilliseconds > 0
            ? _position.inMilliseconds / _duration.inMilliseconds
            : 0.0;

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
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: AppColors.interactiveColor,
            ),
            onPressed: () {
              if (_isPlaying) {
                _player.pause();
              } else {
                _player.play();
              }
            },
            iconSize: 28,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 4,
                    backgroundColor: AppColors.interactiveColor.withValues(
                      alpha: 0.15,
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.interactiveColor,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_position),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    Text(
                      _formatDuration(_duration),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
