import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';

import '../data/matrix_corporal_log_entry.dart';
import '../data/matrix_corporal_logs_api_service.dart';
import '../data/matrix_corporal_logs_config.dart';

class MatrixCorporalLogsManager extends ChangeNotifier {
  MatrixCorporalLogsManager(this._api);

  final MatrixCorporalLogsApiService _api;

  static const int _pageSize = 50;

  final _allLogs = <MatrixCorporalLogEntry>[];
  int _total = 0;

  final _logs = ValueNotifier<List<MatrixCorporalLogEntry>>([]);
  ValueListenable<List<MatrixCorporalLogEntry>> get logs => _logs;

  final _hasMore = ValueNotifier<bool>(true);
  ValueListenable<bool> get hasMore => _hasMore;

  final _totalCount = ValueNotifier<int>(0);
  ValueListenable<int> get totalCount => _totalCount;

  final _levelFilter = ValueNotifier<Set<String>?>(null);
  ValueListenable<Set<String>?> get levelFilter => _levelFilter;

  final _messageFilter = ValueNotifier<String?>(null);
  ValueListenable<String?> get messageFilter => _messageFilter;

  final _filtersActive = ValueNotifier<bool>(false);
  ValueListenable<bool> get filtersActive => _filtersActive;

  MatrixCorporalLogsConfig? _logsConfig;
  MatrixCorporalLogsConfig? get logsConfig => _logsConfig;

  final _logsConfigNotifier = ValueNotifier<MatrixCorporalLogsConfig?>(null);
  ValueListenable<MatrixCorporalLogsConfig?> get logsConfigListenable =>
      _logsConfigNotifier;

  late final fetchCommand = Command.createAsyncNoParamNoResult(
    _fetch,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final loadMoreCommand = Command.createAsyncNoParamNoResult(
    _loadMore,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
    restriction: fetchCommand.isRunning,
  );

  late final deleteCommand = Command.createAsync<String, void>(
    _deleteLog,
    initialValue: null,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final deleteAllCommand = Command.createAsyncNoParamNoResult(
    _deleteAllLogs,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final getConfigCommand = Command.createAsyncNoParamNoResult(
    _getConfig,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final putConfigCommand = Command.createAsync<Map<String, bool>, void>(
    _putConfig,
    initialValue: null,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  Future<void> _fetch() async {
    final result = await _api.getLogs(limit: _pageSize, offset: 0);
    _allLogs.clear();
    _allLogs.addAll(result.logs);
    _total = result.total;
    _hasMore.value = _allLogs.length < _total;
    _totalCount.value = _total;
    _applyFilters();
    notifyListeners();
  }

  Future<void> _loadMore() async {
    if (_allLogs.length >= _total) return;
    final result = await _api.getLogs(
      limit: _pageSize,
      offset: _allLogs.length,
    );
    _allLogs.addAll(result.logs);
    _hasMore.value = _allLogs.length < _total;
    _applyFilters();
    notifyListeners();
  }

  Future<void> _deleteLog(String id) async {
    await _api.deleteLog(id);
    _allLogs.removeWhere((e) => e.id == id);
    _total = (_total - 1).clamp(0, _total);
    _totalCount.value = _total;
    _applyFilters();
    notifyListeners();
  }

  Future<void> _deleteAllLogs() async {
    await _api.deleteAllLogs();
    _allLogs.clear();
    _total = 0;
    _hasMore.value = false;
    _totalCount.value = 0;
    _logs.value = [];
    notifyListeners();
  }

  Future<void> _getConfig() async {
    _logsConfig = await _api.getLogsConfig();
    _logsConfigNotifier.value = _logsConfig;
    notifyListeners();
  }

  Future<void> _putConfig(Map<String, bool> levels) async {
    _logsConfig = await _api.putLogsConfig(levels);
    _logsConfigNotifier.value = _logsConfig;
    notifyListeners();
  }

  void _applyFilters() {
    final levelSet = _levelFilter.value;
    final message = _messageFilter.value?.trim();
    final hasLevel = levelSet != null && levelSet.isNotEmpty;
    final hasMessage = message != null && message.isNotEmpty;
    List<MatrixCorporalLogEntry> filtered = _allLogs;
    if (hasLevel) {
      filtered = filtered.where((e) => levelSet.contains(e.level)).toList();
    }
    if (hasMessage) {
      final lower = message.toLowerCase();
      filtered =
          filtered.where((e) => e.message.toLowerCase().contains(lower)).toList();
    }
    _logs.value = filtered;
  }

  void setLevelFilter(Set<String>? levels) {
    _levelFilter.value = levels != null && levels.isEmpty ? null : levels;
    _updateFiltersActive();
    _applyFilters();
    notifyListeners();
  }

  void toggleLevel(String level) {
    final current = _levelFilter.value ?? {};
    final next = Set<String>.from(current);
    if (next.contains(level)) {
      next.remove(level);
    } else {
      next.add(level);
    }
    setLevelFilter(next.isEmpty ? null : next);
  }

  void setMessageFilter(String? value) {
    final normalized = value?.trim();
    _messageFilter.value = (normalized != null && normalized.isEmpty)
        ? null
        : normalized;
    _updateFiltersActive();
    _applyFilters();
    notifyListeners();
  }

  void resetFilters() {
    _levelFilter.value = null;
    _messageFilter.value = null;
    _updateFiltersActive();
    _applyFilters();
    notifyListeners();
  }

  void _updateFiltersActive() {
    final levelSet = _levelFilter.value;
    final message = _messageFilter.value?.trim();
    _filtersActive.value = (levelSet != null && levelSet.isNotEmpty) ||
        (message != null && message.isNotEmpty);
  }

  @override
  void dispose() {
    _logs.dispose();
    _hasMore.dispose();
    _totalCount.dispose();
    _levelFilter.dispose();
    _messageFilter.dispose();
    _filtersActive.dispose();
    _logsConfigNotifier.dispose();
    super.dispose();
  }
}
