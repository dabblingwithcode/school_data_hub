import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoFilterBottomSheet extends WatchingWidget {
  const SpecialInfoFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //final filterLocator = locator<PupilFilterManager>();

    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          FilterHeading(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CommonPupilFiltersWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
