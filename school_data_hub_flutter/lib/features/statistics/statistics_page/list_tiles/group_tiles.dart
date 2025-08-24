import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/group_card.dart';

groupTiles(context, StatisticsController controller, List<PupilProxy> group) {
  String groupString = group[0].group;
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      title: Row(
        children: [
          Text(
            groupString,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Gap(10),
          const Text(
            'insgesamt:',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const Gap(10),
          Text(
            group.length.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Gap(20),
          const Text(
            'davon OGS:',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const Gap(10),
          Text(
            controller.pupilsInOGS(group).length.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      children: [statisticsGroupCard(controller, group)],
    ),
  );
}
