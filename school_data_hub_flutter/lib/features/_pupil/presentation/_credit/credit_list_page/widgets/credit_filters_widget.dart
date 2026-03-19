import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';

/// Credit-specific filter content (sort chips). Use inside
/// filter sheet with [CommonPupilFiltersWidget(), CreditFiltersWidget()].
class CreditFiltersWidget extends WatchingWidget {
  const CreditFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sortModeValue = watch(di<PupilsFilter>().sortMode).value;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [Text('Sortieren', style: context.typography.subtitle)]),
        const Gap(5),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ThemedFilterChip(
              label: 'A-Z',
              selected: sortModeValue == PupilSortMode.sortByName,
              onSelected: (val) {
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByName) {
                  return;
                }

                di<PupilsFilter>().setSortMode(PupilSortMode.sortByName);
              },
            ),
            ThemedFilterChip(
              label: 'nach Guthaben',
              selected: sortModeValue == PupilSortMode.sortByCredit,
              onSelected: (val) {
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByCredit) {
                  return;
                }
                di<PupilsFilter>().setSortMode(PupilSortMode.sortByCredit);
              },
            ),
            ThemedFilterChip(
              label: 'nach Verdienst',
              selected: sortModeValue == PupilSortMode.sortByCreditEarned,
              onSelected: (val) {
                if (di<PupilsFilter>().sortMode.value ==
                    PupilSortMode.sortByCreditEarned) {
                  return;
                }
                di<PupilsFilter>().setSortMode(
                  PupilSortMode.sortByCreditEarned,
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
