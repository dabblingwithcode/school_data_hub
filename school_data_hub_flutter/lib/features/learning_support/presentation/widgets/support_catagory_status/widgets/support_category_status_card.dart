import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/pupil_proxy_learning_support_ext.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_screen/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_entry/support_category_status_entry.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_parents_names.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_goal/support_goal_card.dart';

class SupportCategoryStatusCard extends WatchingWidget {
  final PupilProxy pupil;
  final List<SupportCategoryStatus> statusesWithSameGoalCategory;

  const SupportCategoryStatusCard({
    required this.pupil,
    required this.statusesWithSameGoalCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final expansionController = createOnce(() => ExpansionController());
    final style = Style.of(context);

    final int supportCategoryId =
        statusesWithSameGoalCategory[0].supportCategoryId;

    // Find the indices of goals matching this category
    final goalIndices = <int>[];
    for (int i = 0; i < pupil.supportGoals.length; i++) {
      if (pupil.supportGoals[i].supportCategoryId == supportCategoryId) {
        goalIndices.add(i);
      }
    }

    return CardBox(
      variant: CardBoxVariant.filledSecondary,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Gap(Style.spacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(Style.spacing.md),
              Expanded(
                child: GestureDetector(
                  onLongPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
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
              Gap(Style.spacing.md),
            ],
          ),
          Gap(Style.spacing.xs),
          for (final status in statusesWithSameGoalCategory)
            SupportCategoryStatusEntry(pupil: pupil, status: status),
          Gap(Style.spacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(Style.spacing.md),
              ExpansionHeader(
                expansionController: expansionController,
                switchColor: style.colors.foreground,
                expansionSwitchWidget: Text(
                  goalIndices.isEmpty
                      ? 'Noch keine Förderziele festgelegt!'
                      : 'Förderziele (${goalIndices.length})',
                  style: context.typography.subtitle.bold.withColor(
                    goalIndices.isEmpty
                        ? style.colors.accent
                        : style.colors.foreground,
                  ),
                ),
                includeSwitch: true,
              ),
              Gap(Style.spacing.md),
            ],
          ),
          Gap(Style.spacing.xs),
          ExpansionBody(
            tileController: expansionController,
            widgetList: [
              if (goalIndices.isNotEmpty)
                for (final goalIndex in goalIndices)
                  SupportGoalCard(
                    pupil: pupil,
                    goalIndex: goalIndex,
                    showCategoryBadge: false,
                  ),
              Padding(
                padding: EdgeInsets.all(Style.spacing.md),
                child: Button(
                  label: 'NEUES FÖRDERZIEL',
                  variant: ButtonVariant.primary,
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (ctx) => NewSupportCategoryStatus(
                          appBarTitle: 'Neues Förderziel',
                          pupilId: pupil.pupilId,
                          goalCategoryId: supportCategoryId,
                          elementType: 'goal',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
