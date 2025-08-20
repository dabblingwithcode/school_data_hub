import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class RoomsFilterBottomSheet extends WatchingWidget {
  const RoomsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<PupilFilter, bool> activeFilters =
    //     watchValue((PupilFilterManager x) => x.filterState);
    Map<PupilSortMode, bool> sortMode =
        watchValue((PupilFilterManager x) => x.sortMode);
    bool valueSortByName = sortMode[PupilSortMode.sortByName]!;
    bool valueSortByCredit = sortMode[PupilSortMode.sortByCredit]!;
    bool valueSortByCreditEarned = sortMode[PupilSortMode.sortByCreditEarned]!;

    //final filterLocator = locator<PupilFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const CommonPupilFiltersWidget(),
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
                    label: 'alphabetisch',
                    selected: valueSortByName,
                    onSelected: (val) {
                      // filterLocator.setSortMode(PupilSortMode.sortByName, val);
                      // valueSortByName = filterLocator
                      //     .sortMode.value[PupilSortMode.sortByName]!;
                      // filterLocator.sortPupils();
                    },
                  ),
                  ThemedFilterChip(
                    label: 'nach Guthaben',
                    selected: valueSortByCredit,
                    onSelected: (val) {
                      // filterLocator.setSortMode(
                      //     PupilSortMode.sortByCredit, val);
                      // valueSortByCredit = filterLocator
                      //     .sortMode.value[PupilSortMode.sortByCredit]!;
                      // filterLocator.sortPupils();
                    },
                  ),
                  ThemedFilterChip(
                    label: 'nach Verdienst',
                    selected: valueSortByCreditEarned,
                    onSelected: (val) {
                      // filterLocator.setSortMode(
                      //     PupilSortMode.sortByCreditEarned, val);
                      // valueSortByCreditEarned = filterLocator
                      //     .sortMode.value[PupilSortMode.sortByCreditEarned]!;
                      // filterLocator.sortPupils();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showRoomsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const RoomsFilterBottomSheet(),
  );
}
