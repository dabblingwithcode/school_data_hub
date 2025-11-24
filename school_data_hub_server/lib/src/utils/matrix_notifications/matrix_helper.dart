class MatrixHelper {
  /// Generates a unique transaction ID for message deduplication
  static String generateTransactionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// URL encodes a Matrix room ID for API calls
  static String encodeRoomId(String roomId) {
    return roomId.replaceAllMapped(RegExp(r'[!:]'), (match) {
      switch (match.group(0)) {
        case '!':
          return '%21';
        case ':':
          return '%3A';
        default:
          return match.group(0)!;
      }
    });
  }
}
