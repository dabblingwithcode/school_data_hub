import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_competence_checks/pupil_competence_statuses_list.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/dialogues/new_competence_check_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilLearningContentCompetenceStatuses extends StatelessWidget {
  final PupilProxy pupil;
  const PupilLearningContentCompetenceStatuses({
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Status Kompetenzen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Gap(10),
        InkWell(
          onTap: () {
            final parentContext = context; // Capture context before navigation
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => SelectCompetence(
                  onSelected: (_, competence) {
                    Navigator.of(ctx).pop(); // Close SelectCompetence page
                    newCompetenceCheckDialog(
                      pupil: pupil,
                      competenceId: competence.publicId,
                      isReport: false,
                      parentContext: parentContext, // Use captured context
                    );
                  },
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: AppColors.backgroundColor,
                  size: 22,
                ),
                const Gap(8),
                Text(
                  'Kompetenzcheck hinzufügen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.backgroundColor.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
        PupilCompetenceStatusesList(pupil: pupil),
        const Gap(15),
      ],
    );
  }
}
