import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_entry.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_parents_names.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_goal_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

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
    final int supportCategoryId =
        statusesWithSameGoalCategory[0].supportCategoryId;

    // Find the indices of goals matching this category
    final goalIndices = <int>[];
    if (pupil.supportGoals != null) {
      for (int i = 0; i < pupil.supportGoals!.length; i++) {
        if (pupil.supportGoals![i].supportCategoryId == supportCategoryId) {
          goalIndices.add(i);
        }
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          const Gap(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(10),
              Expanded(
                child: InkWell(
                  onLongPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => NewSupportCategoryStatus(
                          appBarTitle: 'Neuer Status',
                          pupilId: pupil.pupilId,
                          goalCategoryId: supportCategoryId,
                          elementType: 'status',
                        ),
                      ),
                    );
                  },
                  child: CategoryTreeAncestors(categoryId: supportCategoryId),
                ),
              ),
              const Gap(10),
            ],
          ),
          const Gap(5),
          for (final status in statusesWithSameGoalCategory)
            SupportCategoryStatusEntry(pupil: pupil, status: status),
          const Gap(5),
          if (goalIndices.isEmpty)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, color: Colors.red),
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
            )
          else
            for (final goalIndex in goalIndices)
              SupportGoalCard(pupil: pupil, goalIndex: goalIndex),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: AppStyles.actionButtonStyle,
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => NewSupportCategoryStatus(
                      appBarTitle: 'Neues Förderziel',
                      pupilId: pupil.pupilId,
                      goalCategoryId: supportCategoryId,
                      elementType: 'goal',
                    ),
                  ),
                );
              },
              child: const Text(
                "NEUES FÖRDERZIEL",
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
