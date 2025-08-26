import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

/// Update status with additional context
enum UpdateManagerStatus {
  idle,
  checking,
  downloading,
  updateAvailable,
  upToDate,
  restartRequired,
  error,
  unavailable,
}

/// Update manager for handling Shorebird code push updates
class ShorebirdUpdateManager extends ChangeNotifier {
  static final _log = Logger('ShorebirdUpdateManager');

  final ShorebirdUpdater _updater = ShorebirdUpdater();

  // Status tracking
  UpdateManagerStatus _status = UpdateManagerStatus.idle;
  UpdateTrack _currentTrack = UpdateTrack.stable;
  Patch? _currentPatch;
  String? _errorMessage;
  bool _isInitialized = false;

  // Update availability
  bool _updateAvailable = false;
  DateTime? _lastChecked;

  // Auto-update settings
  bool _autoCheckEnabled = true;
  Duration _autoCheckInterval = const Duration(hours: 6);
  Timer? _autoCheckTimer;

  // Getters
  UpdateManagerStatus get status => _status;
  UpdateTrack get currentTrack => _currentTrack;
  Patch? get currentPatch => _currentPatch;
  String? get errorMessage => _errorMessage;
  bool get isAvailable => _updater.isAvailable;
  bool get isInitialized => _isInitialized;
  bool get updateAvailable => _updateAvailable;
  DateTime? get lastChecked => _lastChecked;
  bool get autoCheckEnabled => _autoCheckEnabled;
  Duration get autoCheckInterval => _autoCheckInterval;

  /// Initialize the update manager
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _log.info('Initializing ShorebirdUpdateManager');

      // Check if Shorebird is available
      if (!_updater.isAvailable) {
        _log.warning('Shorebird updater is not available');
        _setStatus(UpdateManagerStatus.unavailable);
        _isInitialized = true;
        return;
      }

      // Read current patch
      await _readCurrentPatch();

      _setStatus(UpdateManagerStatus.idle);
      _isInitialized = true;

      // Start auto-check if enabled
      if (_autoCheckEnabled) {
        _startAutoCheck();
      }

