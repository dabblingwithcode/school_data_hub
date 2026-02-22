import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/books/domain/filters/pupil_book_lending_filter_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';

class LearningFilterBottomSheet extends WatchingWidget {
  const LearningFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );
    final pupilBookLendingFilterManager = di<PupilBookLendingFilterManager>();
    Map<PupilBookLendingFilter, bool> bookLendingFilters = watchValue(
      (PupilBookLendingFilterManager x) => x.pupilBookLendingFilterState,
    );

    bool valueAll = bookLendingFilters[PupilBookLendingFilter.all]!;
    bool valueCurrentlyBorrowed =
        bookLendingFilters[PupilBookLendingFilter.currentlyBorrowed]!;
    bool valueReturned = bookLendingFilters[PupilBookLendingFilter.returned]!;
    bool valueLastSevenDays =
        bookLendingFilters[PupilBookLendingFilter.lastSevenDays]!;
    bool valueLastThirtyDays =
        bookLendingFilters[PupilBookLendingFilter.lastThirtyDays]!;
    bool valueHighScore = bookLendingFilters[PupilBookLendingFilter.highScore]!;
    bool valueLowScore = bookLendingFilters[PupilBookLendingFilter.lowScore]!;
    bool valueNoScore = bookLendingFilters[PupilBookLendingFilter.noScore]!;

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
                    children: [
                      Text('Bücher Status', style: AppStyles.subtitle),
                    ],
                  ),
                  const Gap(5),
                  Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      ThemedFilterChip(
                        label: 'Alle',
                        selected: valueAll,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (filter: PupilBookLendingFilter.all, value: val),
                            ],
                          );
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Ausgeliehen',
                        selected: valueCurrentlyBorrowed,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (
                                filter:
                                    PupilBookLendingFilter.currentlyBorrowed,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Zurückgegeben',
                        selected: valueReturned,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (
                                filter: PupilBookLendingFilter.returned,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const Row(
                    children: [Text('Zeitraum', style: AppStyles.subtitle)],
                  ),
                  const Gap(5),
                  Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      ThemedFilterChip(
                        label: 'Letzte 7 Tage',
                        selected: valueLastSevenDays,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (
                                filter: PupilBookLendingFilter.lastSevenDays,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Letzte 30 Tage',
                        selected: valueLastThirtyDays,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (
                                filter: PupilBookLendingFilter.lastThirtyDays,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const Row(
                    children: [Text('Bewertung', style: AppStyles.subtitle)],
                  ),
                  const Gap(5),
                  Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      ThemedFilterChip(
                        label: 'Hohe Bewertung (≥3)',
                        selected: valueHighScore,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (
                                filter: PupilBookLendingFilter.highScore,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Niedrige Bewertung (1-2)',
                        selected: valueLowScore,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (
                                filter: PupilBookLendingFilter.lowScore,
                                value: val,
                              ),
                            ],
                          );
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Keine Bewertung',
                        selected: valueNoScore,
                        onSelected: (val) {
                          pupilBookLendingFilterManager.setFilter(
                            pupilBookLendingFilters: [
                              (
                                filter: PupilBookLendingFilter.noScore,
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

Future<dynamic> showLearningFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const LearningFilterBottomSheet(),
  );
}
