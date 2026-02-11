// lib/services/log_service.dart
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../model/app_log.dart';

// Service to manage the list of logs backed by ValueNotifiers
class LogService {
  // Define a max number of logs to keep in memory
  static const int _maxLogs = 1000;

  final ValueNotifier<List<AppLog>> _logs = ValueNotifier(<AppLog>[]);
  final ValueNotifier<String> _searchQuery = ValueNotifier('');
  final ValueNotifier<Map<Level, bool>> _levelVisibility = ValueNotifier({});
  final ValueNotifier<Set<String>> _loggerNames = ValueNotifier(<String>{});
  final ValueNotifier<Set<String>> _selectedLoggerFilters = ValueNotifier(
    <String>{},
  );

  // Derived state (replaces Computed signals)
  final ValueNotifier<List<AppLog>> filteredLogs = ValueNotifier(<AppLog>[]);
  final ValueNotifier<bool> showInfo = ValueNotifier(true);
  final ValueNotifier<bool> showWarning = ValueNotifier(true);
  final ValueNotifier<bool> showSevere = ValueNotifier(true);
  final ValueNotifier<bool> showShout = ValueNotifier(true);
  final ValueNotifier<bool> showFine = ValueNotifier(true);
  final ValueNotifier<List<String>> loggerNamesSorted = ValueNotifier(
    <String>[],
  );
  final ValueNotifier<Set<String>> selectedLoggerFilters = ValueNotifier(
    <String>{},
  );
  final ValueNotifier<bool> filtersActive = ValueNotifier(false);

  ValueNotifier<String> get searchQuery => _searchQuery;
  ValueNotifier<Set<String>> get loggerNames => _loggerNames;

  LogService() {
    // Wire up derived state updates
    _logs.addListener(_recompute);
    _searchQuery.addListener(_recompute);
    _levelVisibility.addListener(_recompute);
    _selectedLoggerFilters.addListener(_recompute);
    _loggerNames.addListener(_recomputeLoggerNames);
  }

  void _recompute() {
    filteredLogs.value = _computeFilteredLogs();
    showInfo.value = _isLevelVisible(Level.INFO);
    showWarning.value = _isLevelVisible(Level.WARNING);
    showSevere.value = _isLevelVisible(Level.SEVERE);
    showShout.value = _isLevelVisible(Level.SHOUT);
    showFine.value = _isLevelVisible(Level.FINE);
    selectedLoggerFilters.value = _selectedLoggerFilters.value;
    filtersActive.value =
        _selectedLoggerFilters.value.isNotEmpty ||
        _levelVisibility.value.values.any((isVisible) => !isVisible);
  }

  void _recomputeLoggerNames() {
    loggerNamesSorted.value = _loggerNames.value.toList()..sort();
  }

  void addLogString({
    required String message,
    String loggerName = 'App',
    String levelName = 'INFO',
  }) {
    final level = Level.LEVELS.firstWhere(
      (l) => l.name == levelName,
      orElse: () => Level.INFO,
    );
    addLog(AppLog(level, message, loggerName));
  }

  /// Ingest a [LogRecord] and fan out aggregated console strings into
  /// individual app logs when needed.
  void ingestRecord(LogRecord record) {
    final fragments = _splitAggregatedMessage(record.message);
    if (fragments.isEmpty) {
      addLog(AppLog(record.level, record.message, record.loggerName));
      return;
    }

    for (final fragment in fragments) {
      final parsed = _parseFragment(fragment);
      if (parsed != null) {
        addLog(AppLog(parsed.level, parsed.message, parsed.logger));
      } else {
        addLog(AppLog(record.level, fragment, record.loggerName));
      }
    }
  }

  void addLog(AppLog log) {
    final updated = [log, ..._logs.value];
    if (updated.length > _maxLogs) {
      updated.length = _maxLogs;
    }
    _logs.value = updated;
    if (!_loggerNames.value.contains(log.loggerName)) {
      _loggerNames.value = {..._loggerNames.value, log.loggerName};
    }
  }

