import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class ChartPage extends StatelessWidget {
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
  final Map<
    DateTime,
    ({int excused, int unexcused, int goneHome})
  >
  attendanceChartData;
  final List<Schoolday> schooldays;

  const ChartPage({
    super.key,
    required this.chartData,
    required this.eventChartData,
    required this.attendanceChartData,
    required this.schooldays,
  });

  // Sort schooldays by date - make it accessible
  List<Schoolday> get sortedSchooldays {
    return List<Schoolday>.from(schooldays)
      ..sort((a, b) => a.schoolday.compareTo(b.schoolday));
  }

  /// Gets the first schoolday of each month for tick labels
  Set<String> _getFirstOfMonthDates() {
    final Set<String> firstOfMonthDates = {};
    String? currentMonth;

    for (final schoolday in sortedSchooldays) {
      final date = schoolday.schoolday.toLocal();
      final monthKey = '${date.year}-${date.month}';

      // If this is a new month, add the first schoolday of that month
      if (monthKey != currentMonth) {
        currentMonth = monthKey;
        firstOfMonthDates.add(_formatDateForChart(schoolday.schoolday));
      }
    }

    return firstOfMonthDates;
  }

  List<charts.Series<ChartData, String>> _createSeries() {
    // Sort schooldays by date
    final sorted = sortedSchooldays;

    final specialNeedsData = sorted.map((schoolday) {
      final data = chartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.specialNeeds ?? 0,
        seriesId: 'specialNeeds',
      );
    }).toList();

    final migrationSupportData = sorted.map((schoolday) {
      final data = chartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.migrationSupport ?? 0,
        seriesId: 'migrationSupport',
      );
    }).toList();

    final supportLevel3Data = sorted.map((schoolday) {
      final data = chartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.supportLevel3 ?? 0,
        seriesId: 'supportLevel3',
      );
    }).toList();

    final regularPupilsData = sorted.map((schoolday) {
      final data = chartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.regularPupils ?? 0,
        seriesId: 'regularPupils',
      );
    }).toList();

    final newPupilsData = sorted.map((schoolday) {
      final data = chartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.newPupils ?? 0,
        seriesId: 'newPupils',
      );
    }).toList();

    return [
      charts.Series<ChartData, String>(
        id: 'Special Needs',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.accentColor),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: specialNeedsData,
      ),
      charts.Series<ChartData, String>(
        id: 'Migration Support',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.backgroundColor),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: migrationSupportData,
      ),
      charts.Series<ChartData, String>(
        id: 'Support Level 3',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.warningButtonColor),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: supportLevel3Data,
      ),
      charts.Series<ChartData, String>(
        id: 'Regular Pupils',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
          const Color.fromARGB(
            255,
            200,
            200,
            200,
          ), // Light gray for regular pupils
        ),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: regularPupilsData,
      ),
      charts.Series<ChartData, String>(
        id: 'New Pupils',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.successButtonColor),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: newPupilsData,
      )..setAttribute(charts.rendererIdKey, 'lineSeries'),
    ];
  }

  String _formatDateForChart(DateTime date) {
    final localDate = date.isUtc ? date.toLocal() : date;
    return DateFormat('dd.MM').format(localDate);
  }

  List<charts.Series<ChartData, String>> _createEventSeries() {
    // Sort schooldays by date
    final sorted = sortedSchooldays;

    final parentsMeetingData = sorted.map((schoolday) {
      final data = eventChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.parentsMeeting ?? 0,
        seriesId: 'parentsMeeting',
      );
    }).toList();

    final admonitionData = sorted.map((schoolday) {
      final data = eventChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.admonition ?? 0,
        seriesId: 'admonition',
      );
    }).toList();

    final afternoonCareAdmonitionData = sorted.map((schoolday) {
      final data = eventChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.afternoonCareAdmonition ?? 0,
        seriesId: 'afternoonCareAdmonition',
      );
    }).toList();

    final admonitionAndBannedData = sorted.map((schoolday) {
      final data = eventChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.admonitionAndBanned ?? 0,
        seriesId: 'admonitionAndBanned',
      );
    }).toList();

    final otherEventData = sorted.map((schoolday) {
      final data = eventChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.otherEvent ?? 0,
        seriesId: 'otherEvent',
      );
    }).toList();

    return [
      charts.Series<ChartData, String>(
        id: 'Elterngespräch',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: parentsMeetingData,
      ),
      charts.Series<ChartData, String>(
        id: 'Rote Karte',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: admonitionData,
      ),
      charts.Series<ChartData, String>(
        id: 'Rote Karte - OGS',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: afternoonCareAdmonitionData,
      ),
      charts.Series<ChartData, String>(
        id: 'Rote Karte + Abholen',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.purple),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: admonitionAndBannedData,
      ),
      charts.Series<ChartData, String>(
        id: 'Sonstiges',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.grey),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: otherEventData,
      ),
    ];
  }

  List<charts.Series<ChartData, String>> _createAttendanceSeries() {
    // Sort schooldays by date
    final sorted = sortedSchooldays;

    final excusedData = sorted.map((schoolday) {
      final data = attendanceChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.excused ?? 0,
        seriesId: 'excused',
      );
    }).toList();

    final unexcusedData = sorted.map((schoolday) {
      final data = attendanceChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.unexcused ?? 0,
        seriesId: 'unexcused',
      );
    }).toList();

    final goneHomeData = sorted.map((schoolday) {
      final data = attendanceChartData[schoolday.schoolday];
      final dateStr = _formatDateForChart(schoolday.schoolday);
      return ChartData(
        date: schoolday.schoolday,
        dateString: dateStr,
        count: data?.goneHome ?? 0,
        seriesId: 'goneHome',
      );
    }).toList();

    return [
      charts.Series<ChartData, String>(
        id: 'Entschuldigt',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: excusedData,
      ),
      charts.Series<ChartData, String>(
        id: 'Unentschuldigt',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: unexcusedData,
      ),
      charts.Series<ChartData, String>(
        id: 'Nach Hause geschickt',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
        domainFn: (ChartData data, _) => data.dateString,
        measureFn: (ChartData data, _) => data.count,
        data: goneHomeData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (schooldays.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.canvasColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart_rounded, size: 25, color: Colors.white),
              Gap(10),
              Text('Statistik Diagramm', style: AppStyles.appBarTextStyle),
            ],
          ),
        ),
        body: const Center(child: Text('Keine Daten verfügbar')),
      );
    }

    final series = _createSeries();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text('Statistik Diagramm', style: AppStyles.appBarTextStyle),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(15),
                  const Text(
                    'Schülerzahlen nach Schultag',
                    style: AppStyles.title,
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 300,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxHeight <= 0 ||
                            constraints.maxWidth <= 0) {
                          return const Center(
                            child: Text('Chart wird geladen...'),
                          );
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
                              strokeWidthPx: 3.0, // Make the line thicker
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
                            tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                                  zeroBound: true,
                                ),
                          ),
                          domainAxis: charts.OrdinalAxisSpec(
                            tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
                              sortedSchooldays.map((schoolday) {
                                final dateStr = _formatDateForChart(
                                  schoolday.schoolday,
                                );
                                final firstOfMonthDates =
                                    _getFirstOfMonthDates();

                                // Only show label if it's the first of a month
                                if (firstOfMonthDates.contains(dateStr)) {
                                  try {
                                    final date = DateFormat(
                                      'dd.MM',
                                    ).parse(dateStr);
                                    return charts.TickSpec<String>(
                                      dateStr,
                                      label: DateFormat('MMM').format(date),
                                    );
                                  } catch (e) {
                                    return charts.TickSpec<String>(dateStr);
                                  }
                                } else {
                                  // Return tick with empty label for other dates
                                  return charts.TickSpec<String>(
                                    dateStr,
                                    label: '',
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                          behaviors: [
                            charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom,
                              desiredMaxRows: 4,
                              cellPadding: const EdgeInsets.only(
                                right: 4.0,
                                bottom: 4.0,
                              ),
                            ),
                            charts.ChartTitle(
                              'Schultag',
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea,
                            ),
                            charts.ChartTitle(
                              'Anzahl Schüler',
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
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      _buildLegendItem(
                        'Besonderer Förderbedarf',
                        AppColors.accentColor,
                      ),
                      _buildLegendItem(
                        'Migrationsunterstützung',
                        AppColors.backgroundColor,
                      ),
                      _buildLegendItem(
                        'Förderstufe 3',
                        AppColors.warningButtonColor,
                      ),
                      _buildLegendItem(
                        'Reguläre Schüler',
                        const Color.fromARGB(255, 200, 200, 200),
                      ),
                      _buildLegendItem(
                        'Neue Schüler',
                        AppColors.successButtonColor,
                      ),
                    ],
                  ),
                  const Gap(30),
                  const Text(
                    'Schultagevents nach Schultag',
                    style: AppStyles.title,
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 300,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxHeight <= 0 ||
                            constraints.maxWidth <= 0) {
                          return const Center(
                            child: Text('Chart wird geladen...'),
                          );
                        }
                        final eventSeries = _createEventSeries();
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
                            tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                                  zeroBound: true,
                                ),
                          ),
                          domainAxis: charts.OrdinalAxisSpec(
                            tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
                              sortedSchooldays.map((schoolday) {
                                final dateStr = _formatDateForChart(
                                  schoolday.schoolday,
                                );
                                final firstOfMonthDates =
                                    _getFirstOfMonthDates();

                                // Only show label if it's the first of a month
                                if (firstOfMonthDates.contains(dateStr)) {
                                  try {
                                    final date = DateFormat(
                                      'dd.MM',
                                    ).parse(dateStr);
                                    return charts.TickSpec<String>(
                                      dateStr,
                                      label: DateFormat('MMM').format(date),
                                    );
                                  } catch (e) {
                                    return charts.TickSpec<String>(dateStr);
                                  }
                                } else {
                                  // Return tick with empty label for other dates
                                  return charts.TickSpec<String>(
                                    dateStr,
                                    label: '',
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                          behaviors: [
                            charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom,
                              desiredMaxRows: 3,
                              cellPadding: const EdgeInsets.only(
                                right: 4.0,
                                bottom: 4.0,
                              ),
                            ),
                            charts.ChartTitle(
                              'Schultag',
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea,
                            ),
                            charts.ChartTitle(
                              'Anzahl Events',
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
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      _buildLegendItem('Elterngespräch', Colors.blue),
                      _buildLegendItem('Rote Karte', Colors.red),
                      _buildLegendItem('Rote Karte - OGS', Colors.orange),
                      _buildLegendItem('Rote Karte + Abholen', Colors.purple),
                      _buildLegendItem('Sonstiges', Colors.grey),
                    ],
                  ),
                  const Gap(30),
                  const Text(
                    'Anwesenheit nach Schultag',
                    style: AppStyles.title,
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 300,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxHeight <= 0 ||
                            constraints.maxWidth <= 0) {
                          return const Center(
                            child: Text('Chart wird geladen...'),
                          );
                        }
                        final attendanceSeries = _createAttendanceSeries();
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
                            tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                                  zeroBound: true,
                                ),
                          ),
                          domainAxis: charts.OrdinalAxisSpec(
                            tickProviderSpec: charts.StaticOrdinalTickProviderSpec(
                              sortedSchooldays.map((schoolday) {
                                final dateStr = _formatDateForChart(
                                  schoolday.schoolday,
                                );
                                final firstOfMonthDates =
                                    _getFirstOfMonthDates();

                                // Only show label if it's the first of a month
                                if (firstOfMonthDates.contains(dateStr)) {
                                  try {
                                    final date = DateFormat(
                                      'dd.MM',
                                    ).parse(dateStr);
                                    return charts.TickSpec<String>(
                                      dateStr,
                                      label: DateFormat('MMM').format(date),
                                    );
                                  } catch (e) {
                                    return charts.TickSpec<String>(dateStr);
                                  }
                                } else {
                                  // Return tick with empty label for other dates
                                  return charts.TickSpec<String>(
                                    dateStr,
                                    label: '',
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                          behaviors: [
                            charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom,
                              desiredMaxRows: 3,
                              cellPadding: const EdgeInsets.only(
                                right: 4.0,
                                bottom: 4.0,
                              ),
                            ),
                            charts.ChartTitle(
                              'Schultag',
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea,
                            ),
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
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      _buildLegendItem('Entschuldigt', Colors.green),
                      _buildLegendItem('Unentschuldigt', Colors.red),
                      _buildLegendItem('Nach Hause geschickt', Colors.orange),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'zurück',
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const Gap(8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class ChartData {
  final DateTime date;
  final String dateString;
  final int count;
  final String seriesId;

  ChartData({
    required this.date,
    required this.dateString,
    required this.count,
    required this.seriesId,
  });
}
