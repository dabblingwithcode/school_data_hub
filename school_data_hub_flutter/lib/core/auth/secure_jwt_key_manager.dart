// import 'dart:developer';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:school_data_hub_client/school_data_hub_client.dart';

// class SecureJwtKeyManager extends AuthenticationKeyManager {
//   static const _keyStorageKey = 'jwt_auth_token';
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   @override
//   Future<String?> get() async {
//     try {
//       return await _storage.read(key: _keyStorageKey);
//     } catch (e) {
//       log('SecureJwtKeyManager: Error retrieving JWT token: $e');
//       return null;
//     }
//   }

//   @override
//   Future<void> put(String key) async {
//     try {
//       await _storage.write(key: _keyStorageKey, value: key);
//     } catch (e) {
//       log('SecureJwtKeyManager: Error storing JWT token: $e');
//     }
//   }

//   @override
//   Future<void> remove() async {
//     try {
//       await _storage.delete(key: _keyStorageKey);
//     } catch (e) {
//       log('SecureJwtKeyManager: Error removing JWT token: $e');
//     }
//   }

//   @override
//   Future<String?> toHeaderValue(String? key) async {
//     if (key == null) return null;
//     return 'Bearer $key';
//   }
// }
