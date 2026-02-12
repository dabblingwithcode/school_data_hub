import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

/// Shows a dialog that records audio from the microphone.
/// Returns the recorded [File] or `null` if the user cancelled.
Future<({File? file, String? fileInfo})?> recordAudioFile(
  BuildContext context,
) {
  return showDialog<({File? file, String? fileInfo})>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const _AudioRecordDialog(),
  );
}

enum _RecordState { idle, recording, done }

/// Simple flag class that won't be auto-disposed by createOnce
class _ShutdownFlag {
  bool value = false;
}

class _AudioRecordDialog extends WatchingWidget {
  const _AudioRecordDialog();

  @override
  Widget build(BuildContext context) {
    // Use a simple flag (not ValueNotifier) to avoid disposal issues
    // Created FIRST so it's disposed LAST (createOnce disposes in reverse order)
    final isShutDown = createOnce(() => _ShutdownFlag());

    // State notifiers - created early so they're disposed late
    final state = createOnce(() => ValueNotifier(_RecordState.idle));
    final elapsed = createOnce(() => ValueNotifier(Duration.zero));
    final filePath = createOnce(() => ValueNotifier<String?>(null));
    final errorMessage = createOnce(() => ValueNotifier<String?>(null));
    final recordingTimer = createOnce(() => ValueNotifier<Timer?>(null));

    // Player state notifiers for preview
    final isPlaying = createOnce(() => ValueNotifier(false));
    final position = createOnce(() => ValueNotifier(Duration.zero));
    final duration = createOnce(() => ValueNotifier(Duration.zero));

    // Create recorder and player AFTER ValueNotifiers
    // So they're disposed FIRST (reverse order), setting isShutDown before
    // ValueNotifiers are disposed
    final recorder = createOnce(
      () => AudioRecorder(),
      dispose: (r) {
        isShutDown.value = true;
        r.dispose();
      },
    );
    final player = createOnce(
      () => AudioPlayer(),
      dispose: (p) {
        isShutDown.value = true;
        p.stop().then((_) => p.dispose()).ignore();
      },
    );

    // Watch all state notifiers
    final currentState = watch(state).value;
    final currentElapsed = watch(elapsed).value;
    final error = watch(errorMessage).value;
    final playing = watch(isPlaying).value;
    final pos = watch(position).value;
    final dur = watch(duration).value;

    // Register stream handlers for player state changes (for preview)
    // Wrap entire handler in try-catch to handle race conditions during disposal
    registerStreamHandler(
      target: player,
      select: (AudioPlayer p) => p.playerStateStream,
      handler: (context, snapshot, cancel) {
        try {
          if (isShutDown.value || !snapshot.hasData) return;
          final playerState = snapshot.data!;
          final nowPlaying =
              playerState.playing &&
              playerState.processingState != ProcessingState.completed;
          isPlaying.value = nowPlaying;
          if (playerState.processingState == ProcessingState.completed) {
            player.seek(Duration.zero).then((_) => player.pause()).ignore();
          }
        } catch (_) {
          // Ignore errors during disposal
        }
      },
    );

    registerStreamHandler(
      target: player,
      select: (AudioPlayer p) => p.positionStream,
      handler: (context, snapshot, cancel) {
        try {
          if (isShutDown.value || !snapshot.hasData) return;
          position.value = snapshot.data!;
        } catch (_) {
          // Ignore errors during disposal
        }
      },
    );

    registerStreamHandler(
      target: player,
      select: (AudioPlayer p) => p.durationStream,
      handler: (context, snapshot, cancel) {
        try {
          if (isShutDown.value || !snapshot.hasData) return;
          if (snapshot.data != null) {
            duration.value = snapshot.data!;
          }
        } catch (_) {
          // Ignore errors during disposal
        }
      },
    );

    // Cleanup timer on dispose (recorder/player handled by createOnce dispose)
    onDispose(() {
      recordingTimer.value?.cancel();
    });

    // Helper functions
    Future<void> startRecording() async {
      final hasPermission = await recorder.hasPermission();
      if (!hasPermission) {
        errorMessage.value = 'Mikrofonberechtigung wurde nicht erteilt.';
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final path = p.join(
        tempDir.path,
        'recording_${DateTime.now().millisecondsSinceEpoch}.m4a',
      );

      await recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );

      filePath.value = path;
      elapsed.value = Duration.zero;
      recordingTimer.value = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsed.value = elapsed.value + const Duration(seconds: 1);
      });

