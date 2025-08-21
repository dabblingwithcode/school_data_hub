import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<DateTime>> getNonHolidayWeekdays(
    {required DateTime startDate, required DateTime endDate}) async {
  final response =
      await http.get(Uri.parse('https://ferien-api.de/api/v1/holidays/NW'));
  if (response.statusCode != 200) throw Exception('Failed to load holidays');

  final List<dynamic> holidaysJson = jsonDecode(response.body);

  // Collect all holiday dates in the range
  final Set<DateTime> holidayDates = {};
  for (final holiday in holidaysJson) {
    final DateTime holidayStart = DateTime.parse(holiday['start']);
    final DateTime holidayEnd = DateTime.parse(holiday['end']);
    for (var d = holidayStart;
        !d.isAfter(holidayEnd);
        d = d.add(const Duration(days: 1))) {
      if (!d.isBefore(startDate) && !d.isAfter(endDate)) {
        holidayDates.add(DateTime(d.year, d.month, d.day));
      }
    }
  }

  // Collect all non-holiday weekdays in the range
  final List<DateTime> result = [];
  for (var d = startDate;
      !d.isAfter(endDate);
      d = d.add(const Duration(days: 1))) {
    final isWeekend =
        d.weekday == DateTime.saturday || d.weekday == DateTime.sunday;
    final isHoliday = holidayDates.contains(DateTime(d.year, d.month, d.day));
    if (!isWeekend && !isHoliday) {
      result.add(d);
    }
  }
  return result;
}