  void updateSearchQuery(String query) {
    final normalized = query.trim();
    if (_searchQuery.value == normalized) {
      return;
    }
    _searchQuery.value = normalized;
  }

  void setLevelVisibility(Level level, bool isVisible) {
    final current = _levelVisibility.value[level] ?? true;
    if (current == isVisible) return;

    if (isVisible) {
      final next = {..._levelVisibility.value}..remove(level);
      _levelVisibility.value = next;
    } else {
      _levelVisibility.value = {..._levelVisibility.value, level: isVisible};
    }
  }

  void toggleLoggerFilter(String loggerName, bool enabled) {
    final next = {..._selectedLoggerFilters.value};
    if (enabled) {
      next.add(loggerName);
    } else {
      next.remove(loggerName);
    }
    _selectedLoggerFilters.value = next;
  }

  void clearLoggerFilters() {
    if (_selectedLoggerFilters.value.isEmpty) return;
    _selectedLoggerFilters.value = {};
  }

  void clearLogs() {
    if (_logs.value.isEmpty) {
      return;
    }
    _logs.value = [];
  }

  void resetFilters() {
    _levelVisibility.value = {};
    _selectedLoggerFilters.value = {};
  }

  List<AppLog> _computeFilteredLogs() {
    final visibility = _levelVisibility.value;
    final query = _searchQuery.value.toLowerCase();
    final selectedLoggers = _selectedLoggerFilters.value;
    return _logs.value
        .where((log) {
          if (!(visibility[log.level] ?? true)) {
            return false;
          }
          if (selectedLoggers.isNotEmpty &&
              !selectedLoggers.contains(log.loggerName)) {
            return false;
          }
          if (query.isEmpty) {
            return true;
          }
          final haystack = '${log.loggerName} ${log.message}'.toLowerCase();
          return haystack.contains(query);
        })
        .toList(growable: false);
  }

  bool _isLevelVisible(Level level) => _levelVisibility.value[level] ?? true;

  List<String> _splitAggregatedMessage(String message) {
    // split on ", [HH:MM:SS]" patterns which indicate multiple console lines
    final parts = message.split(RegExp(r',\s+(?=\[\d{2}:\d{2}:\d{2}\])')).map((
      e,
    ) {
      final trimmed = e.trimLeft();
      return trimmed.startsWith(',')
          ? trimmed.substring(1).trimLeft()
          : trimmed;
    }).toList();
    return parts.length > 1 ? parts : const [];
  }

  ({Level level, String logger, String message})? _parseFragment(
    String fragment,
  ) {
    final pattern = RegExp(
      r'\[\d{2}:\d{2}:\d{2}\]\s+\[(?<level>[A-Z]+)\]\s+\[(?<logger>[^\]]+)\]\s+(?<msg>.+)',
    );
    final match = pattern.firstMatch(fragment);
    if (match == null) {
      return null;
    }
    final levelName = match.namedGroup('level');
    final logger = match.namedGroup('logger') ?? 'unknown';
    final msg = match.namedGroup('msg') ?? fragment;
    final level = _levelFromName(levelName) ?? Level.INFO;
    return (level: level, logger: logger, message: msg);
  }

  Level? _levelFromName(String? name) {
    if (name == null) return null;
    final upper = name.toUpperCase();
    switch (upper) {
      case 'SHOUT':
        return Level.SHOUT;
      case 'SEVERE':
      case 'ERROR':
        return Level.SEVERE;
      case 'WARNING':
      case 'WARN':
        return Level.WARNING;
      case 'INFO':
        return Level.INFO;
      case 'FINE':
        return Level.FINE;
      case 'FINER':
        return Level.FINER;
      case 'FINEST':
        return Level.FINEST;
      case 'CONFIG':
        return Level.CONFIG;
      default:
        return null;
    }
  }
}
