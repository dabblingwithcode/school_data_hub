import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class SelectPupilsFilterBottomSheet extends WatchingWidget {
  const SelectPupilsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final _learningSupportFilterManager = di<LearningSupportFilterManager>();
    final _pupilFilterLocator = di<PupilFilterManager>();
    Map<PupilFilter, bool> activePupilFilters = watchValue(
      (PupilFilterManager x) => x.pupilFilterState,
    );

    bool valueOgs = activePupilFilters[PupilFilter.ogs]!;

    bool valueNotOgs = activePupilFilters[PupilFilter.notOgs]!;

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
    // bool valueSupportAreaTurkish = supportAreaFilters[PupilFilter.turkishClass];
    // bool valueSupportAreaArabic = supportAreaFilters[PupilFilter.arabicClass]!;
    // bool valueSupportAreaAlbanian =
    //     supportAreaFilters[PupilFilter.albanianClass]!;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Text('Filter', style: AppStyles.title),
                const Spacer(),
                IconButton.filled(
                  iconSize: 35,
                  color: Colors.amber,
                  onPressed: () {
                    di<PupilsFilter>().resetFilters();

                    //Navigator.pop(context);
                  },
                  icon: const Icon(Icons.restart_alt_rounded),
                ),
              ],
            ),
            const CommonPupilFiltersWidget(),
            const Row(children: [Text('OGS', style: AppStyles.subtitle)]),
            const Gap(5),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ThemedFilterChip(
                  label: 'OGS',
                  selected: valueOgs,
                  onSelected: (val) {
                    if (val == true) {
                      // in case ogs is selected, not ogs should be deselected

                      _pupilFilterLocator.setPupilFilter(
                        pupilFilterRecords: [
                          (filter: PupilFilter.notOgs, value: false),
                          (filter: PupilFilter.ogs, value: val),
                        ],
                      );
                      return;
                    }

                    _pupilFilterLocator.setPupilFilter(
                      pupilFilterRecords: [
                        (filter: PupilFilter.ogs, value: val),
                      ],
                    );
                  },
                ),
                ThemedFilterChip(
                  label: 'nicht OGS',
                  selected: valueNotOgs,
                  onSelected: (val) {
                    if (val == true) {
                      // in case not ogs is selected, ogs should be deselected
                      _pupilFilterLocator.setPupilFilter(
                        pupilFilterRecords: [
                          (filter: PupilFilter.ogs, value: false),
                          (filter: PupilFilter.notOgs, value: val),
                        ],
                      );
                      return;
                    }
                    _pupilFilterLocator.setPupilFilter(
                      pupilFilterRecords: [
                        (filter: PupilFilter.notOgs, value: val),
                      ],
                    );
                  },
                ),
              ],
            ),
            const Row(
              children: [Text('Förderebene', style: AppStyles.subtitle)],
            ),
            const Gap(5),
            Wrap(
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ThemedFilterChip(
                  label: 'Ebene 1',
                  selected: valueSupportLevel1,
                  onSelected: (val) {
                    _learningSupportFilterManager.setSupportLevelFilter(
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
                    _learningSupportFilterManager.setSupportLevelFilter(
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
                    _learningSupportFilterManager.setSupportLevelFilter(
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
                    _learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.supportLevel4, value: val),
                      ],
                    );
                  },
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
                ThemedFilterChip(
                  label: 'Motorik',
                  selected: valueSupportAreaMotorics,
                  onSelected: (val) {
                    _learningSupportFilterManager.setSupportAreaFilter(
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
                    _learningSupportFilterManager.setSupportAreaFilter(
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
                    _learningSupportFilterManager.setSupportAreaFilter(
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
                    _learningSupportFilterManager.setSupportAreaFilter(
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
                    _learningSupportFilterManager.setSupportAreaFilter(
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
                    _learningSupportFilterManager.setSupportAreaFilter(
                      supportAreaFilterRecords: [
                        (filter: SupportArea.language, value: val),
                      ],
                    );
                  },
                ),
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
                ThemedFilterChip(
                  label: 'Erstförderung',
                  selected: valueMigrationSupport,
                  onSelected: (val) {
                    _learningSupportFilterManager.setSupportLevelFilter(
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
                    _learningSupportFilterManager.setSupportLevelFilter(
                      supportLevelFilterRecords: [
                        (filter: SupportLevelType.specialNeeds, value: val),
                      ],
                    );
                  },
                ),
              ],
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

Future<void> showSelectPupilsFilterBottomSheet(BuildContext context) async {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const SelectPupilsFilterBottomSheet(),
  );
}
