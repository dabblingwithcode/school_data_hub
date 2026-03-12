import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Utility functions for timetable-related operations
class TimetableUtils {
  /// Get the German name for a weekday
  static String getWeekdayName(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return 'Montag';
      case Weekday.tuesday:
        return 'Dienstag';
      case Weekday.wednesday:
        return 'Mittwoch';
      case Weekday.thursday:
        return 'Donnerstag';
      case Weekday.friday:
        return 'Freitag';
    }
  }

  /// Parse a color string to a Color object
  static Color? parseColor(String colorString) {
    try {
      String hexColor = colorString;
      if (!hexColor.startsWith('#')) {
        hexColor = '#$hexColor';
      }

      if (hexColor.length == 7) {
        return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
      }
    } catch (e) {
      // Return null if color parsing fails
    }
    return null;
  }

  /// Get a color with alpha transparency for lesson group backgrounds
  static Color getGroupBackgroundColor(LessonGroup group) {
    if (group.color != null) {
      return parseColor(group.color!)?.withValues(alpha: 0.2) ??
          Colors.grey.shade100;
    }
    return Colors.grey.shade100;
  }
}
