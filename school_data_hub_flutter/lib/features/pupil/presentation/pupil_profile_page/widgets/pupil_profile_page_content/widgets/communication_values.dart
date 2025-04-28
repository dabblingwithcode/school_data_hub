import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_helper_functions.dart';

class CommunicationValues extends StatelessWidget {
  final CommunicationSkills? communicationSkills;
  const CommunicationValues({
    required this.communicationSkills,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.hearing),
            const Gap(10),
            Text(
              PupilHelper.communicationPredicate(
                  communicationSkills?.understanding),
              style: const TextStyle(
                  fontSize: 16, color: AppColors.interactiveColor),
            ),
          ],
        ),
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline_rounded),
            const Gap(10),
            Text(
              PupilHelper.communicationPredicate(communicationSkills?.speaking),
              style: const TextStyle(
                  fontSize: 16, color: AppColors.interactiveColor),
            ),
          ],
        ),
        const Gap(5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.book),
            const Gap(10),
            Text(
              PupilHelper.communicationPredicate(communicationSkills?.reading),
              style: const TextStyle(
                  fontSize: 16, color: AppColors.interactiveColor),
            ),
          ],
        ),
        const Gap(5),
      ],
    );
  }
}
