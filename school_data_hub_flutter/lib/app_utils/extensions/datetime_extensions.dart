import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateOnlyParsing on String {
  /// Parse a date-only string (e.g., `yyyy-MM-dd`) to UTC midnight.
  DateTime toDateOnlyUtc() {
    final parsed = DateTime.parse(this);
    return DateTime.utc(parsed.year, parsed.month, parsed.day);
  }

  /// Try to parse a date-only string to UTC midnight; returns null on failure.
  DateTime? tryToDateOnlyUtc() {
    final parsed = DateTime.tryParse(this);
    if (parsed == null) return null;
    return DateTime.utc(parsed.year, parsed.month, parsed.day);
  }
}

extension DateHubExtension on DateTime {
  /// Ensure UTC without double converting.
  DateTime toUtcSafe() => isUtc ? this : toUtc();

  /// Ensure local without double converting.
  DateTime toLocalSafe() => isUtc ? toLocal() : this;

  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool isBeforeDate(DateTime other) =>
      year == other.year && month == other.month && day < other.day ||
      year == other.year && month < other.month ||
      year < other.year;

  bool isAfterDate(DateTime other) =>
      year == other.year && month == other.month && day > other.day ||
      year == other.year && month > other.month ||
      year > other.year;

  /// UI: localized date (dd.MM.yyyy) using local time.
  String formatDateForUser() {
    final date = toLocalSafe();
    final dateFormat = DateFormat('dd.MM.yyyy');
    return dateFormat.format(date);
  }

  /// Serialization: date portion, defaults to UTC normalization.
  String formatDateForJson({bool normalizeUtc = true}) {
    final date = normalizeUtc ? toUtcSafe() : this;
    final dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(date);
  }

  /// UI: date + time (dd.MM.yyyy HH:mm) in local time.
  String formatDateAndTimeForUser() {
    final date = toLocalSafe();
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    return dateFormat.format(date);
  }

  /// UI: time only (HH:mm) in local time.
  String formatTimeForUser() {
    final date = toLocalSafe();
    final timeFormat = DateFormat('HH:mm');
    return timeFormat.format(date);
  }

  /// UI: weekday + date in local time (German locale by default).
  String formatWithWeekday({String locale = 'de_DE'}) {
    final date = toLocalSafe();
    final dateFormat = DateFormat('EEEE, dd.MM.yyyy', locale);
    return dateFormat.format(date);
  }

  /// Server: normalize to UTC for transport/storage.
  DateTime formatToUtcForServer() => toUtcSafe();

  /// Start of day in local time.
  DateTime startOfDayLocal() {
    final local = toLocalSafe();
    return DateTime(local.year, local.month, local.day);
  }

  /// Start of day in UTC.
  DateTime startOfDayUtc() {
    final utc = toUtcSafe();
    return DateTime.utc(utc.year, utc.month, utc.day);
  }

  String asWeekdayName(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat('EEEE', locale);
    return dateFormat.format(toLocalSafe());
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
