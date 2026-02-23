import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class ServerLogsApiService {
  Client get _client => di<Client>();

  Future<HubSessionLogResult> getSessionLogs(HubSessionLogFilter filter) async {
    return _client.adminLogs.getSessionLogs(filter);
  }

  Future<void> deleteSessionLog(int sessionLogId) async {
    return _client.adminLogs.deleteSessionLog(sessionLogId);
  }

  Future<void> deleteAllSessionLogs() async {
    return _client.adminLogs.deleteAllSessionLogs();
  }
}
