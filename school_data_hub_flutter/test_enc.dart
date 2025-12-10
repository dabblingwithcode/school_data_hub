import 'package:encrypt/encrypt.dart' as enc;
// import 'dart:math' as math;

void main() {
  // String generateRandomUtf8StringOfLength(int length) {
  //   const chars =
  //       'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  //   final random = math.Random.secure();
  //   return List.generate(length, (index) => chars[random.nextInt(chars.length)])
  //       .join();
  // }

  final key =
      'zRvyjwzJRg05dQEBMhCQxjGcGz3tMc0Y'; // generateRandomUtf8StringOfLength(32);

  final iv = 'd8wFL7Q2ppvQRGa2'; // generateRandomUtf8StringOfLength(16);

  print('Key: $key');
  print('iv: $iv');
  final encrypter = enc.Encrypter(
    enc.AES(enc.Key.fromUtf8(key), mode: enc.AESMode.cbc),
  );

  final ivFromUtf8 = enc.IV.fromUtf8(iv);

  String encryptString(String nonEncryptedString) {
    final encryptedString = encrypter
        .encrypt(nonEncryptedString, iv: ivFromUtf8)
        .base64;
    return encryptedString;
  }

  final encrypted = encryptString('68548123_s*HappyTree88\$');

  print('Encrypted String: ${encrypted}');
}
