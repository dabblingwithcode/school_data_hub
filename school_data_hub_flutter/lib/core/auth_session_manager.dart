import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

class AuthSessionManager {
  final String serverUrl;

  AuthSessionManager({required this.serverUrl});

  late SessionManager sessionManager;
  late Client client;
}
