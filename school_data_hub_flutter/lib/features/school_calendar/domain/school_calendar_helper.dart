import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

class SchoolCalendarHelper {
  SchoolCalendarHelper._();

  /// Returns `['Schule']` when [day] is a schoolday, otherwise an empty list.
  static List<String> getEventsForDay(
    DateTime day,
    List<Schoolday> schooldays,
  ) {
    if (schooldays.any((element) => element.schoolday == day)) {
      return ['Schule'];
    }
    return [];
  }

  /// Whether [day] falls inside **any** semester and is a schoolday.
  static bool isDayInSemester({
    required DateTime day,
    required List<SchoolSemester> semesters,
    required List<Schoolday> schooldays,
  }) {
    final dayUtc = day.toDateOnlyUtc();

    for (final semester in semesters) {
      final startUtc = semester.startDate.toDateOnlyUtc();
      final endUtc = semester.endDate.toDateOnlyUtc();

      final isInside =
          !dayUtc.isBefore(startUtc) &&
          !dayUtc.isAfter(endUtc) &&
          schooldays.any((element) => element.schoolday.isSameDate(day));
      if (isInside) return true;
    }

    return false;
  }

  /// Whether [day] falls inside the **first** semester and is a schoolday.
  static bool isDayInFirstSemester({
    required DateTime day,
    required List<SchoolSemester> semesters,
    required List<Schoolday> schooldays,
  }) {
    final dayUtc = day.toDateOnlyUtc();

    for (final semester in semesters) {
      if (semester.isFirst != true) continue;
      final startUtc = semester.startDate.toDateOnlyUtc();
      final endUtc = semester.endDate.toDateOnlyUtc();

      final isInside =
          !dayUtc.isBefore(startUtc) &&
          !dayUtc.isAfter(endUtc) &&
          schooldays.any((element) => element.schoolday.isSameDate(day));
      if (isInside) return true;
    }

    return false;
  }
}
