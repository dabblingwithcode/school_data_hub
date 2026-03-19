import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/core/auth/auth_clearance_helper.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/learning_support_plan_card.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class LearningSupportPlansSection extends StatelessWidget {
  final PupilProxy pupil;
  final ExpansionController plansExpansionController;

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
            const Gap(5),
            Text(
              'Förderpläne',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Style.of(context).colors.accent,
              ),
            ),
            const Spacer(),
            ExpansionHeader(
              expansionController: plansExpansionController,
              switchColor: Style.of(context).colors.interactive,
            ),
          ],
        ),
        const Gap(10),

        // Active plan card (always visible)
        if (activePlan != null)
          LearningSupportPlanCard(plan: activePlan, pupil: pupil)
        else
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Kein aktiver Förderplan verfügbar',
              style: TextStyle(
                fontSize: 16,
                color: Style.of(context).colors.mutedForeground,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

        // Other plans in expansion tile
        ExpansionBody(
          tileController: plansExpansionController,
          widgetList: [
            if (otherPlans.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Keine weiteren Förderpläne verfügbar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Style.of(context).colors.mutedForeground,
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
                child: Button(
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    if (pupil.supportLevelHistory == null ||
                        pupil.supportLevelHistory!.isEmpty) {
                      di<NotificationManager>().showInformationDialog(
                        NotificationType.error,
                        'Förderebene nicht festgelegt',
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (ctx) => NewLearningSupportPlan(pupil: pupil),
                      ),
                    );
                  },
                  label: 'NEUER FÖRDERPLAN',
                ),
              ),
          ],
        ),
      ],
    );
  }
}
