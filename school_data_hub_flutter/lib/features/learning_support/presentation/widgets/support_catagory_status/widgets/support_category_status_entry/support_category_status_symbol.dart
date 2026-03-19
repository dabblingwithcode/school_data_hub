import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Displays a growth icon based on a score (1-4).
/// Shows a question mark icon when score is null or invalid.
class GrowthIcon extends StatelessWidget {
  final int? score;
  final double size;

  const GrowthIcon({required this.score, this.size = 50, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final validScore = score != null && score! >= 1 && score! <= 4;
    Color growthIconColor = switch (score) {
      1 => style.colors.growth1,
      2 => style.colors.growth2,
      3 => style.colors.growth3,
      4 => style.colors.growth4,
      _ => style.colors.mutedForeground,
    };
    return SizedBox(
      width: size,
      height: size,
      child: validScore
          ? Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: growthIconColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                width: size / 3 * 2.5,
                height: size / 3 * 2.5,
                'assets/images/growth_icons/growth_$score-4.png',
              ),
            )
          : Icon(Icons.question_mark_rounded, color: style.colors.foreground, size: size),
    );
  }
}

/// Displays the growth icon for a specific support category status.
class SupportCategoryStatusSymbol extends StatelessWidget {
  final PupilProxy pupil;
  final int categoryId;
  final int statusId;
  final double size;

  const SupportCategoryStatusSymbol({
    required this.pupil,
    required this.categoryId,
    required this.statusId,
    this.size = 50,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final score = pupil.getSupportCategoryStatusScore(categoryId, statusId);
    return GrowthIcon(score: score, size: size);
  }
}

/// Displays the growth icon for the most recent status of a support category.
class LastSupportCategoryStatusSymbol extends StatelessWidget {
  final PupilProxy pupil;
  final int categoryId;
  final double size;

  const LastSupportCategoryStatusSymbol({
    required this.pupil,
    required this.categoryId,
    this.size = 50,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final score = pupil.getLastSupportCategoryStatusScore(categoryId);
    return GrowthIcon(score: score, size: size);
  }
}