      state.value = _RecordState.recording;
      errorMessage.value = null;
    }

    Future<void> stopRecording() async {
      recordingTimer.value?.cancel();
      final path = await recorder.stop();

      if (path != null) {
        filePath.value = path;
        // Load the recorded file into the player for preview
        await player.setFilePath(path);
      }

      state.value = _RecordState.done;
    }

    void cancel() {
      // Stop playback if playing
      player.stop();
      // Clean up temp file if it exists
      final path = filePath.value;
      if (path != null) {
        final file = File(path);
        if (file.existsSync()) {
          file.deleteSync();
        }
      }
      Navigator.of(context).pop();
    }

    void confirm() {
      final path = filePath.value;
      if (path != null) {
        // Stop playback before confirming
        player.stop();
        Navigator.of(
          context,
        ).pop((file: File(path), fileInfo: _formatDuration(currentElapsed)));
      }
    }

    void togglePlayback() {
      if (playing) {
        player.pause();
      } else {
        player.play();
      }
    }

    // Build state content
    Widget buildStateContent() {
      switch (currentState) {
        case _RecordState.idle:
          return Column(
            key: const ValueKey('idle'),
            children: [
              Icon(
                Icons.mic,
                size: 48,
                color: AppColors.interactiveColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 8),
              const Text('Auf Aufnahme tippen, um zu starten.'),
            ],
          );
        case _RecordState.recording:
          return Column(
            key: const ValueKey('recording'),
            children: [
              const Icon(Icons.mic, size: 48, color: Colors.red),
              const SizedBox(height: 8),
              Text(
                _formatDuration(currentElapsed),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Aufnahme läuft...',
                style: TextStyle(color: Colors.red),
              ),
            ],
          );
        case _RecordState.done:
          final progress = dur.inMilliseconds > 0
              ? pos.inMilliseconds / dur.inMilliseconds
              : 0.0;
          return Column(
            key: const ValueKey('done'),
            children: [
              Icon(Icons.check_circle, size: 48, color: Colors.green.shade600),
              const SizedBox(height: 8),
              Text(
                _formatDuration(currentElapsed),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text('Aufnahme fertig!'),
              const SizedBox(height: 12),
              // Audio preview player
              Container(
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
                        playing ? Icons.pause : Icons.play_arrow,
                        color: AppColors.interactiveColor,
                      ),
                      onPressed: togglePlayback,
                      iconSize: 28,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.interactiveColor,
                              inactiveTrackColor: AppColors.interactiveColor
                                  .withValues(alpha: 0.15),
                              thumbColor: AppColors.interactiveColor,
                              overlayColor: AppColors.interactiveColor
                                  .withValues(alpha: 0.2),
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
                                if (dur.inMilliseconds > 0) {
                                  final newPosition = Duration(
                                    milliseconds: (value * dur.inMilliseconds)
                                        .round(),
                                  );
                                  player.seek(newPosition);
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
                                  _formatDuration(pos),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  _formatDuration(dur),
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
              ),
            ],
          );
      }
    }

    // Build actions
    List<Widget> buildActions() {
      switch (currentState) {
        case _RecordState.idle:
          return [
            TextButton(onPressed: cancel, child: const Text('Abbrechen')),
            ElevatedButton.icon(
              onPressed: startRecording,
              icon: const Icon(Icons.mic),
              label: const Text('Aufnahme'),
            ),
          ];
        case _RecordState.recording:
          return [
            TextButton(onPressed: cancel, child: const Text('Abbrechen')),
            ElevatedButton.icon(
              onPressed: stopRecording,
              icon: const Icon(Icons.stop),
              label: const Text('Stopp'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ];
        case _RecordState.done:
          return [
            TextButton(onPressed: cancel, child: const Text('Verwerfen')),
            ElevatedButton.icon(
              onPressed: confirm,
              icon: const Icon(Icons.check),
              label: const Text('Speichern'),
            ),
          ];
      }
    }

    return AlertDialog(
      title: const Text('Audio aufnehmen'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: buildStateContent(),
          ),
        ],
      ),
      actions: buildActions(),
    );
  }
}

String _formatDuration(Duration d) {
  final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
