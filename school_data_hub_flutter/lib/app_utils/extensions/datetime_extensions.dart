import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateHubExtension on DateTime {
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

  String formatDateForUser() {
    final date = this.toLocal().add(const Duration(hours: 2));
    final DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    return dateFormat.format(date).toString();
  }

  String formatDateForJson() {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(this).toString();
  }

  /// Format DateTime with time for UI display
  String formatDateAndTimeForUser() {
    final date = this.isUtc ? this.toLocal() : this;
    final DateFormat dateFormat = DateFormat("dd.MM.yyyy HH:mm");
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

  /// Convert to UTC for server communication
  DateTime formatToUtcForServer() {
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
