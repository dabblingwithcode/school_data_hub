import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/support_goals_list.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/preschool_revision_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/support_category_statuses_list.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/support_level_history_expansion_tile.dart';

class PupilProfileLearningSupportContentList extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileLearningSupportContentList(
      {required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Eingangsuntersuchung: ',
              style: TextStyle(fontSize: 15.0),
            ),
            Gap(5),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            InkWell(
              onTap: () => preschoolRevisionDialog(context, pupil,
                  pupil.preSchoolMedical?.preschoolMedicalStatus),
              child: Text(
                PupilHelper.preschoolRevisionPredicate(pupil.preSchoolMedical),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.interactiveColor),
              ),
            )
          ],
        ),
        const Gap(10),
        if (pupil.supportLevelHistory != null)
          pupil.supportLevelHistory!.isNotEmpty
              ? SupportLevelHistoryExpansionTile(pupil: pupil)
              : Row(
                  children: [
                    const Text('Förderebene:',
                        style: TextStyle(fontSize: 15.0)),
                    const Gap(10),
                    InkWell(
                      onTap: () => supportLevelDialog(
                          context, pupil, pupil.latestSupportLevel?.level),
                      child: Text(
                        pupil.latestSupportLevel == null
                            ? 'kein Eintrag'
                            : pupil.latestSupportLevel!.level == 1
                                ? 'Förderebene 1'
                                : pupil.latestSupportLevel!.level == 2
                                    ? 'Förderebene 2'
                                    : 'Förderebene 3',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.interactiveColor),
                      ),
                    )
                  ],
                ),
        const Gap(10),
        Row(
          children: [
            const Text('Förderschwerpunkt: ', style: TextStyle(fontSize: 15.0)),
            const Gap(5),
            pupil.specialNeeds == '' || pupil.specialNeeds == null
                ? const Text(
                    'keins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${pupil.specialNeeds}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
          ],
        ),
        const Gap(10),
        const Row(
          children: [
            Text('Förderbereiche',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: AppStyles.actionButtonStyle,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => NewSupportCategoryStatus(
                        appBarTitle: 'Neuer Förderbereich',
                        pupilId: pupil.pupilId,
                        goalCategoryId: 0,
                        elementType: 'status',
                      )));
            },
            child: const Text(
              "NEUER FÖRDERBEREICH",
              style: AppStyles.buttonTextStyle,
            ),
          ),
        ),
        const Gap(5),
        ...pupilCategoryStatusesList(pupil, context),

        const Gap(5),
        SupportGoalsList(pupil: pupil),

        // const Gap(10),
        // ...buildPupilCategoryTree(context, pupil, null, 0, null),
        const Gap(15),
      ],
    );
  }
}
