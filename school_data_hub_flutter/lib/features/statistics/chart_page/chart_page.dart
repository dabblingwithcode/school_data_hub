import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/bottom_nav_bar_no_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/widgets/attendance_stats_view.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/widgets/chart_page_bottom_bar.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/widgets/event_stats_view.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/widgets/pupil_stats_view.dart';
import 'package:watch_it/watch_it.dart';

class ChartPage extends WatchingWidget {
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
  final Map<DateTime, ({int excused, int unexcused, int goneHome})>
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

  @override
  Widget build(BuildContext context) {
    final selectedIndex = createOnce<ValueNotifier>(
      () => ValueNotifier<int>(0),
    );
    final index = watchPropertyValue((m) => m.value, target: selectedIndex);

    if (schooldays.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.canvasColor,
        appBar: const GenericAppBar(
          iconData: Icons.bar_chart_rounded,
          title: 'Statistik Diagramm',
        ),
        body: const Center(child: Text('Keine Daten verfügbar')),
        bottomNavigationBar: const BottomNavBarNoFilterButton(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.bar_chart_rounded,
        title: 'Statistik Diagramm',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: _buildBody(index),
        ),
      ),
      bottomNavigationBar: ChartPageBottomBar(
        selectedIndex: index,
        onDestinationSelected: (value) => selectedIndex.value = value,
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return PupilStatsView(
          sortedSchooldays: sortedSchooldays,
          chartData: chartData,
        );
      case 1:
        return EventStatsView(
          sortedSchooldays: sortedSchooldays,
          eventChartData: eventChartData,
        );
      case 2:
        return AttendanceStatsView(
          sortedSchooldays: sortedSchooldays,
          attendanceChartData: attendanceChartData,
        );
      default:
        return const SizedBox.shrink();
    }
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
