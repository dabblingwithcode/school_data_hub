import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _secureStorage = FlutterSecureStorage();

enum SecureStorageKey {
  environments('environments'),
  sessions('sessions'),
  pupilIdentities('pupilIdentities'),
  matrix('matrix'),
  ;

  final String value;
  const SecureStorageKey(this.value);
}

class AppSecureStorage {
  static Future<bool> containsKey(String key) async {
    if (await _secureStorage.containsKey(key: key)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> read(String key) async {
    final value = await _secureStorage.read(key: key);
    return value;
  }

  static Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
    return;
  }

  static Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
    return;
  }
}
// Future<bool> secureStorageContainsKey(String key) async {
//   if (await _secureStorage.containsKey(key: key)) {
//     return true;
//   } else {
//     return false;
//   }
// }

// Future<String?> secureStorageRead(String key) async {
//   final value = await _secureStorage.read(key: key);
//   return value;
// }

// Future<void> secureStorageWrite(String key, String value) async {
//   await _secureStorage.write(key: key, value: value);
//   return;
// }

// Future<void> secureStorageDelete(String key) async {
//   await _secureStorage.delete(key: key);
//   return;
// }
