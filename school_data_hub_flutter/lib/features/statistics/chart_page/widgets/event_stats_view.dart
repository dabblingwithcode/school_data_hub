import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page.dart';

class EventStatsView extends StatefulWidget {
  final List<Schoolday> sortedSchooldays;
  final Map<
    DateTime,
    ({
      int parentsMeeting,
      int admonition,
      int afternoonCareAdmonition,
      int admonitionAndBanned,
      int otherEvent,
    })
  >
  eventChartData;

  const EventStatsView({
    super.key,
    required this.sortedSchooldays,
    required this.eventChartData,
  });

  @override
  State<EventStatsView> createState() => _EventStatsViewState();
}

class _EventStatsViewState extends State<EventStatsView> {
  final Set<String> _hiddenSeries = {};

  void _toggleSeries(String seriesId) {
    setState(() {
      if (_hiddenSeries.contains(seriesId)) {
        _hiddenSeries.remove(seriesId);
      } else {
        _hiddenSeries.add(seriesId);
      }
    });
  }

  void _onSelectionChanged(charts.SelectionModel<String> model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      final datum = selectedDatum.first;
      final chartData = datum.datum as ChartData;

      // Construct data string with all values for this date
      final dateData = widget.eventChartData[chartData.date];
      if (dateData == null) return;

      final buffer = StringBuffer();
      buffer.writeln('Datum: ${chartData.dateString}');
      buffer.writeln();
      buffer.writeln('Elterngespräch: ${dateData.parentsMeeting}');
      buffer.writeln('Rote Karte: ${dateData.admonition}');
      buffer.writeln('Rote Karte - OGS: ${dateData.afternoonCareAdmonition}');
      buffer.writeln('Rote Karte + Abholen: ${dateData.admonitionAndBanned}');
      buffer.writeln('Sonstiges: ${dateData.otherEvent}');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Details'),
          content: Text(buffer.toString()),
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

  @override
  Widget build(BuildContext context) {
    final eventSeries = _createEventSeries();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            const Center(
              child: Text('Ereignisse nach Schultag', style: AppStyles.title),
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
                    eventSeries,
                    animate: true,
                    animationDuration: const Duration(milliseconds: 500),
                    defaultRenderer: charts.BarRendererConfig(
                      groupingType: charts.BarGroupingType.stacked,
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
                        widget.sortedSchooldays.map((schoolday) {
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
                        changedListener: _onSelectionChanged,
                      ),
                    ],
                    behaviors: [
                      charts.ChartTitle(
                        'Schulereignisse',
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
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 10,
                children: [
                  _buildLegendItem(
                    'Elterngespräch',
                    Colors.blue,
                    'parentsMeeting',
                  ),
                  _buildLegendItem('Rote Karte', Colors.red, 'admonition'),
                  _buildLegendItem(
                    'Rote Karte - OGS',
                    Colors.orange,
                    'afternoonCareAdmonition',
                  ),
                  _buildLegendItem(
                    'Rote Karte + Abholen',
                    Colors.purple,
                    'admonitionAndBanned',
                  ),
                  _buildLegendItem('Sonstiges', Colors.grey, 'otherEvent'),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String seriesId) {
    final isHidden = _hiddenSeries.contains(seriesId);
    return InkWell(
      onTap: () => _toggleSeries(seriesId),
      child: Opacity(
        opacity: isHidden ? 0.5 : 1.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: isHidden
                  ? const Icon(Icons.close, size: 16, color: Colors.white)
                  : null,
            ),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                decoration: isHidden
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<String> _getFirstOfMonthDates() {
    final Set<String> firstOfMonthDates = {};
    String? currentMonth;

    for (final schoolday in widget.sortedSchooldays) {
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

  List<charts.Series<ChartData, String>> _createEventSeries() {
    final List<charts.Series<ChartData, String>> series = [];

    if (!_hiddenSeries.contains('parentsMeeting')) {
      final parentsMeetingData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.eventChartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.parentsMeeting ?? 0,
          seriesId: 'parentsMeeting',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Elterngespräch',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: parentsMeetingData,
        ),
      );
    }

    if (!_hiddenSeries.contains('admonition')) {
      final admonitionData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.eventChartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.admonition ?? 0,
          seriesId: 'admonition',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Rote Karte',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: admonitionData,
        ),
      );
    }

    if (!_hiddenSeries.contains('afternoonCareAdmonition')) {
      final afternoonCareAdmonitionData = widget.sortedSchooldays.map((
        schoolday,
      ) {
        final data = widget.eventChartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.afternoonCareAdmonition ?? 0,
          seriesId: 'afternoonCareAdmonition',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Rote Karte - OGS',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: afternoonCareAdmonitionData,
        ),
      );
    }

    if (!_hiddenSeries.contains('admonitionAndBanned')) {
      final admonitionAndBannedData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.eventChartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.admonitionAndBanned ?? 0,
          seriesId: 'admonitionAndBanned',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Rote Karte + Abholen',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.purple),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: admonitionAndBannedData,
        ),
      );
    }

    if (!_hiddenSeries.contains('otherEvent')) {
      final otherEventData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.eventChartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.otherEvent ?? 0,
          seriesId: 'otherEvent',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Sonstiges',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.grey),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: otherEventData,
        ),
      );
    }

    return series;
  }
}
