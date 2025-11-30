import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page.dart';

class PupilStatsView extends StatefulWidget {
  final List<Schoolday> sortedSchooldays;
  final Map<
    DateTime,
    ({
      int specialNeeds,
      int migrationSupport,
      int supportLevel3,
      int regularPupils,
      int newPupils,
    })
  >
  chartData;

  const PupilStatsView({
    super.key,
    required this.sortedSchooldays,
    required this.chartData,
  });

  @override
  State<PupilStatsView> createState() => _PupilStatsViewState();
}

class _PupilStatsViewState extends State<PupilStatsView> {
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
      final dateData = widget.chartData[chartData.date];
      if (dateData == null) return;

      final buffer = StringBuffer();
      buffer.writeln('Datum: ${chartData.dateString}');
      buffer.writeln();
      buffer.writeln('Besonderer Förderbedarf: ${dateData.specialNeeds}');
      buffer.writeln('Migrationsunterstützung: ${dateData.migrationSupport}');
      buffer.writeln('Förderstufe 3: ${dateData.supportLevel3}');
      buffer.writeln('Reguläre Schüler: ${dateData.regularPupils}');
      buffer.writeln('Neue Schüler: ${dateData.newPupils}');

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
    final series = _createSeries();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            const Center(
              child: Text(
                'Schülerzahlen nach Schultag',
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
                    series,
                    animate: true,
                    animationDuration: const Duration(milliseconds: 500),
                    defaultRenderer: charts.LineRendererConfig(
                      includeArea: true,
                      stacked: true,
                    ),
                    customSeriesRenderers: [
                      charts.LineRendererConfig(
                        customRendererId: 'lineSeries',
                        strokeWidthPx: 3.0,
                        includeArea: false,
                        stacked: false,
                      ),
                    ],
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
                        'Schüler*innen',
                        titleStyleSpec: const charts.TextStyleSpec(
                          fontSize: 16,
                        ),
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
                    'Besonderer Förderbedarf',
                    AppColors.accentColor,
                    'Special Needs',
                  ),
                  _buildLegendItem(
                    'Migrationsunterstützung',
                    AppColors.backgroundColor,
                    'Migration Support',
                  ),
                  _buildLegendItem(
                    'Förderstufe 3',
                    AppColors.warningButtonColor,
                    'Support Level 3',
                  ),
                  _buildLegendItem(
                    'Reguläre Schüler',
                    const Color.fromARGB(255, 200, 200, 200),
                    'Regular Pupils',
                  ),
                  _buildLegendItem(
                    'Neue Schüler',
                    AppColors.successButtonColor,
                    'New Pupils',
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

  List<charts.Series<ChartData, String>> _createSeries() {
    final List<charts.Series<ChartData, String>> series = [];

    if (!_hiddenSeries.contains('Special Needs')) {
      final specialNeedsData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.chartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.specialNeeds ?? 0,
          seriesId: 'Special Needs',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Special Needs',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.accentColor),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: specialNeedsData,
        ),
      );
    }

    if (!_hiddenSeries.contains('Migration Support')) {
      final migrationSupportData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.chartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.migrationSupport ?? 0,
          seriesId: 'Migration Support',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Migration Support',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.backgroundColor),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: migrationSupportData,
        ),
      );
    }

    if (!_hiddenSeries.contains('Support Level 3')) {
      final supportLevel3Data = widget.sortedSchooldays.map((schoolday) {
        final data = widget.chartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.supportLevel3 ?? 0,
          seriesId: 'Support Level 3',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Support Level 3',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.warningButtonColor),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: supportLevel3Data,
        ),
      );
    }

    if (!_hiddenSeries.contains('Regular Pupils')) {
      final regularPupilsData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.chartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.regularPupils ?? 0,
          seriesId: 'Regular Pupils',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'Regular Pupils',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            const Color.fromARGB(255, 200, 200, 200),
          ),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: regularPupilsData,
        ),
      );
    }

    if (!_hiddenSeries.contains('New Pupils')) {
      final newPupilsData = widget.sortedSchooldays.map((schoolday) {
        final data = widget.chartData[schoolday.schoolday];
        final dateStr = _formatDateForChart(schoolday.schoolday);
        return ChartData(
          date: schoolday.schoolday,
          dateString: dateStr,
          count: data?.newPupils ?? 0,
          seriesId: 'New Pupils',
        );
      }).toList();

      series.add(
        charts.Series<ChartData, String>(
          id: 'New Pupils',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.successButtonColor),
          domainFn: (ChartData data, _) => data.dateString,
          measureFn: (ChartData data, _) => data.count,
          data: newPupilsData,
        )..setAttribute(charts.rendererIdKey, 'lineSeries'),
      );
    }

    return series;
  }
}
