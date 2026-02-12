import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:school_data_hub_flutter/common/audio/data/audio_player_service.dart';
import 'package:school_data_hub_flutter/common/audio/presentation/widgets/audio_controls.dart';
import 'package:school_data_hub_flutter/common/audio/presentation/widgets/audio_error_display.dart';
import 'package:school_data_hub_flutter/common/audio/presentation/widgets/audio_loading_indicator.dart';

/// Simple flag class that won't be auto-disposed by createOnce.
class _ShutdownFlag {
  bool value = false;
}

/// A widget that displays audio playback controls.
///
/// Takes a pre-initialized [AudioPlayerService] for playback.
class AudioPlayerWidget extends WatchingWidget {
  const AudioPlayerWidget({
    required this.audioPlayerService,
    this.autoPlay = false,
    super.key,
  });

  /// Pre-initialized [AudioPlayerService] for playback.
  /// The caller is responsible for disposing the service.
  final AudioPlayerService audioPlayerService;

  /// If true, playback starts automatically.
  final bool autoPlay;

  @override
  Widget build(BuildContext context) {
    final service = audioPlayerService;
    final player = service.player;

    // Use a simple flag (not ValueNotifier) to avoid disposal issues
    // Created FIRST so it's disposed LAST (createOnce disposes in reverse order)
    final isShutDown = createOnce(() => _ShutdownFlag());

    // State notifiers for playback
    final isPlaying = createOnce(() => ValueNotifier(false));
    final position = createOnce(() => ValueNotifier(Duration.zero));
    final duration = createOnce(() => ValueNotifier(Duration.zero));

    // Watch service state
    final loading = watch(service.isLoading).value;
    final error = watch(service.errorMessage).value;

    // Watch playback state
    final playing = watch(isPlaying).value;
    final pos = watch(position).value;
    final dur = watch(duration).value;

    // Register stream handlers for player state changes
    registerStreamHandler(
      target: player,
      select: (AudioPlayer p) => p.playerStateStream,
      handler: (context, snapshot, cancel) {
        if (isShutDown.value || !snapshot.hasData) return;
        final state = snapshot.data!;
        final nowPlaying =
            state.playing && state.processingState != ProcessingState.completed;
        isPlaying.value = nowPlaying;
        if (state.processingState == ProcessingState.completed) {
          player.seek(Duration.zero).then((_) => player.pause());
        }
      },
    );

    registerStreamHandler(
      target: player,
      select: (AudioPlayer p) => p.positionStream,
      handler: (context, snapshot, cancel) {
        if (isShutDown.value || !snapshot.hasData) return;
        position.value = snapshot.data!;
      },
    );

    registerStreamHandler(
      target: player,
      select: (AudioPlayer p) => p.durationStream,
      handler: (context, snapshot, cancel) {
        if (isShutDown.value || !snapshot.hasData) return;
        if (snapshot.data != null) {
          duration.value = snapshot.data!;
        }
      },
    );

    // Auto-play if requested and ready
    if (autoPlay) {
      callOnce((_) async {
        if (service.isReady.value && !isShutDown.value) {
          await service.play();
        }
      });
    }

    if (loading) {
      return const AudioLoadingIndicator();
    }

    if (error != null) {
      return AudioErrorDisplay(message: error);
    }

    final progress = dur.inMilliseconds > 0
        ? pos.inMilliseconds / dur.inMilliseconds
        : 0.0;

    return AudioControls(
      isPlaying: playing,
      progress: progress,
      position: pos,
      duration: dur,
      onPlayPause: () {
        if (playing) {
          service.pause();
        } else {
          service.play();
        }
      },
      onSeek: (value) {
        if (dur.inMilliseconds > 0) {
          final newPosition = Duration(
            milliseconds: (value * dur.inMilliseconds).round(),
          );
          service.seek(newPosition);
        }
      },
    );
  }
}
