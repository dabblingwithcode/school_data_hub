import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

/// A single calendar day cell with optional semester badge, missed-count badge,
/// and event-count badge.
Widget schooldayCalendarDayCell(
  BuildContext context,
  DateTime date, {
  required bool showSemesterBadge,
  required bool isFirstSemester,
  Color? backgroundColor,
  Color? textColor,
  bool fadedText = false,
  int missedCount = 0,
  int eventCount = 0,
}) {
  final effectiveTextColor = fadedText
      ? Theme.of(context).disabledColor
      : (textColor ?? Theme.of(context).textTheme.bodyMedium?.color);
  const countStyle = TextStyle(fontSize: 9, height: 1.0);

  return Container(
    margin: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.circle,
    ),
    child: Stack(
      children: [
        Center(
          child: Text(
            date.day.toString(),
            style: TextStyle(color: effectiveTextColor),
          ),
        ),
        if (showSemesterBadge)
          Positioned(
            top: 2,
            left: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: isFirstSemester
                    ? AppColors.appStyleButtonColor
                    : AppColors.groupColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                isFirstSemester ? '1' : '2',
                style: const TextStyle(
                  fontSize: 8,
                  height: 1.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (missedCount > 0)
          Positioned(
            left: 2,
            bottom: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.groupColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$missedCount',
                style: countStyle.copyWith(
                  color: effectiveTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        if (eventCount > 0)
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.cancelButtonColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$eventCount',
                style: countStyle.copyWith(
                  color: effectiveTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
