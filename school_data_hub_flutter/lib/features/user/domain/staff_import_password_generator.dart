import 'dart:math';

/// Generates a random password suitable for initial staff account creation.
/// [length] default 12; uses alphanumeric (easy to type and read).
String generateRandomStaffPassword({int length = 12}) {
  const chars =
      'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  final rnd = Random.secure();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}
