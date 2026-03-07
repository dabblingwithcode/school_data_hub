import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';

/// Learning-support filter content. Use inside
/// [GenericFilterBottomSheet](children: [CommonPupilFiltersWidget(), LearningSupportFiltersWidget()]).
class LearningSupportFiltersWidget extends WatchingWidget {
  const LearningSupportFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final learningSupportFilterManager = di<LearningSupportFilterManager>();
    final supportLevelFilters = watchValue(
      (LearningSupportFilterManager x) => x.supportLevelFilterState,
    );
    final supportAreaFilters = watchValue(
      (LearningSupportFilterManager x) => x.supportAreaFilterState,
    );
    final currentLearningSupportPlanFilters = watchValue(
      (LearningSupportFilterManager x) =>
          x.currentLearningSupportFilterState,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          children: [Text('Förderebene', style: AppStyles.subtitle)],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            _levelChip(
              learningSupportFilterManager,
              'Ebene 1',
              supportLevelFilters[SupportLevelType.supportLevel1]!,
              SupportLevelType.supportLevel1,
            ),
            _levelChip(
              learningSupportFilterManager,
              'Ebene 2',
              supportLevelFilters[SupportLevelType.supportLevel2]!,
              SupportLevelType.supportLevel2,
            ),
            _levelChip(
              learningSupportFilterManager,
              'Ebene 3',
              supportLevelFilters[SupportLevelType.supportLevel3]!,
              SupportLevelType.supportLevel3,
            ),
            _levelChip(
              learningSupportFilterManager,
              'Regenbogen',
              supportLevelFilters[SupportLevelType.supportLevel4]!,
              SupportLevelType.supportLevel4,
            ),
          ],
        ),
        const Row(
          children: [Text('Förderbereich', style: AppStyles.subtitle)],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            _areaChip(learningSupportFilterManager, 'Motorik',
                supportAreaFilters[SupportArea.motorics]!, SupportArea.motorics),
            _areaChip(learningSupportFilterManager, 'ES',
                supportAreaFilters[SupportArea.emotions]!, SupportArea.emotions),
            _areaChip(learningSupportFilterManager, 'Mathe',
                supportAreaFilters[SupportArea.math]!, SupportArea.math),
            _areaChip(learningSupportFilterManager, 'Lernen',
                supportAreaFilters[SupportArea.learning]!, SupportArea.learning),
            _areaChip(learningSupportFilterManager, 'Deutsch',
                supportAreaFilters[SupportArea.german]!, SupportArea.german),
            _areaChip(learningSupportFilterManager, 'Sprache',
                supportAreaFilters[SupportArea.language]!, SupportArea.language),
          ],
        ),
        const Row(
          children: [
            Text('Besondere Förderung', style: AppStyles.subtitle),
          ],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            _levelChip(
              learningSupportFilterManager,
              'Erstförderung',
              supportLevelFilters[SupportLevelType.migrationSupport]!,
              SupportLevelType.migrationSupport,
            ),
            _levelChip(
              learningSupportFilterManager,
              'AO-SF',
              supportLevelFilters[SupportLevelType.specialNeeds]!,
              SupportLevelType.specialNeeds,
            ),
          ],
        ),
        const Row(
          children: [Text('Förderplan', style: AppStyles.subtitle)],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            _planChip(
              learningSupportFilterManager,
              'Vorhanden',
              currentLearningSupportPlanFilters[
                  CurrentLearningSupportPlan.available]!,
              CurrentLearningSupportPlan.available,
            ),
            _planChip(
              learningSupportFilterManager,
              'Nicht vorhanden',
              currentLearningSupportPlanFilters[
                  CurrentLearningSupportPlan.notAvailable]!,
              CurrentLearningSupportPlan.notAvailable,
            ),
          ],
        ),
        const Gap(20),
      ],
    );
  }

  Widget _levelChip(
    LearningSupportFilterManager manager,
    String label,
    bool selected,
    SupportLevelType filter,
  ) {
    return ThemedFilterChip(
      label: label,
      selected: selected,
      onSelected: (val) {
        manager.setSupportLevelFilter(
          supportLevelFilterRecords: [(filter: filter, value: val)],
        );
      },
    );
  }

  Widget _areaChip(
    LearningSupportFilterManager manager,
    String label,
    bool selected,
    SupportArea filter,
  ) {
    return ThemedFilterChip(
      label: label,
      selected: selected,
      onSelected: (val) {
        manager.setSupportAreaFilter(
          supportAreaFilterRecords: [(filter: filter, value: val)],
        );
      },
    );
  }

  Widget _planChip(
    LearningSupportFilterManager manager,
    String label,
    bool selected,
    CurrentLearningSupportPlan filter,
  ) {
    return ThemedFilterChip(
      label: label,
      selected: selected,
      onSelected: (val) {
        manager.setCurrentLearningSupportPlanFilter(
          currentLearningSupportPlanFilterRecords: [
            (filter: filter, value: val),
          ],
        );
      },
    );
  }
}
