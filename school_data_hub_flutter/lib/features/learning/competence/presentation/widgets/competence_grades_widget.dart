import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart'
    as workbookEnum;

class GradesWidget extends StatelessWidget {
  final String stringWithGrades;
  const GradesWidget({required this.stringWithGrades, super.key});

  @override
  Widget build(BuildContext context) {
    if (stringWithGrades.isEmpty) {
      return const SizedBox.shrink();
    }

    final gradeNames = stringWithGrades.split(',').map((g) => g.trim()).toSet();
    final matchedGrades = workbookEnum.Grade.values
        .where((grade) => gradeNames.contains(grade.name))
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < matchedGrades.length; i++) ...[
          Image.asset(matchedGrades[i].imagePath, width: 25),
          if (i < matchedGrades.length - 1) const Gap(5),
        ],
      ],
    );
  }
}
