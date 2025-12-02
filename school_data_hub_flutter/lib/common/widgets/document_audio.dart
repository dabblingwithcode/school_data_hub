import 'dart:io';

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
          _isPlaying = state.playing &&
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
          await _player.setFilePath(file.path);
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
            color: AppColors.backgroundColor.withValues(alpha: 0.2)),
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

