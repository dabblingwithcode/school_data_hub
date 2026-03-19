import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

/// Displays a growth icon for a competence check score (1–4),
/// or a fallback icon for unknown/null scores.
class CompetenceCheckIcon extends StatelessWidget {
  final int? score;
  final double size;

  const CompetenceCheckIcon({
    required this.score,
    this.size = 50,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final assetPath = _assetForScore(score);
    if (assetPath != null) {
      return SizedBox(
        width: size,
        child: Image.asset(assetPath),
      );
    }
    return SizedBox(
      width: size,
      child: Icon(
        const IconData(0xf0575, fontFamily: 'MaterialIcons'), // question_mark_rounded
        color: Style.of(context).colors.mutedForeground,
      ),
    );
  }

  static String? _assetForScore(int? score) {
    return switch (score) {
      1 => 'assets/images/growth_icons/growth_1-4.png',
      2 => 'assets/images/growth_icons/growth_2-4.png',
      3 => 'assets/images/growth_icons/growth_3-4.png',
      4 => 'assets/images/growth_icons/growth_4-4.png',
      _ => null,
    };
  }
}
