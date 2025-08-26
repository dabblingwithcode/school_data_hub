import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';

languagesListTiles(context, StatisticsController controller) {
  List<MapEntry<String, int>> sortedLanguageOccurrences =
      controller.languageOccurrences.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
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
                  onTap: () {},
                  onLongPress: () async {},
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
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
      ],
    ),
  );
}
