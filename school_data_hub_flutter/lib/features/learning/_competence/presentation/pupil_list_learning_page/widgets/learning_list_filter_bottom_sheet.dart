import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/books/domain/filters/pupil_book_lending_filter_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';

class LearningFilterBottomSheet extends WatchingWidget {
  const LearningFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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

    return FilterSheet(
      children: [
        const CommonPupilFiltersWidget(),
        Row(
          children: [
            Text('Buecher Status', style: context.typography.subtitle.bold),
          ],
        ),
        Gap(Style.spacing.xs),
        Wrap(
          spacing: Style.spacing.xs,
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
              label: 'Zurueckgegeben',
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
        Row(
          children: [Text('Zeitraum', style: context.typography.subtitle.bold)],
        ),
        Gap(Style.spacing.xs),
        Wrap(
          spacing: Style.spacing.xs,
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
        Row(
          children: [Text('Bewertung', style: context.typography.subtitle.bold)],
        ),
        Gap(Style.spacing.xs),
        Wrap(
          spacing: Style.spacing.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ThemedFilterChip(
              label: 'Hohe Bewertung (>=3)',
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
        Gap(Style.spacing.xl),
      ],
    );
  }
}

Future<dynamic> showLearningFilterBottomSheet(BuildContext context) {
  return showSheet(context, const LearningFilterBottomSheet());
}
