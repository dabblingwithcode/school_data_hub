import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/filters/enums.dart';
import 'package:flutter_it/flutter_it.dart';

final _competenceFilterManager = di<CompetenceFilterManager>();

class CompetenceFilters extends WatchingWidget {
  const CompetenceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    Map<CompetenceFilter, bool> activeFilters = watchValue(
      (CompetenceFilterManager x) => x.filterState,
    );
    bool valueE1 = activeFilters[CompetenceFilter.E1]!;
    bool valueE2 = activeFilters[CompetenceFilter.E2]!;
    bool valueS3 = activeFilters[CompetenceFilter.S3]!;
    bool valueS4 = activeFilters[CompetenceFilter.S4]!;

    return Column(
      children: [
        Row(
          children: [Text('Jahrgang', style: context.typography.subtitle.bold)],
        ),
        Gap(Style.spacing.xs),
        Wrap(
          spacing: Style.spacing.xs,
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
