import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/group_card.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/group_tiles.dart';
import 'package:watch_it/watch_it.dart';

class GroupListTiles extends WatchingWidget {
  final StatisticsController controller;

  const GroupListTiles({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final filteredPupils = watchValue(
      (PupilsFilter filter) => filter.filteredPupils,
    );
    final groupedPupils = _groupByClass(filteredPupils);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TotalSummaryRow(
          total: filteredPupils.length,
          ogs: controller.pupilsInOGS(filteredPupils).length,
        ),
        const Gap(15),

        if (filteredPupils.isEmpty)
          const Text(
            'Keine Schülerinnen und Schüler entsprechen den aktuellen Filtern.',
            style: TextStyle(color: Colors.black54),
          )
        else ...[
          statisticsGroupCard(controller, filteredPupils),
          const FilterHeading(),
          const Gap(5),
          const CommonPupilFiltersWidget(),
          const Gap(20),
          const Gap(20),
          const Text(
            'nach Klassen',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(10),
          for (final group in groupedPupils) ...[
            groupTiles(context, controller, group),
            const Gap(20),
          ],
        ],
      ],
    );
  }

  List<List<PupilProxy>> _groupByClass(List<PupilProxy> pupils) {
    final Map<String, List<PupilProxy>> grouped = {};
    for (final pupil in pupils) {
      grouped.putIfAbsent(pupil.group, () => []).add(pupil);
    }
    final keys = grouped.keys.toList()..sort();
    return [for (final key in keys) grouped[key]!];
  }
}

class _TotalSummaryRow extends StatelessWidget {
  final int total;
  final int ogs;

  const _TotalSummaryRow({required this.total, required this.ogs});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'SuS insgesamt:',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        const Gap(10),
        Text(
          total.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(20),
        const Text(
          'davon OGS:',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        const Gap(10),
        Text(
          ogs.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
