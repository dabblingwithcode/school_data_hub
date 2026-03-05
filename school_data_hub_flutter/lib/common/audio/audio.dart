/// Audio feature module.
///
/// Provides audio playback functionality:
/// - [AudioPlayerService] - manages audio loading and playback
/// - [AudioPlayerWidget] - displays audio controls
/// - [AudioButton] - thumbnail button with pre-loading
/// - [isAudioDocument], [parseDurationFromDocumentId], [formatDuration] - helpers
library;

// Data
export 'data/audio_player_service.dart';
// Domain
export 'domain/audio_helper.dart';
// Presentation
export 'presentation/audio_button.dart';
export 'presentation/audio_player_widget.dart';
export 'presentation/widgets/audio_controls.dart';
export 'presentation/widgets/audio_error_display.dart';
export 'presentation/widgets/audio_loading_indicator.dart';
export 'presentation/widgets/audio_player_overlay.dart';
export 'presentation/widgets/audio_thumbnail.dart';
