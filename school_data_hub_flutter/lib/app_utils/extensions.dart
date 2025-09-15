import 'package:flutter/material.dart';
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
    final date = this;
    final DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    return dateFormat.format(date).toString();
  }

  String formatForJson() {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(this).toString();
  }

  /// Format DateTime with time for UI display
  String formatWithTimeForUser() {
    final date = this.isUtc ? this.toLocal() : this;
    final DateFormat dateFormat = DateFormat("dd.MM.yyyy HH:mm");
    return dateFormat.format(date).toString();
  }

  /// Format DateTime with time for server communication
  String formatWithTimeForJson() {
    final date = this.isUtc ? this : this.toUtc();
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(date).toString();
  }

  /// Format time only for UI display
  String formatTimeForUser() {
    final date = this.isUtc ? this.toLocal() : this;
    final DateFormat timeFormat = DateFormat("HH:mm");
    return timeFormat.format(date).toString();
  }

  /// Format date with weekday for UI display
  String formatWithWeekday() {
    final date = this.isUtc ? this.toLocal() : this;
    final DateFormat dateFormat = DateFormat("EEEE, dd.MM.yyyy", "de_DE");
    return dateFormat.format(date).toString();
  }

  /// Convert to local time for UI display
  DateTime toLocalForUI() {
    return this.isUtc ? this.toLocal() : this;
  }

  /// Convert to UTC for server communication
  DateTime toUtcForServer() {
    return this.isUtc ? this : this.toUtc();
  }

  /// Get the start of day in local time
  DateTime startOfDayLocal() {
    final local = this.isUtc ? this.toLocal() : this;
    return DateTime(local.year, local.month, local.day);
  }

  /// Get the start of day in UTC
  DateTime startOfDayUtc() {
    final utc = this.isUtc ? this : this.toUtc();
    return DateTime.utc(utc.year, utc.month, utc.day);
  }

  String asWeekdayName(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final DateFormat dateFormat = DateFormat("EEEE", locale);
    return dateFormat.format(this);
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
