import 'dart:async';

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
  State<DocumentAudio> createState() => DocumentAudioState();
}

class DocumentAudioState extends State<DocumentAudio> {
  AudioPlayer? _player;
  bool _isLoading = true;
  bool _isPlaying = false;
  bool _shutDown = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _errorMessage;

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  /// Stops playback, cancels subscriptions, and disposes the native player.
  /// Must be awaited before the widget is removed from the tree (e.g. before
  /// popping a dialog) to avoid the just_audio_windows threading crash.
  Future<void> shutdown() async {
    if (_shutDown) return;
    _shutDown = true;

    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    final player = _player;
    _player = null;

    if (player != null) {
      try {
        await player.stop();
      } catch (_) {}
      try {
        await player.dispose();
      } catch (_) {}
    }
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _subscriptions.add(
      _player!.playerStateStream.listen((state) {
        if (_shutDown || !mounted) return;
        final playing =
            state.playing && state.processingState != ProcessingState.completed;
        setState(() {
          _isPlaying = playing;
        });
        if (state.processingState == ProcessingState.completed) {
          _player?.seek(Duration.zero).then((_) => _player?.pause());
        }
      }),
    );
    _subscriptions.add(
      _player!.positionStream.listen((pos) {
        if (_shutDown || !mounted) return;
        setState(() {
          _position = pos;
        });
      }),
    );
    _subscriptions.add(
      _player!.durationStream.listen((dur) {
        if (_shutDown || !mounted) return;
        if (dur != null) {
          setState(() {
            _duration = dur;
          });
        }
      }),
    );
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      final file = await downloadAndDecryptFile(
        documentId: widget.documentId,
        decrypt: widget.decrypt,
      );
      if (_shutDown || !mounted) return;
      if (file != null) {
        try {
          await _player?.setFilePath(file.path);
        } catch (e) {
          if (kDebugMode) {
            print("Error setting file path: $e");
          }
          if (_shutDown || !mounted) return;
          _errorMessage = 'Fehler beim Laden';
        }
      } else {
        _errorMessage = 'Fehler beim Laden';
      }
    } catch (e) {
      if (_shutDown || !mounted) return;
      _errorMessage = 'Fehler: $e';
    } finally {
      if (!_shutDown && mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Fallback: if shutdown() was not called explicitly, clean up now.
    if (!_shutDown) {
      _shutDown = true;
      for (final sub in _subscriptions) {
        sub.cancel();
      }
      _subscriptions.clear();
      final player = _player;
      _player = null;
      if (player != null) {
        player.stop().then((_) => player.dispose()).ignore();
      }
    }
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

    final progress = _duration.inMilliseconds > 0
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
                _player?.pause();
              } else {
                _player?.play();
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
                    onChanged: (value) {
                      if (_duration.inMilliseconds > 0) {
                        final position = Duration(
                          milliseconds: (value * _duration.inMilliseconds)
                              .round(),
                        );
                        _player?.seek(position);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        _formatDuration(_duration),
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
