import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:serverpod/serverpod.dart';

typedef MatrixResponse = http.Response;

class MatrixClient {
  MatrixClient() : _httpClient = http.Client();

  final http.Client _httpClient;
  final _matrixUrl = Serverpod.instance.getPassword('matrixServerUrl');
  final _authToken = Serverpod.instance.getPassword('matrixAuthToken');

  final _log = Logger('MatrixClient');

  /// HTTP headers used for all Matrix API requests
  Map<String, String> get headers => {
        'Authorization': 'Bearer $_authToken',
        'Content-Type': 'application/json',
      };

  Future<MatrixResponse> get(String endpoint) async {
    final uri = Uri.parse('$_matrixUrl$endpoint');
    return await _httpClient.get(uri, headers: headers);
  }

  Future<MatrixResponse> post(String endpoint, String body) async {
    final uri = Uri.parse('$_matrixUrl$endpoint');
    return await _httpClient.post(uri, headers: headers, body: body);
  }

  Future<MatrixResponse> put(String endpoint, String body) async {
    final uri = Uri.parse('$_matrixUrl$endpoint');
    return await _httpClient.put(uri, headers: headers, body: body);
  }

  Future<MatrixResponse> delete(String endpoint) async {
    final uri = Uri.parse('$_matrixUrl$endpoint');
    return await _httpClient.delete(uri, headers: headers);
  }

  // Clean up when done (call on app shutdown)
  void dispose() {
    _httpClient.close();
  }
}
