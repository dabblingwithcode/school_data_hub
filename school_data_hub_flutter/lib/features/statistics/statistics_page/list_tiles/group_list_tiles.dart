import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/group_card.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/group_tiles.dart';

groupListTiles(context, StatisticsController controller) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'SuS insgesamt:',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const Gap(10),
          Text(
            controller.pupils.length.toString(),
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
            controller.pupilsInOGS(controller.pupils).length.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      children: [
        statisticsGroupCard(controller, controller.pupils),
        ExpansionTile(
          title: const Text(
            'nach Klassen',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            if (controller.pupils.any((element) => element.group == 'A1'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('A1'),
              ),
            if (controller.pupils.any((element) => element.group == 'A2'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('A2'),
              ),
            if (controller.pupils.any((element) => element.group == 'A3'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('A3'),
              ),
            if (controller.pupils.any((element) => element.group == 'B1'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('B1'),
              ),
            if (controller.pupils.any((element) => element.group == 'B2'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('B2'),
              ),
            if (controller.pupils.any((element) => element.group == 'B3'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('B3'),
              ),
            if (controller.pupils.any((element) => element.group == 'B4'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('B4'),
              ),
            if (controller.pupils.any((element) => element.group == 'C1'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('C1'),
              ),
            if (controller.pupils.any((element) => element.group == 'C2'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('C2'),
              ),
            if (controller.pupils.any((element) => element.group == 'C3'))
              groupTiles(
                context,
                controller,
                controller.pupilsInaGivenGroup('C3'),
              ),
          ],
        ),
      ],
    ),
  );
}
