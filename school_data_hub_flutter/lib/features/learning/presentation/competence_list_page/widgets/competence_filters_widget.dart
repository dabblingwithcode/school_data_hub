import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/enums.dart';
import 'package:watch_it/watch_it.dart';

final _competenceFilterManager = di<CompetenceFilterManager>();

class CompetenceFilters extends WatchingWidget {
  const CompetenceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    Map<CompetenceFilter, bool> activeFilters =
        watchValue((CompetenceFilterManager x) => x.filterState);
    bool valueE1 = activeFilters[CompetenceFilter.E1]!;
    bool valueE2 = activeFilters[CompetenceFilter.E2]!;
    bool valueS3 = activeFilters[CompetenceFilter.S3]!;
    bool valueS4 = activeFilters[CompetenceFilter.S4]!;

    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Jahrgang',
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
              label: 'E1',
              selected: valueE1,
              onSelected: (val) {
                _competenceFilterManager.setFilter(CompetenceFilter.E1, val);
              },
            ),
            ThemedFilterChip(
              label: 'E2',
              selected: valueE2,
              onSelected: (val) {
                _competenceFilterManager.setFilter(CompetenceFilter.E2, val);
              },
            ),
            ThemedFilterChip(
              label: 'K3',
              selected: valueS3,
              onSelected: (val) {
                _competenceFilterManager.setFilter(CompetenceFilter.S3, val);
              },
            ),
            ThemedFilterChip(
              label: 'K4',
              selected: valueS4,
              onSelected: (val) {
                _competenceFilterManager.setFilter(CompetenceFilter.S4, val);
              },
            ),
          ],
        ),
      ],
    );
  }
}
