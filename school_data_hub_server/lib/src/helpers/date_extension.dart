extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isBeforeDay(DateTime other) {
    return year < other.year ||
        (year == other.year && month < other.month) ||
        (year == other.year && month == other.month && day < other.day);
  }

  bool isAfterDay(DateTime other) {
    return year > other.year ||
        (year == other.year && month > other.month) ||
        (year == other.year && month == other.month && day > other.day);
  }

  DateTime justDate() {
    return DateTime(year, month, day);
  }

  String formatDateForUser() {
    return '$day.$month.$year';
  }

  String formatDateTimeForUser() {
    return '$day.$month.$year $hour:$minute';
  }
}
