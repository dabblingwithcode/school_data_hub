import 'dart:math';

String generateCustomUuid() {
  final Random random = Random();
  final StringBuffer uuid = StringBuffer();
  for (int i = 0; i < 32; i++) {
    final int value = random.nextInt(16);
    uuid.write(value.toRadixString(16).padLeft(1, '0'));
  }
  return uuid.toString();
}
