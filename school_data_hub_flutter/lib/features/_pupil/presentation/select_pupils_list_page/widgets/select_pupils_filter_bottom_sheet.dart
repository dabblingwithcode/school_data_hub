import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:flutter_it/flutter_it.dart';

class SelectPupilsFilterBottomSheet extends WatchingWidget {
  const SelectPupilsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final learningSupportFilterManager = di<LearningSupportFilterManager>();
    final pupilsFilter = di<PupilsFilter>();
    final ogsFilters = pupilsFilter.afterSchoolCareFilters;
    final ogsFilter = ogsFilters[0];
    final notOgsFilter = ogsFilters[1];
    bool valueOgs = watch(ogsFilter).isActive;
    bool valueNotOgs = watch(notOgsFilter).isActive;

    //- LEARNING SUPPORT FILTERS
    Map<SupportLevelType, bool> supportLevelFilters = watchValue(
      (LearningSupportFilterManager x) => x.supportLevelFilterState,
    );
    Map<SupportArea, bool> supportAreaFilters = watchValue(
      (LearningSupportFilterManager x) => x.supportAreaFilterState,
    );
    bool valueSpecialNeeds =
        supportLevelFilters[SupportLevelType.specialNeeds]!;
    bool valueSupportLevel1 =
        supportLevelFilters[SupportLevelType.supportLevel1]!;
    bool valueSupportLevel2 =
        supportLevelFilters[SupportLevelType.supportLevel2]!;
    bool valueSupportLevel3 =
        supportLevelFilters[SupportLevelType.supportLevel3]!;
    bool valueSupportLevel4 =
        supportLevelFilters[SupportLevelType.supportLevel4]!;
    bool valueMigrationSupport =
        supportLevelFilters[SupportLevelType.migrationSupport]!;
    bool valueSupportAreaMotorics = supportAreaFilters[SupportArea.motorics]!;
    bool valueSupportAreaEmotions = supportAreaFilters[SupportArea.emotions]!;
    bool valueSupportAreaMath = supportAreaFilters[SupportArea.math]!;
    bool valueSupportAreaLearning = supportAreaFilters[SupportArea.learning]!;
    bool valueSupportAreaGerman = supportAreaFilters[SupportArea.german]!;
    bool valueSupportAreaLanguage = supportAreaFilters[SupportArea.language]!;
    final religionCourseFilters = di<PupilsFilter>().religionCourseFilters;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text('Filter', style: context.typography.title),
                const Spacer(),
                IconButton.filled(
                  iconSize: 35,
                  color: Colors.amber,
                  onPressed: () {
                    di<PupilsFilter>().resetFilters();
                  },
                  icon: const Icon(Icons.restart_alt_rounded),
                ),
              ],
            ),
            const CommonPupilFiltersWidget(),
            Row(
              children: [
                Text('OGS', style: context.typography.subtitle),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ThemedFilterChip(
                  label: 'OGS',
                  selected: valueOgs,
                  onSelected: (val) {
                    if (val) {
                      notOgsFilter.reset();
                    }
                    ogsFilter.toggle(val);
                  },
                ),
                ThemedFilterChip(
                  label: 'nicht OGS',
                  selected: valueNotOgs,
                  onSelected: (val) {
                    if (val) {
                      ogsFilter.reset();
                    }
                    notOgsFilter.toggle(val);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Förderebene', style: context.typography.subtitle),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ThemedFilterChip(
                  label: 'Ebene 1',
                  selected: valueSupportLevel1,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.supportLevel1, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'Ebene 2',
                  selected: valueSupportLevel2,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.supportLevel2, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'Ebene 3',
                  selected: valueSupportLevel3,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.supportLevel3, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'Regenbogen',
                  selected: valueSupportLevel4,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.supportLevel4, value: val),
                      ],
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Förderbereich', style: context.typography.subtitle),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ThemedFilterChip(
                  label: 'Motorik',
                  selected: valueSupportAreaMotorics,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportAreaFilter(
                      supportAreaFilterRecords: [
                        (filter: SupportArea.motorics, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'ES',
                  selected: valueSupportAreaEmotions,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportAreaFilter(
                      supportAreaFilterRecords: [
                        (filter: SupportArea.emotions, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'Mathe',
                  selected: valueSupportAreaMath,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportAreaFilter(
                      supportAreaFilterRecords: [
                        (filter: SupportArea.math, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'Lernen',
                  selected: valueSupportAreaLearning,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportAreaFilter(
                      supportAreaFilterRecords: [
                        (filter: SupportArea.learning, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'Deutsch',
                  selected: valueSupportAreaGerman,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportAreaFilter(
                      supportAreaFilterRecords: [
                        (filter: SupportArea.german, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'Sprache',
                  selected: valueSupportAreaLanguage,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportAreaFilter(
                      supportAreaFilterRecords: [
                        (filter: SupportArea.language, value: val),
                      ],
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Besondere Förderung',
                  style: context.typography.subtitle,
                ),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ThemedFilterChip(
                  label: 'Erstförderung',
                  selected: valueMigrationSupport,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.migrationSupport, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'AO-SF',
                  selected: valueSpecialNeeds,
                  onSelected: (val) {
                    learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.specialNeeds, value: val),
                      ],
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Jahrgang', style: context.typography.subtitle),
              ],
            ),
            const Gap(4),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                for (final religionCourseFilter in religionCourseFilters)
                  ThemedFilterChip(
                    label: religionCourseFilter.displayName,
                    selected: watch(religionCourseFilter).isActive,
                    onSelected: (val) {
                      religionCourseFilter.toggle(val);
                    },
                  ),
              ],
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}

Future<void> showSelectPupilsFilterBottomSheet(BuildContext context) async {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Style.radii.large),
        topRight: Radius.circular(Style.radii.large),
      ),
    ),
    context: context,
    builder: (_) => const SelectPupilsFilterBottomSheet(),
  );
}
