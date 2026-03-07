import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/pupil_list_learning_page/widgets/pupil_competence_checks/pupil_competence_statuses_list.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/widgets/dialogues/new_competence_check_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

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
        Row(
          children: [
            const Gap(5),
            const Text(
              'Status Kompetenzen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                final parentContext =
                    context; // Capture context before navigation
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
              child: Icon(
                Icons.add_circle_rounded,
                color: AppColors.backgroundColor,
                size: 25,
              ),
            ),
            const Gap(5),
          ],
        ),
        const Gap(5),

        PupilCompetenceStatusesList(pupil: pupil),
        const Gap(15),
      ],
    );
  }
}
