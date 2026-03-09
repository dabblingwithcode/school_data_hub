import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupil_media_auth_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';

class PublicMediaAuthFiltersWidget extends WatchingWidget {
  const PublicMediaAuthFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaAuthFilterManager = di<PupilMediaAuthFilterManager>();
    final pupilsFilter = di<PupilsFilter>();
    final activeFilters = watchValue(
      (PupilMediaAuthFilterManager x) => x.publicMediaAuthFilterState,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Medien-Einwilligung',
              style: AppStyles.subtitle,
            ),
          ],
        ),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            for (final filter in PublicMediaAuthFilter.values)
              ThemedFilterChip(
                label: filter.displayName,
                selected: activeFilters[filter]!,
                onSelected: (val) {
                  mediaAuthFilterManager.setPublicMediaAuthFilter(
                    filter: filter,
                    value: val,
                  );
                  pupilsFilter.refreshs();
                },
              ),
          ],
        ),
      ],
    );
  }
}
