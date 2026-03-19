import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

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
  final style = Style.of(context);
  final effectiveTextColor = fadedText
      ? style.colors.mutedForeground
      : (textColor ?? style.colors.foreground);
  final countStyle = context.typography.caption.copyWith(height: 1.0);

  return Container(
    margin: EdgeInsets.all(Style.spacing.xs),
    decoration: BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.circle,
    ),
    child: Stack(
      children: [
        Center(
          child: Text(
            date.day.toString(),
            style: context.typography.body.withColor(effectiveTextColor),
          ),
        ),
        if (showSemesterBadge)
          Positioned(
            top: 2,
            left: 2,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Style.spacing.xs,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: isFirstSemester
                    ? AppColors.appStyleButtonColor
                    : AppColors.groupColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                isFirstSemester ? '1' : '2',
                style: TextStyle(
                  fontSize: 8,
                  height: 1.0,
                  fontWeight: FontWeight.w700,
                  color: style.colors.background,
                ),
              ),
            ),
          ),
        if (missedCount > 0)
          Positioned(
            left: 2,
            bottom: 2,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Style.spacing.xs,
                vertical: 1,
              ),
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
              padding: EdgeInsets.symmetric(
                horizontal: Style.spacing.xs,
                vertical: 1,
              ),
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
