import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/models/learning_support_enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';

class LearningSupportFilterBottomSheet extends WatchingWidget {
  const LearningSupportFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final learningSupportFilterManager = di<LearningSupportFilterManager>();
    Map<SupportLevelType, bool> supportLevelFilters = watchValue(
      (LearningSupportFilterManager x) => x.supportLevelFilterState,
    );
    Map<SupportArea, bool> supportAreaFilters = watchValue(
      (LearningSupportFilterManager x) => x.supportAreaFilterState,
    );

    Map<CurrentLearningSupportPlan, bool> currentLearningSupportPlanFilters =
        watchValue(
          (LearningSupportFilterManager x) =>
              x.currentLearningSupportFilterState,
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
    bool valuePlanAvailable =
        currentLearningSupportPlanFilters[CurrentLearningSupportPlan
            .available]!;
    bool valuePlanNotAvailable =
        currentLearningSupportPlanFilters[CurrentLearningSupportPlan
            .notAvailable]!;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          const FilterHeading(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CommonPupilFiltersWidget(),
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
                          learningSupportFilterManager.setSupportLevelFilter(
                            supportLevelFilterRecords: [
                              (
                                filter: SupportLevelType.supportLevel1,
                                value: val,
                              ),
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
                              (
                                filter: SupportLevelType.supportLevel2,
                                value: val,
                              ),
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
                              (
                                filter: SupportLevelType.supportLevel3,
                                value: val,
                              ),
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
                              (
                                filter: SupportLevelType.supportLevel4,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text('Förderbereich', style: AppStyles.subtitle),
                    ],
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
                          learningSupportFilterManager.setSupportLevelFilter(
                            supportLevelFilterRecords: [
                              (
                                filter: SupportLevelType.migrationSupport,
                                value: val,
                              ),
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
                              (
                                filter: SupportLevelType.specialNeeds,
                                value: val,
                              ),
                            ],
                          );
                        },
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
                      ThemedFilterChip(
                        label: 'Vorhanden',
                        selected: valuePlanAvailable,
                        onSelected: (val) {
                          learningSupportFilterManager
                              .setCurrentLearningSupportPlanFilter(
                                currentLearningSupportPlanFilterRecords: [
                                  (
                                    filter:
                                        CurrentLearningSupportPlan.available,
                                    value: val,
                                  ),
                                ],
                              );
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Nicht vorhanden',
                        selected: valuePlanNotAvailable,
                        onSelected: (val) {
                          learningSupportFilterManager
                              .setCurrentLearningSupportPlanFilter(
                                currentLearningSupportPlanFilterRecords: [
                                  (
                                    filter:
                                        CurrentLearningSupportPlan.notAvailable,
                                    value: val,
                                  ),
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
          ),
        ],
      ),
    );
  }
}

Future<dynamic> showLearningSupportFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const LearningSupportFilterBottomSheet(),
  );
}
