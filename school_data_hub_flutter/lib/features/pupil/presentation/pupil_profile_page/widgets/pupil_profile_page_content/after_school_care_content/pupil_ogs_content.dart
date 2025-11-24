import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/features/ogs/widgets/ogs_details.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilOgsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilOgsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: AppPaddings.pupilProfileCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.lightbulb, color: AppColors.accentColor, size: 24),
                Gap(5),
                Text(
                  'OGS-Informationen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
            const Gap(15),
            OgsDetails(pupil: pupil),
          ],
        ),
      ),
    );
  }
}
