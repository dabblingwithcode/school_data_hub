import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
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
    final style = Style.of(context);
    return Column(
      children: [
        Row(
          children: [
            Gap(Style.spacing.xs),
            Text(
              'Status Kompetenzen',
              style: context.typography.title,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                final parentContext =
                    context; // Capture context before navigation
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
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
              child: Icon(
                Icons.add_circle_rounded,
                color: style.colors.accent,
                size: 25,
              ),
            ),
            Gap(Style.spacing.xs),
          ],
        ),
        Gap(Style.spacing.xs),

        PupilCompetenceStatusesList(pupil: pupil),
        Gap(Style.spacing.lg),
      ],
    );
  }
}