      _log.info('ShorebirdUpdateManager initialized successfully');
    } catch (error, stackTrace) {
      _log.severe(
        'Failed to initialize ShorebirdUpdateManager',
        error,
        stackTrace,
      );
      _setError('Failed to initialize update manager: $error');
    }
  }

  /// Dispose resources
  @override
  void dispose() {
    _autoCheckTimer?.cancel();
    super.dispose();
  }

  /// Check for updates manually
  Future<bool> checkForUpdate({UpdateTrack? track}) async {
    if (!_updater.isAvailable) {
      _log.warning('Cannot check for updates: Shorebird not available');
      return false;
    }

    final checkTrack = track ?? _currentTrack;

    try {
      _setStatus(UpdateManagerStatus.checking);
      _log.info('Checking for updates on ${checkTrack.name} track');

      final updateStatus = await _updater.checkForUpdate(track: checkTrack);
      _lastChecked = DateTime.now();

      switch (updateStatus) {
        case UpdateStatus.upToDate:
          _log.info('App is up to date');
          _updateAvailable = false;
          _setStatus(UpdateManagerStatus.upToDate);
          return false;

        case UpdateStatus.outdated:
          _log.info('Update available');
          _updateAvailable = true;
          _setStatus(UpdateManagerStatus.updateAvailable);
          return true;

        case UpdateStatus.restartRequired:
          _log.info('Restart required to apply update');
          _setStatus(UpdateManagerStatus.restartRequired);
          return false;

        case UpdateStatus.unavailable:
          _log.warning('Updates unavailable');
          _setStatus(UpdateManagerStatus.unavailable);
          return false;
      }
    } catch (error, stackTrace) {
      _log.severe('Error checking for updates', error, stackTrace);
      _setError('Failed to check for updates: $error');
      return false;
    }
  }

  /// Download and install update
  Future<bool> downloadUpdate({UpdateTrack? track}) async {
    if (!_updater.isAvailable) {
      _log.warning('Cannot download update: Shorebird not available');
      return false;
    }

    final downloadTrack = track ?? _currentTrack;

    try {
      _setStatus(UpdateManagerStatus.downloading);
      _log.info('Downloading update from ${downloadTrack.name} track');

      await _updater.update(track: downloadTrack);

      // Read the new current patch
      await _readCurrentPatch();

      _log.info('Update downloaded successfully');
      _setStatus(UpdateManagerStatus.restartRequired);
      return true;
    } on UpdateException catch (error, stackTrace) {
      _log.severe('Update failed', error, stackTrace);
      _setError('Update failed: ${error.message}');
      return false;
    } catch (error, stackTrace) {
      _log.severe('Unexpected error during update', error, stackTrace);
      _setError('Unexpected error during update: $error');
      return false;
    }
  }

  /// Set the update track
  void setUpdateTrack(UpdateTrack track) {
    if (_currentTrack != track) {
      _currentTrack = track;
      _log.info('Update track changed to ${track.name}');
      notifyListeners();
    }
  }

  /// Enable/disable auto-check for updates
  void setAutoCheckEnabled(bool enabled) {
    if (_autoCheckEnabled != enabled) {
      _autoCheckEnabled = enabled;
      _log.info('Auto-check ${enabled ? 'enabled' : 'disabled'}');

      if (enabled) {
        _startAutoCheck();
      } else {
        _stopAutoCheck();
      }

      notifyListeners();
    }
  }

  /// Set auto-check interval
  void setAutoCheckInterval(Duration interval) {
    if (_autoCheckInterval != interval) {
      _autoCheckInterval = interval;
      _log.info('Auto-check interval set to ${interval.inHours} hours');

      // Restart auto-check with new interval
      if (_autoCheckEnabled) {
        _stopAutoCheck();
        _startAutoCheck();
      }

      notifyListeners();
    }
  }

  /// Clear error state
  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      _setStatus(UpdateManagerStatus.idle);
    }
  }

  /// Get update status summary
  String getStatusDescription() {
    switch (_status) {
      case UpdateManagerStatus.idle:
        return 'Ready to check for updates';
      case UpdateManagerStatus.checking:
        return 'Checking for updates...';
      case UpdateManagerStatus.downloading:
        return 'Downloading update...';
      case UpdateManagerStatus.updateAvailable:
        return 'Update available for download';
      case UpdateManagerStatus.upToDate:
        return 'App is up to date';
      case UpdateManagerStatus.restartRequired:
        return 'Restart required to apply update';
      case UpdateManagerStatus.error:
        return _errorMessage ?? 'An error occurred';
      case UpdateManagerStatus.unavailable:
        return 'Updates not available';
    }
  }

  // Private methods

  Future<void> _readCurrentPatch() async {
    try {
      _currentPatch = await _updater.readCurrentPatch();
      _log.info('Current patch: ${_currentPatch?.number ?? 'none'}');
    } catch (error, stackTrace) {
      _log.warning('Failed to read current patch', error, stackTrace);
      _currentPatch = null;
    }
  }

  void _setStatus(UpdateManagerStatus status) {
    if (_status != status) {
      _status = status;
      _log.fine('Status changed to $status');

      // Clear error when status changes (unless it's an error status)
      if (status != UpdateManagerStatus.error) {
        _errorMessage = null;
      }

      notifyListeners();
    }
  }

  void _setError(String message) {
    _errorMessage = message;
    _setStatus(UpdateManagerStatus.error);
  }

  void _startAutoCheck() {
    _stopAutoCheck();

    _autoCheckTimer = Timer.periodic(_autoCheckInterval, (timer) {
      if (_status == UpdateManagerStatus.idle ||
          _status == UpdateManagerStatus.upToDate) {
        _log.fine('Auto-checking for updates');
        checkForUpdate();
      }
    });

    _log.info(
      'Auto-check started with ${_autoCheckInterval.inHours}h interval',
    );
  }

  void _stopAutoCheck() {
    _autoCheckTimer?.cancel();
    _autoCheckTimer = null;
  }
}
