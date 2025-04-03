// import 'package:school_data_hub_client/school_data_hub_client.dart';

// class JwtKeyManager extends AuthenticationKeyManager {
//   String? _key;

//   @override
//   Future<String?> get() async {
//     return _key;
//   }

//   @override
//   Future<void> put(String key) async {
//     _key = key;
//   }

//   @override
//   Future<void> remove() async {
//     _key = null;
//   }

//   @override
//   Future<String?> toHeaderValue(String? key) async {
//     if (key == null) return null;
//     return 'Bearer $key';
//   }
// }
