import 'package:dio/dio.dart';
import 'package:school_data_hub_flutter/features/matrix/logs/data/matrix_corporal_logs_config.dart';
import 'package:school_data_hub_flutter/features/matrix/logs/data/matrix_corporal_logs_response.dart';
import 'package:school_data_hub_flutter/features/matrix/services/api/api_client.dart';

const String _logsPath = '/_matrix/corporal/logs';
const String _configPath = '/_matrix/corporal/logs/config';

class MatrixCorporalLogsApiService {
  MatrixCorporalLogsApiService({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Options get _corporalOptions =>
      _apiClient.apiOptions(tokenKey: Token.corporal);

  /// GET list logs. [limit] default 50, max 500; [offset] default 0.
  Future<MatrixCorporalLogsResponse> getLogs({
    int limit = 50,
    int offset = 0,
  }) async {
    final effectiveLimit = limit.clamp(1, 500);
    final response = await _apiClient.get(
      _logsPath,
      queryParameters: {'limit': effectiveLimit, 'offset': offset},
      options: _corporalOptions,
    );
    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
    final data = response.data is Map<String, dynamic>
        ? response.data as Map<String, dynamic>
        : <String, dynamic>{};
    return MatrixCorporalLogsResponse.fromJson(data);
  }

  /// DELETE a single log entry by id.
  Future<void> deleteLog(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('Log id is required');
    }
    final response = await _apiClient.delete(
      '$_logsPath/$id',
      options: _corporalOptions,
    );
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return;
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  /// DELETE all log entries.
  Future<void> deleteAllLogs() async {
    final response = await _apiClient.delete(
      _logsPath,
      options: _corporalOptions,
    );
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return;
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  /// GET logs config (which levels are stored).
  Future<MatrixCorporalLogsConfig> getLogsConfig() async {
    final response = await _apiClient.get(
      _configPath,
      options: _corporalOptions,
    );
    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
    final data = response.data is Map<String, dynamic>
        ? response.data as Map<String, dynamic>
        : <String, dynamic>{};
    return MatrixCorporalLogsConfig.fromJson(data);
  }

  /// PUT logs config. Only levels in [levels] are updated.
  Future<MatrixCorporalLogsConfig> putLogsConfig(
    Map<String, bool> levels,
  ) async {
    if (levels.isEmpty) {
      throw ArgumentError('At least one level is required');
    }
    final response = await _apiClient.put(
      _configPath,
      data: {'levels': levels},
      options: _corporalOptions,
    );
    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
    final data = response.data is Map<String, dynamic>
        ? response.data as Map<String, dynamic>
        : <String, dynamic>{};
    return MatrixCorporalLogsConfig.fromJson(data);
  }
}
