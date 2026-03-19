import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_screen/widgets/support_goal_batches.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_screen/widgets/support_goals_list.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class LearningSupportCard extends WatchingWidget {
  final PupilProxy pupil;
  const LearningSupportCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => ExpansionController());

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(Style.spacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
                              onTap: () {
                                di<BottomNavManager>().setPupilProfileNavPage(
                                  ProfileNavigationState.learningSupport.value,
                                );
                                context.push(RoutePaths.pupilProfilePath(pupil.internalId), extra: pupil);
                              },
                              child: _LearningSupportNameRow(pupil: pupil),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _MigrationSupportEndsRow(pupil: pupil),
                    Gap(Style.spacing.lg),
                    _SupportGoalBatchesRow(
                      pupil: pupil,
                      tileController: tileController,
                    ),
                  ],
                ),
              ),
              Gap(Style.spacing.sm),
              _SupportLevelDisplay(
                pupil: pupil,
                tileController: tileController,
              ),
              Gap(Style.spacing.lg),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Style.spacing.xs),
            child: ExpansionBody(
              title: null,
              tileController: tileController,
              widgetList: [SupportGoalsList(pupil: pupil)],
            ),
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _LearningSupportNameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _LearningSupportNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title,
        ),
        Gap(Style.spacing.xs),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title.w400,
        ),
        Gap(Style.spacing.xs),
      ],
    );
  }
}

/// Rebuilds only when [pupil.migrationSupportEnds] changes.
class _MigrationSupportEndsRow extends WatchingWidget {
  final PupilProxy pupil;

  const _MigrationSupportEndsRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final migrationSupportEnds = watchPropertyValue(
      (m) => m.migrationSupportEnds,
      target: pupil,
    );
    if (migrationSupportEnds == null) return const SizedBox.shrink();
    return Wrap(
      children: [
        const Text('Erstförderung bis: '),
        Text(
          migrationSupportEnds.formatDateForUser(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: PupilProxyHelper.migrationSupportEndsColor(
              migrationSupportEnds,
            ),
          ),
        ),
      ],
    );
  }
}

/// Rebuilds only when [pupil.supportCategoryStatuses] changes.
class _SupportGoalBatchesRow extends WatchingWidget {
  final PupilProxy pupil;
  final ExpansionController tileController;

  const _SupportGoalBatchesRow({
    required this.pupil,
    required this.tileController,
  });

  @override
  Widget build(BuildContext context) {
    final supportCategoryStatuses = watchPropertyValue(
      (m) => m.supportCategoryStatuses,
      target: pupil,
    );
    if (supportCategoryStatuses == null || supportCategoryStatuses.isEmpty) {
      return const SizedBox.shrink();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        onTap: () => tileController.toggle(),
        child: SupportGoalBatches(pupil: pupil),
      ),
    );
  }
}

/// Rebuilds only when [pupil.latestSupportLevel], [pupil.learningSupportPlans],
/// [pupil.specialNeeds], or current semester changes.
class _SupportLevelDisplay extends WatchingWidget {
  final PupilProxy pupil;
  final ExpansionController tileController;

  const _SupportLevelDisplay({
    required this.pupil,
    required this.tileController,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final latestSupportLevel = watchPropertyValue(
      (m) => m.latestSupportLevel,
      target: pupil,
    );
    final learningSupportPlans = watchPropertyValue(
      (m) => m.learningSupportPlans,
      target: pupil,
    );
    final specialNeeds = watchPropertyValue(
      (m) => m.specialNeeds,
      target: pupil,
    );
    final currentSemester = watchValue(
      (SchoolCalendarManager x) => x.currentSemester,
    );

    final levelText = latestSupportLevel != null
        ? (latestSupportLevel.level == 4
              ? '🌈'
              : latestSupportLevel.level.toString())
        : '0';
    final isCurrentSemester =
        learningSupportPlans != null &&
        learningSupportPlans.isNotEmpty &&
        learningSupportPlans.last.schoolSemester?.id == currentSemester?.id;
    final levelColor = isCurrentSemester
        ? style.colors.success
        : (latestSupportLevel != null && latestSupportLevel.level != 0)
        ? style.colors.error
        : style.colors.accent;
    final specialNeedsText = specialNeeds != null && specialNeeds.isNotEmpty
        ? (specialNeeds.length >= 2
              ? '${specialNeeds.first} ${specialNeeds.last}'
              : specialNeeds.first.length >= 2
              ? specialNeeds.first.substring(0, 2)
              : specialNeeds.first)
        : '';

    return GestureDetector(
      onTap: () => tileController.toggle(),
      onLongPress: () =>
          supportLevelDialog(context, pupil, latestSupportLevel?.level),
      child: Column(
        children: [
          Gap(Style.spacing.xl),
          const Text('Ebene'),
          Center(
            child: Text(
              levelText,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: levelColor,
              ),
            ),
          ),
          Text(
            specialNeedsText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: style.colors.groupColor,
            ),
          ),
        ],
      ),
    );
  }
}
