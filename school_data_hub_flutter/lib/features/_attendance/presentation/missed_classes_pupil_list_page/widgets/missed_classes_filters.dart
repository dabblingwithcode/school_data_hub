import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';

import 'package:watch_it/watch_it.dart';

class MissedClassFilters extends WatchingWidget {
  const MissedClassFilters({super.key});

  @override
  Widget build(BuildContext context) {
    PupilSortMode sortMode = watchValue((PupilsFilter x) => x.sortMode);
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Sortieren',
              style: AppStyles.subtitle,
            )
          ],
        ),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ThemedFilterChip(
              label: 'A-Z',
              selected: sortMode == PupilSortMode.sortByName,
              onSelected: (val) {
                // if the filter is already selected, do nothing
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByName) {
                  return;
                }
                // set the filter
                di<PupilsFilter>().setSortMode(PupilSortMode.sortByName);
              },
            ),
            ThemedFilterChip(
              label: 'entschuldigt',
              selected: sortMode == PupilSortMode.sortByMissedExcused,
              onSelected: (val) {
                // if the filter is already selected, do nothing
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByMissedExcused) {
                  return;
                }
                // set the filter
                di<PupilsFilter>()
                    .setSortMode(PupilSortMode.sortByMissedExcused);
              },
            ),
            ThemedFilterChip(
              label: 'unentschuldigt',
              selected: sortMode == PupilSortMode.sortByMissedUnexcused,
              onSelected: (val) {
                // if the filter is already selected, do nothing
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByMissedUnexcused) {
                  return;
                }
                // set the filter
                di<PupilsFilter>()
                    .setSortMode(PupilSortMode.sortByMissedUnexcused);
              },
            ),
            ThemedFilterChip(
              label: 'verspätet',
              selected: sortMode == PupilSortMode.sortByLate,
              onSelected: (val) {
                // if the filter is already selected, do nothing
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByLate) {
                  return;
                }
                // set the filter
                di<PupilsFilter>().setSortMode(PupilSortMode.sortByLate);
              },
            ),
            ThemedFilterChip(
              label: 'kontaktiert',
              selected: sortMode == PupilSortMode.sortByContacted,
              onSelected: (val) {
                // if the filter is already selected, do nothing
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByContacted) {
                  return;
                }
                // set the filter
                di<PupilsFilter>().setSortMode(PupilSortMode.sortByContacted);
              },
            ),
            ThemedFilterChip(
              label: 'abgeholt',
              selected: sortMode == PupilSortMode.sortByGoneHome,
              onSelected: (val) {
                // if the filter is already selected, do nothing
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByGoneHome) {
                  return;
                }
                // set the filter
                di<PupilsFilter>().setSortMode(PupilSortMode.sortByGoneHome);
              },
            ),
          ],
        ),
        const Gap(20),
      ],
    );
  }
}
