import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';

import 'package:watch_it/watch_it.dart';

class OgsFilterBottomSheet extends WatchingWidget {
  const OgsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          FilterHeading(),
          CommonPupilFiltersWidget(),
          Row(children: [Text('OGS-Filter', style: AppStyles.subtitle)]),
        ],
      ),
    );
  }
}

showOgsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const OgsFilterBottomSheet(),
  );
}
