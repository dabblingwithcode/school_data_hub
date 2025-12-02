// lib/services/log_service.dart
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

// Represents a single log entry for display
class AppLog {
  final Level level;
  final String message;
  final String loggerName;
  final DateTime time;

  AppLog(this.level, this.message, this.loggerName) : time = DateTime.now();

  @override
  String toString() =>
      '[${time.toIso8601String().split('T').last.substring(0, 8)}] [${level.name}] [$loggerName] $message';
}

// Service to manage the list of logs and notify listeners
class LogService with ChangeNotifier {
  final List<AppLog> _logs = [];
  List<AppLog> get logs => _logs;
  String _searchQuery = '';
  final Map<Level, bool> _levelVisibility = {};

  List<AppLog> get filteredLogs => _logs.where(_shouldIncludeLog).toList();

  String get searchQuery => _searchQuery;

  bool get showInfo => _isLevelVisible(Level.INFO);
  bool get showWarning => _isLevelVisible(Level.WARNING);
  bool get showSevere => _isLevelVisible(Level.SEVERE);
  bool get showShout => _isLevelVisible(Level.SHOUT);

  // Define a max number of logs to keep in memory
  static const int _maxLogs = 100;

  void addLog(AppLog log) {
    // Add the new log entry
    _logs.insert(
      0,
      log,
    ); // Insert at the beginning for reverse-chronological order

    // Trim the list if it exceeds the maximum size
    if (_logs.length > _maxLogs) {
      _logs.removeRange(_maxLogs, _logs.length);
    }

    // Notify listeners (your Flutter widget) that the list has changed
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    final normalized = query.trim();
    if (_searchQuery == normalized) {
      return;
    }
    _searchQuery = normalized;
    notifyListeners();
  }

  void setLevelVisibility(Level level, bool isVisible) {
    final current = _levelVisibility[level] ?? true;
    if (current == isVisible) {
      return;
    }
    _levelVisibility[level] = isVisible;
    notifyListeners();
  }

  bool _shouldIncludeLog(AppLog log) {
    if (!_isLevelVisible(log.level)) {
      return false;
    }
    if (_searchQuery.isEmpty) {
      return true;
    }
    final needle = _searchQuery.toLowerCase();
    final haystack = '${log.loggerName} ${log.message}'.toLowerCase();
    return haystack.contains(needle);
  }

  bool _isLevelVisible(Level level) => _levelVisibility[level] ?? true;
}
