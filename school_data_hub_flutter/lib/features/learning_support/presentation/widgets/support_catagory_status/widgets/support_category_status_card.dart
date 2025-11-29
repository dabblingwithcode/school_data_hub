import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_entry.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_parents_names.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class SupportCategoryStatusCard extends StatelessWidget {
  final PupilProxy pupil;
  final List<SupportCategoryStatus> statusesWithSameGoalCategory;

  const SupportCategoryStatusCard({
    required this.pupil,
    required this.statusesWithSameGoalCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _learningSupportManager = di<SupportCategoryManager>();
    final int supportCategoryId =
        statusesWithSameGoalCategory[0].supportCategoryId;
    final Color supportCategoryColor =
        _learningSupportManager.getCategoryColor(supportCategoryId);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(children: [
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: LearningSupportHelper.getRootSupportCategoryColor(
                    _learningSupportManager.getRootSupportCategory(
                      supportCategoryId,
                    ),
                  ),
                ),
                child: InkWell(
                  onLongPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => NewSupportCategoryStatus(
                              appBarTitle: 'Neuer Status',
                              pupilId: pupil.pupilId,
                              goalCategoryId: supportCategoryId,
                              elementType: 'status',
                            )));
                  },
                  child: Column(
                    children: [
                      ...categoryTreeAncestorsNames(
                        categoryId: supportCategoryId,
                        categoryColor: supportCategoryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            const Gap(10),
            Flexible(
              child: Text(
                _learningSupportManager
                    .getSupportCategory(supportCategoryId)
                    .name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: supportCategoryColor,
                ),
              ),
            ),
          ],
        ),
        const Gap(10),
        for (int i = 0;
            i < statusesWithSameGoalCategory.length;
            i++) ...<Widget>[
          SupportCategoryStatusEntry(
              pupil: pupil, status: statusesWithSameGoalCategory[i]),
        ],
        // TODO: Uncomment this when the goal category is implemented
        // if (LearningSupportHelper.getGoalsForCategory(pupil, supportCategoryId)
        //     .isEmpty)
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.red,
            ),
            Gap(5),
            Text(
              'Noch keine Förderziele formuliert!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: AppStyles.actionButtonStyle,
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => NewSupportCategoryStatus(
                        appBarTitle: 'Neues Förderziel',
                        pupilId: pupil.pupilId,
                        goalCategoryId: supportCategoryId,
                        elementType: 'goal',
                      )));
            },
            child: const Text(
              "NEUES FÖRDERZIEL",
              style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}
