import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

final _pupilFilterManager = di<PupilFilterManager>();

class SelectMatrixUsersFilterBottomSheet extends WatchingWidget {
  const SelectMatrixUsersFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<PupilFilter, bool> activeFilters =
    //     watchValue((PupilFilterManager x) => x.filterState);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Filter',
                    style: AppStyles.title,
                  ),
                  const Spacer(),
                  IconButton.filled(
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () {
                        _pupilFilterManager.resetFilters();

                        //Navigator.pop(context);
                      },
                      icon: const Icon(Icons.restart_alt_rounded)),
                ],
              ),
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
              const Wrap(
                spacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showSelectMatrixUsersFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const SelectMatrixUsersFilterBottomSheet(),
  );
}
