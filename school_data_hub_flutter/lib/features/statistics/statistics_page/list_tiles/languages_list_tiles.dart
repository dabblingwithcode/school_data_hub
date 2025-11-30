import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/pupil_list_dialog.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';

languagesListTiles(context, StatisticsController controller) {
  List<MapEntry<String, int>> sortedLanguageOccurrences =
      controller.languageOccurrences.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

  final List<Color> palette = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
    Colors.brown,
    Colors.pink,
    Colors.cyan,
    Colors.lime,
    Colors.deepOrange,
    Colors.lightBlue,
    Colors.deepPurple,
  ];

  Color getColor(int index) => palette[index % palette.length];

  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      title: Row(
        children: [
          const Text(
            'Sprachen',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const Gap(10),
          Text(
            sortedLanguageOccurrences.length.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      children: [
        Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 15),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedLanguageOccurrences.length,
                  itemBuilder: (BuildContext context, int index) {
                    final entry = sortedLanguageOccurrences[index];
                    final language = entry.key;
                    final occurrences = entry.value;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () async {
                          final pupilsWithLanguage = controller.pupils
                              .where((p) => p.language == language)
                              .toList();
                          await showDialog(
                            context: context,
                            builder: (context) => PupilListDialog(
                              title: 'Schüler mit Sprache: $language',
                              pupils: pupilsWithLanguage,
                            ),
                          );
                        },
                        onLongPress: () async {},
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: getColor(index),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                "$language:",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                "$occurrences",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 300,
                  child: charts.PieChart<String>(
                    [
                      charts.Series<MapEntry<String, int>, String>(
                        id: 'Languages',
                        domainFn: (MapEntry<String, int> entry, _) => entry.key,
                        measureFn: (MapEntry<String, int> entry, _) =>
                            entry.value,
                        colorFn: (_, int? index) =>
                            charts.ColorUtil.fromDartColor(
                              getColor(index ?? 0),
                            ),
                        data: sortedLanguageOccurrences,
                        labelAccessorFn: (MapEntry<String, int> row, _) =>
                            '${row.value}',
                      ),
                    ],
                    animate: true,
                    defaultRenderer: charts.ArcRendererConfig(
                      arcWidth: 60,
                      arcRendererDecorators: [
                        charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.auto,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
