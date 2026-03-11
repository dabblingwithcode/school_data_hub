import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page.dart';
import 'package:flutter_it/flutter_it.dart';

class BookLendingStatsView extends WatchingWidget {
  final List<Schoolday> sortedSchooldays;
  final Map<DateTime, ({int currentlyLent})> bookLendingChartData;

  const BookLendingStatsView({
    super.key,
    required this.sortedSchooldays,
    required this.bookLendingChartData,
  });

  @override
  Widget build(BuildContext context) {
    void onSelectionChanged(charts.SelectionModel<String> model) {
      final selectedDatum = model.selectedDatum;

      if (selectedDatum.isNotEmpty) {
        final datum = selectedDatum.first;
        final chartData = datum.datum as ChartData;

        final dateData = bookLendingChartData[chartData.date];
        if (dateData == null) return;

        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              chartData.date.formatWithWeekday(),
              style: AppStyles.title,
            ),
            content: Text(
              'Ausgeliehene Bücher: ${dateData.currentlyLent}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Schließen'),
              ),
            ],
          ),
        );
      }
    }

    List<charts.Series<ChartData, String>> createBookLendingSeries() {
      final lentData = sortedSchooldays.map((schoolday) {
        final data = bookLendingChartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.currentlyLent ?? 0,
          seriesId: 'currentlyLent',
        );
      }).toList();

      return [
        charts.Series<ChartData, String>(
          id: 'Ausgeliehene Bücher',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(Colors.blue.shade700),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: lentData,
        ),
      ];
    }

    final bookLendingSeries = createBookLendingSeries();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            const Center(
              child: Text(
                'Ausgeliehene Bücher nach Schultag',
                style: AppStyles.title,
              ),
            ),
            const Gap(10),
            SizedBox(
              height: 400,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxHeight <= 0 || constraints.maxWidth <= 0) {
                    return const Center(child: Text('Chart wird geladen...'));
                  }
                  return charts.OrdinalComboChart(
                    bookLendingSeries,
                    animate: true,
                    animationDuration: const Duration(milliseconds: 500),
                    defaultRenderer: charts.LineRendererConfig(
                      includeArea: true,
                      stacked: false,
                    ),
                    layoutConfig: charts.LayoutConfig(
                      leftMarginSpec: charts.MarginSpec.fixedPixel(60),
                      topMarginSpec: charts.MarginSpec.fixedPixel(20),
                      rightMarginSpec: charts.MarginSpec.fixedPixel(40),
                      bottomMarginSpec: charts.MarginSpec.fixedPixel(60),
                    ),
                    primaryMeasureAxis: const charts.NumericAxisSpec(
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                        zeroBound: true,
                      ),
                    ),
                    domainAxis: charts.OrdinalAxisSpec(
                      tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
                        sortedSchooldays.map((schoolday) {
                          final dateStr = _formatDateForChart(
                            schoolday.schoolday,
                          );
                          final firstOfMonthDates = _getFirstOfMonthDates();

                          if (firstOfMonthDates.contains(dateStr)) {
                            try {
                              final date = DateFormat('dd.MM').parse(dateStr);
                              return charts.TickSpec<String>(
                                dateStr,
                                label: DateFormat('MMM').format(date),
                              );
                            } catch (e) {
                              return charts.TickSpec<String>(dateStr);
                            }
                          } else {
                            return charts.TickSpec<String>(dateStr, label: '');
                          }
                        }).toList(),
                      ),
                    ),
                    selectionModels: [
                      charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        changedListener: onSelectionChanged,
                      ),
                    ],
                    behaviors: [
                      charts.ChartTitle(
                        'Anzahl',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                      ),
                    ],
                  );
                },
              ),
            ),
            const Gap(20),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    'Ausgeliehene Bücher',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Set<String> _getFirstOfMonthDates() {
    final Set<String> firstOfMonthDates = {};
    String? currentMonth;

    for (final schoolday in sortedSchooldays) {
      final date = schoolday.schoolday.toLocal();
      final monthKey = '${date.year}-${date.month}';
      if (monthKey != currentMonth) {
        currentMonth = monthKey;
        firstOfMonthDates.add(_formatDateForChart(schoolday.schoolday));
      }
    }
    return firstOfMonthDates;
  }

  String _formatDateForChart(DateTime date) {
    final localDate = date.isUtc ? date.toLocal() : date;
    return DateFormat('dd.MM').format(localDate);
  }
}
