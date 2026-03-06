import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/core/auth/auth_clearance_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/learning_support_plan_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class LearningSupportPlansSection extends StatelessWidget {
  final PupilProxy pupil;
  final CustomExpansionTileController plansExpansionController;

  const LearningSupportPlansSection({
    required this.pupil,
    required this.plansExpansionController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final schoolCalendarManager = di<SchoolCalendarManager>();
    final currentSemester = schoolCalendarManager.currentSemester.value;

    // Find the active plan (current semester) and other plans
    LearningSupportPlan? activePlan;
    List<LearningSupportPlan> otherPlans = [];

    if (pupil.learningSupportPlans != null && currentSemester != null) {
      for (final plan in pupil.learningSupportPlans!) {
        if (plan.schoolSemesterId == currentSemester.id) {
          activePlan = plan;
        } else {
          otherPlans.add(plan);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with expansion switch
        Row(
          children: [
            Text(
              'Förderpläne',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColor,
              ),
            ),
            const Spacer(),
            CustomExpansionTileSwitch(
              customExpansionTileController: plansExpansionController,
              switchColor: AppColors.interactiveColor,
            ),
          ],
        ),
        const Gap(10),

        // Active plan card (always visible)
        if (activePlan != null)
          LearningSupportPlanCard(plan: activePlan, pupil: pupil)
        else
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Kein aktiver Förderplan verfügbar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

        // Other plans in expansion tile
        CustomExpansionTileContent(
          tileController: plansExpansionController,
          widgetList: [
            if (otherPlans.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Keine weiteren Förderpläne verfügbar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ...otherPlans.map(
                (plan) => LearningSupportPlanCard(plan: plan, pupil: pupil),
              ),
            const Gap(10),

            // New Learning Support Plan Button
            if (AuthClearanceHelper.isTutorOrAdmin(pupil))
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: () {
                    if (pupil.supportLevelHistory == null ||
                        pupil.supportLevelHistory!.isEmpty) {
                      di<NotificationService>().showInformationDialog(
                        'Förderebene nicht festgelegt',
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => NewLearningSupportPlan(pupil: pupil),
                      ),
                    );
                  },
                  child: const Text(
                    "NEUER FÖRDERPLAN",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
