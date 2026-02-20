import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:school_data_hub_flutter/app_utils/download_and_decrypt_file.dart';

/// Service for managing audio playback with pre-loading capability.
///
/// This service handles downloading, decrypting, and loading audio files
/// into an [AudioPlayer] instance. It supports pre-loading audio before
/// showing the player UI for a smoother user experience.
class AudioPlayerService {
  AudioPlayerService({AudioPlayer? player}) : _player = player ?? AudioPlayer();

  final AudioPlayer _player;

  AudioPlayer get player => _player;

  final _isLoading = ValueNotifier<bool>(true);
  ValueListenable<bool> get isLoading => _isLoading;

  final _errorMessage = ValueNotifier<String?>(null);
  ValueListenable<String?> get errorMessage => _errorMessage;

  final _isReady = ValueNotifier<bool>(false);
  ValueListenable<bool> get isReady => _isReady;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  // ignore: unused_field
  File? _loadedFile;

  /// Loads audio from the given [documentId].
  ///
  /// If [decrypt] is true, the file will be decrypted after download.
  /// Returns true if loading was successful, false otherwise.
  Future<bool> loadAudio({
    required String documentId,
    required bool decrypt,
  }) async {
    if (_isDisposed) return false;

    _isLoading.value = true;
    _errorMessage.value = null;
    _isReady.value = false;

    try {
      final file = await downloadAndDecryptFile(
        documentId: documentId,
        decrypt: decrypt,
      );

      if (_isDisposed) return false;

      if (file != null) {
        try {
          await _player.setFilePath(file.path);
          _loadedFile = file;
          _isReady.value = true;
          return true;
        } catch (e) {
          if (kDebugMode) {
            print("Error setting file path: $e");
          }
          if (_isDisposed) return false;
          _errorMessage.value = 'Fehler beim Laden';
          return false;
        }
      } else {
        _errorMessage.value = 'Fehler beim Laden';
        return false;
      }
    } catch (e) {
      if (_isDisposed) return false;
      _errorMessage.value = 'Fehler: $e';
      return false;
    } finally {
      if (!_isDisposed) {
        _isLoading.value = false;
      }
    }
  }

  /// Starts playback if audio is ready.
  Future<void> play() async {
    if (_isDisposed || !_isReady.value) return;
    await _player.play();
  }

  /// Pauses playback.
  Future<void> pause() async {
    if (_isDisposed) return;
    await _player.pause();
  }

  /// Stops playback and resets position.
  Future<void> stop() async {
    if (_isDisposed) return;
    await _player.stop();
  }

  /// Seeks to the given [position].
  Future<void> seek(Duration position) async {
    if (_isDisposed) return;
    await _player.seek(position);
  }

  /// Disposes of the player and cleans up resources.
  Future<void> dispose() async {
    if (_isDisposed) return;
    _isDisposed = true;

    await _player.stop();
    await _player.dispose();
  }
}
