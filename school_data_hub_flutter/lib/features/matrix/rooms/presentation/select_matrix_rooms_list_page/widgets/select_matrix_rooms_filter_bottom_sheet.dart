import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';

class SelectMatrixUsersFilterBottomSheet extends WatchingWidget {
  const SelectMatrixUsersFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
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
                    },
                    icon: const Icon(Icons.restart_alt_rounded),
                  ),
                ],
              ),
              const CommonPupilFiltersWidget(),
              const Row(
                children: [Text('Sortieren', style: AppStyles.subtitle)],
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

Future<dynamic> showSelectMatrixRoomsFilterBottomSheet(BuildContext context) {
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
