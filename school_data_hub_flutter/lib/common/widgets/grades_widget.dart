import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GradesWidget extends StatelessWidget {
  final String stringWithGrades;
  const GradesWidget({required this.stringWithGrades, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (stringWithGrades.contains('E1')) ...[
          Image.asset(
            'assets/grade_1.png',
            width: 25,
          ),
          const Gap(5)
        ],
        if (stringWithGrades.contains('E2')) ...[
          Image.asset(
            'assets/grade_2.png',
            width: 25,
          ),
          const Gap(5)
        ],
        if (stringWithGrades.contains('S3')) ...[
          Image.asset(
            'assets/grade_3.png',
            width: 25,
          ),
          const Gap(5)
        ],
        if (stringWithGrades.contains('S4')) ...[
          Image.asset(
            'assets/grade_4.png',
            width: 25,
          ),
          const Gap(5)
        ],
      ],
    );
  }
}
