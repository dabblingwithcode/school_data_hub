import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/attendance_list_page.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceStatsView extends WatchingWidget {
  final List<Schoolday> sortedSchooldays;
  final Map<DateTime, ({int excused, int unexcused, int goneHome})>
  attendanceChartData;

  const AttendanceStatsView({
    super.key,
    required this.sortedSchooldays,
    required this.attendanceChartData,
  });

  @override
  Widget build(BuildContext context) {
    final _hiddenSeries = createOnce(() => ValueNotifier<Set<String>>(Set()));
    void _onSelectionChanged(charts.SelectionModel<String> model) {
      final selectedDatum = model.selectedDatum;

      if (selectedDatum.isNotEmpty) {
        final datum = selectedDatum.first;
        final chartData = datum.datum as ChartData;

        // Construct data string with all values for this date
        final dateData = attendanceChartData[chartData.date];
        if (dateData == null) return;

        final buffer = StringBuffer();
        buffer.writeln('Datum: ${chartData.dateString}');
        buffer.writeln();
        buffer.writeln('Entschuldigt: ${dateData.excused}');
        buffer.writeln('Unentschuldigt: ${dateData.unexcused}');
        buffer.writeln('Nach Hause geschickt: ${dateData.goneHome}');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Details'),
            content: Text(buffer.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  di<SchoolCalendarManager>().setThisDate(chartData.date);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AttendanceListPage(),
                    ),
                  );
                },
                child: const Text('Fehlzeiten anzeigen'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Schließen'),
              ),
            ],
          ),
        );
      }
    }

    void _toggleSeries(String seriesId) {
      final modifiedHiddenSeries = _hiddenSeries.value;
      if (_hiddenSeries.value.contains(seriesId)) {
        modifiedHiddenSeries.remove(seriesId);
        _hiddenSeries.value = modifiedHiddenSeries;
      } else {
        modifiedHiddenSeries.add(seriesId);
        _hiddenSeries.value = modifiedHiddenSeries;
      }
    }

    Widget _buildLegendItem(String label, Color color, String seriesId) {
      final isHidden = _hiddenSeries.value.contains(seriesId);
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

    List<charts.Series<ChartData, String>> _createAttendanceSeries() {
      final List<charts.Series<ChartData, String>> series = [];

      if (!_hiddenSeries.value.contains('excused')) {
        final excusedData = sortedSchooldays.map((schoolday) {
          final data = attendanceChartData[schoolday.schoolday];
          final dateStr = _formatDateForChart(schoolday.schoolday);
          return ChartData(
            date: schoolday.schoolday,
            dateString: dateStr,
            count: data?.excused ?? 0,
            seriesId: 'excused',
          );
        }).toList();

        series.add(
          charts.Series<ChartData, String>(
            id: 'Entschuldigt',
            colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
            domainFn: (ChartData data, _) => data.dateString,
            measureFn: (ChartData data, _) => data.count,
            data: excusedData,
          ),
        );
      }

      if (!_hiddenSeries.value.contains('unexcused')) {
        final unexcusedData = sortedSchooldays.map((schoolday) {
          final data = attendanceChartData[schoolday.schoolday];
          final dateStr = _formatDateForChart(schoolday.schoolday);
          return ChartData(
            date: schoolday.schoolday,
            dateString: dateStr,
            count: data?.unexcused ?? 0,
            seriesId: 'unexcused',
          );
        }).toList();

        series.add(
          charts.Series<ChartData, String>(
            id: 'Unentschuldigt',
            colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
            domainFn: (ChartData data, _) => data.dateString,
            measureFn: (ChartData data, _) => data.count,
            data: unexcusedData,
          ),
        );
      }

      if (!_hiddenSeries.value.contains('goneHome')) {
        final goneHomeData = sortedSchooldays.map((schoolday) {
          final data = attendanceChartData[schoolday.schoolday];
          final dateStr = _formatDateForChart(schoolday.schoolday);
          return ChartData(
            date: schoolday.schoolday,
            dateString: dateStr,
            count: data?.goneHome ?? 0,
            seriesId: 'goneHome',
          );
        }).toList();

        series.add(
          charts.Series<ChartData, String>(
            id: 'Nach Hause geschickt',
            colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
            domainFn: (ChartData data, _) => data.dateString,
            measureFn: (ChartData data, _) => data.count,
            data: goneHomeData,
          ),
        );
      }

      return series;
    }

    final attendanceSeries = _createAttendanceSeries();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            const Center(
              child: Text('Fehlzeiten nach Schultag', style: AppStyles.title),
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
                    attendanceSeries,
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
                        changedListener: _onSelectionChanged,
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
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 10,
                children: [
                  _buildLegendItem('Entschuldigt', Colors.green, 'excused'),
                  _buildLegendItem('Unentschuldigt', Colors.red, 'unexcused'),
                  _buildLegendItem(
                    'Nach Hause geschickt',
                    Colors.orange,
                    'goneHome',
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
