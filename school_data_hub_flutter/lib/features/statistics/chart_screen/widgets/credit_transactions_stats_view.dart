import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_screen/chart_screen.dart';

class CreditTransactionsStatsView extends StatefulWidget {
  final List<Schoolday> sortedSchooldays;
  final Map<DateTime, ({int incoming, int outgoing, int balance})>
  creditTransactionsChartData;

  const CreditTransactionsStatsView({
    super.key,
    required this.sortedSchooldays,
    required this.creditTransactionsChartData,
  });

  @override
  State<CreditTransactionsStatsView> createState() =>
      _CreditTransactionsStatsViewState();
}

class _CreditTransactionsStatsViewState
    extends State<CreditTransactionsStatsView> {
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
      final dateData = widget.creditTransactionsChartData[chartData.date];
      if (dateData == null) return;

      final buffer = StringBuffer();
      buffer.writeln('Datum: ${chartData.dateString}');
      buffer.writeln();
      buffer.writeln('Einnahmen: ${dateData.incoming}');
      buffer.writeln('Ausgaben: ${dateData.outgoing}');
      buffer.writeln('Bilanz: ${dateData.balance}');

      showDialog<void>(
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
    final creditTransactionsSeries = _createCreditTransactionsSeries();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            Center(
              child: Text(
                'KreditTransaktionen nach Schultag',
                style: context.typography.title,
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
                    creditTransactionsSeries,
                    animate: true,
                    animationDuration: const Duration(milliseconds: 500),
                    defaultRenderer: charts.BarRendererConfig(
                      groupingType: charts.BarGroupingType.stacked,
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
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildLegendItem(
                  'Einnahmen',
                  Colors.green.shade700,
                  'incoming',
                ),
                _buildLegendItem('Ausgaben', Colors.red.shade700, 'outgoing'),
                _buildLegendItem('Bilanz', Colors.blue.shade700, 'balance'),
              ],
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
              style: context.typography.subtitle.copyWith(
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

  List<charts.Series<ChartData, String>> _createCreditTransactionsSeries() {
    final incomingData = widget.sortedSchooldays.map((schoolday) {
      final data = widget.creditTransactionsChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.incoming ?? 0,
        seriesId: 'incoming',
      );
    }).toList();

    final outgoingData = widget.sortedSchooldays.map((schoolday) {
      final data = widget.creditTransactionsChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.outgoing ?? 0,
        seriesId: 'outgoing',
      );
    }).toList();

    final balanceData = widget.sortedSchooldays.map((schoolday) {
      final data = widget.creditTransactionsChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.balance ?? 0,
        seriesId: 'balance',
      );
    }).toList();

    return [
      charts.Series<ChartData, String>(
        id: 'Einnahmen',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.green.shade700),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: incomingData,
      ),
      charts.Series<ChartData, String>(
        id: 'Ausgaben',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red.shade700),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: outgoingData,
      ),
      charts.Series<ChartData, String>(
        id: 'Bilanz',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.blue.shade700),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: balanceData,
      ),
    ];
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
}
