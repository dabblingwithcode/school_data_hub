import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    if (year == other.year && month == other.month && day == other.day) {
      return true;
    } else {
      return false;
    }
  }

  bool isBeforeDate(DateTime other) {
    return year == other.year && month == other.month && day < other.day ||
        year == other.year && month < other.month ||
        year < other.year;
  }

  bool isAfterDate(DateTime other) {
    return year == other.year && month == other.month && day > other.day ||
        year == other.year && month > other.month ||
        year > other.year;
  }

  String formatForUser() {
    final DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    return dateFormat.format(this).toString();
  }

  String formatForJson() {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(this).toString();
  }
}

extension DisplayAsIsbn on int {
  String displayAsIsbn() {
    final String isbn = toString();
    return isbn.length == 13
        ? "${isbn.substring(0, 3)}-${isbn.substring(3, 4)}-${isbn.substring(4, 6)}-${isbn.substring(6, 12)}-${isbn.substring(12, 13)}"
        : isbn.length == 10
            ? "${isbn.substring(0, 1)}-${isbn.substring(1, 5)}-${isbn.substring(5, 9)}-${isbn.substring(9, 10)}"
            : isbn;
  }
}

// extension ColorLog on String {
//   String logWarning() {
//     final String message =
//         "\u001b[1;33m [SCHULDATEN HUB] WARNING: $this \u001b[0m";
//     return message;
//   }

//   String logSuccess() {
//     final String message =
//         "\u001b[1;32m [SCHULDATEN HUB] SUCCESS: $this \u001b[0m";
//     return message;
//   }

//   String logError() {
//     final String message =
//         "\u001b[1;31m [SCHULDATEN HUB] ERROR: $this \u001b[0m";
//     return message;
//   }

//   String logInfo() {
//     final String message =
//         "\u001b[1;34m [SCHULDATEN HUB] INFO: $this \u001b[0m";
//     return message;
//   }
// }
