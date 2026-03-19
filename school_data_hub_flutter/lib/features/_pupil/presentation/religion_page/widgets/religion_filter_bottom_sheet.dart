import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:flutter_it/flutter_it.dart';

class ReligionFilterBottomSheet extends WatchingWidget {
  const ReligionFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [CommonPupilFiltersWidget(), Gap(12), ReligionFiltersSection()],
    );
  }
}

class ReligionFiltersSection extends WatchingWidget {
  const ReligionFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final religionCourseFilters = di<PupilsFilter>().religionCourseFilters;

    return Column(
      children: [
        Row(
          children: [
            Text('Religion', style: context.typography.subtitle),
          ],
        ),
        const Gap(4),
        Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            for (final religionFilter in religionCourseFilters)
              ThemedFilterChip(
                label: religionFilter.displayName,
                selected: watch(religionFilter).isActive,
                onSelected: (val) {
                  religionFilter.toggle(val);
                },
              ),
          ],
        ),
      ],
    );
  }
}
