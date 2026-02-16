import 'package:flutter/foundation.dart';
import 'package:command_it/command_it.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

import '../data/server_logs_api_service.dart';

class ServerLogsManager extends ChangeNotifier {
  final _sessionLogs = ValueNotifier<List<HubSessionLogInfo>>([]);
  ValueListenable<List<HubSessionLogInfo>> get sessionLogs => _sessionLogs;

  final _hasMore = ValueNotifier<bool>(true);
  ValueListenable<bool> get hasMore => _hasMore;

  // Filter state
  final _endpointFilter = ValueNotifier<String?>(null);
  ValueListenable<String?> get endpointFilter => _endpointFilter;

  final _methodFilter = ValueNotifier<String?>(null);
  ValueListenable<String?> get methodFilter => _methodFilter;

  final _slowFilter = ValueNotifier<bool>(false);
  ValueListenable<bool> get slowFilter => _slowFilter;

  final _errorFilter = ValueNotifier<bool>(false);
  ValueListenable<bool> get errorFilter => _errorFilter;

  final _openFilter = ValueNotifier<bool>(false);
  ValueListenable<bool> get openFilter => _openFilter;

  final _filtersActive = ValueNotifier<bool>(false);
  ValueListenable<bool> get filtersActive => _filtersActive;

  late final fetchCommand = Command.createAsyncNoParamNoResult(
    _fetch,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
  );

  late final loadMoreCommand = Command.createAsyncNoParamNoResult(
    _loadMore,
    errorFilter: const GlobalIfNoLocalErrorFilter(),
    restriction: fetchCommand.isRunning,
  );

  HubSessionLogFilter _buildFilter({int? lastSessionLogId}) {
    return HubSessionLogFilter(
      endpoint: _endpointFilter.value,
      method: _methodFilter.value,
      slow: _slowFilter.value,
      error: _errorFilter.value,
      open: _openFilter.value,
      lastSessionLogId: lastSessionLogId,
    );
  }

  Future<void> _fetch() async {
    final api = di<ServerLogsApiService>();
    final result = await api.getSessionLogs(_buildFilter());
    _sessionLogs.value = result.sessionLog;
    _hasMore.value = result.sessionLog.length >= 100;
    notifyListeners();
  }

  Future<void> _loadMore() async {
    final currentLogs = _sessionLogs.value;
    if (currentLogs.isEmpty) return;

    final lastId = currentLogs.last.sessionLogEntry.sessionId;
    final api = di<ServerLogsApiService>();
    final result = await api.getSessionLogs(
      _buildFilter(lastSessionLogId: lastId),
    );

    _sessionLogs.value = [...currentLogs, ...result.sessionLog];
    _hasMore.value = result.sessionLog.length >= 100;
    notifyListeners();
  }

  void setEndpointFilter(String? value) {
    final normalized = value?.trim();
    _endpointFilter.value =
        (normalized != null && normalized.isEmpty) ? null : normalized;
    _updateFiltersActive();
    fetchCommand.run();
  }

  void setMethodFilter(String? value) {
    final normalized = value?.trim();
    _methodFilter.value =
        (normalized != null && normalized.isEmpty) ? null : normalized;
    _updateFiltersActive();
    fetchCommand.run();
  }

  void toggleSlow() {
    _slowFilter.value = !_slowFilter.value;
    _updateFiltersActive();
    fetchCommand.run();
  }

  void toggleError() {
    _errorFilter.value = !_errorFilter.value;
    _updateFiltersActive();
    fetchCommand.run();
  }

  void toggleOpen() {
    _openFilter.value = !_openFilter.value;
    _updateFiltersActive();
    fetchCommand.run();
  }

  void resetFilters() {
    _endpointFilter.value = null;
    _methodFilter.value = null;
    _slowFilter.value = false;
    _errorFilter.value = false;
    _openFilter.value = false;
    _updateFiltersActive();
    fetchCommand.run();
  }

  void _updateFiltersActive() {
    _filtersActive.value = _endpointFilter.value != null ||
        _methodFilter.value != null ||
        _slowFilter.value ||
        _errorFilter.value ||
        _openFilter.value;
  }

  @override
  void dispose() {
    _sessionLogs.dispose();
    _hasMore.dispose();
    _endpointFilter.dispose();
    _methodFilter.dispose();
    _slowFilter.dispose();
    _errorFilter.dispose();
    _openFilter.dispose();
    _filtersActive.dispose();
    super.dispose();
  }
}
