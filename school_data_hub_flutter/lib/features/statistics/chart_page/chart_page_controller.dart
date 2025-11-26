import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page.dart';
import 'package:watch_it/watch_it.dart';

class ChartPageController extends StatefulWidget {
  const ChartPageController({super.key});

  @override
  State<ChartPageController> createState() => _ChartPageControllerState();
}

class _ChartPageControllerState extends State<ChartPageController> {
  late final PupilManager _pupilManager;
  late final SchoolCalendarManager _schoolCalendarManager;
  late final SchooldayEventManager _schooldayEventManager;

  @override
  void initState() {
    super.initState();
    _pupilManager = di<PupilManager>();
    _schoolCalendarManager = di<SchoolCalendarManager>();
    _schooldayEventManager = di<SchooldayEventManager>();
  }

  /// Gets schooldays for the current semester
  List<Schoolday> getSchooldaysForCurrentSemester() {
    final currentSemester = _schoolCalendarManager.getCurrentSchoolSemester();
    if (currentSemester == null) {
      return [];
    }

    final allSchooldays = _schoolCalendarManager.schooldays.value;
    final semesterStart = currentSemester.startDate.toLocal();
    final semesterEnd = currentSemester.endDate.toLocal();

    return allSchooldays.where((schoolday) {
      final schooldayDate = schoolday.schoolday.toLocal();
      final startDate = DateTime(
        semesterStart.year,
        semesterStart.month,
        semesterStart.day,
      );
      final endDate = DateTime(
        semesterEnd.year,
        semesterEnd.month,
        semesterEnd.day,
      );
      final dayDate = DateTime(
        schooldayDate.year,
        schooldayDate.month,
        schooldayDate.day,
      );
      return (dayDate.isAfter(startDate) || dayDate == startDate) &&
          (dayDate.isBefore(endDate) || dayDate == endDate);
    }).toList()..sort((a, b) => a.schoolday.compareTo(b.schoolday));
  }

  /// Counts pupils with specialNeeds for a given schoolday
  /// Only counts pupils where pupilSince <= schoolday date
  int getSpecialNeedsCountForSchoolday(Schoolday schoolday) {
    final pupils = _pupilManager.allPupils;
    final schooldayDate = schoolday.schoolday.toLocal();
    final dayDate = DateTime(
      schooldayDate.year,
      schooldayDate.month,
      schooldayDate.day,
    );

    return pupils.where((pupil) {
      final pupilSince = pupil.pupilSince.toLocal();
      final sinceDate = DateTime(
        pupilSince.year,
        pupilSince.month,
        pupilSince.day,
      );
      // Pupil must be enrolled on or before this schoolday
      if (sinceDate.isAfter(dayDate)) {
        return false;
      }
      // Pupil must have specialNeeds
      return pupil.specialNeeds != null && pupil.specialNeeds!.isNotEmpty;
    }).length;
  }

  /// Counts pupils with migrationSupportEnds for a given schoolday
  /// Only counts pupils where pupilSince <= schoolday date
  /// and migrationSupportEnds is on or after the schoolday
  int getMigrationSupportCountForSchoolday(Schoolday schoolday) {
    final pupils = _pupilManager.allPupils;
    final schooldayDate = schoolday.schoolday.toLocal();
    final dayDate = DateTime(
      schooldayDate.year,
      schooldayDate.month,
      schooldayDate.day,
    );

    return pupils.where((pupil) {
      final pupilSince = pupil.pupilSince.toLocal();
      final sinceDate = DateTime(
        pupilSince.year,
        pupilSince.month,
        pupilSince.day,
      );
      // Pupil must be enrolled on or before this schoolday
      if (sinceDate.isAfter(dayDate)) {
        return false;
      }

      // Pupil must have migrationSupportEnds
      if (pupil.migrationSupportEnds == null) {
        return false;
      }

      // Check if migrationSupportEnds falls on a valid schoolday
      final supportEndsDate = pupil.migrationSupportEnds!.toLocal();
      final supportDate = DateTime(
        supportEndsDate.year,
        supportEndsDate.month,
        supportEndsDate.day,
      );
      return dayDate.isBefore(supportDate) || dayDate == supportDate;
    }).length;
  }

  /// Counts new pupils enrolled during the semester up to a given schoolday
  /// Cumulative count starting from 0 on the first semester day
  int getNewPupilsCountForSchoolday(
    Schoolday schoolday,
    List<Schoolday> allSchooldays,
  ) {
    final currentSemester = _schoolCalendarManager.getCurrentSchoolSemester();
    if (currentSemester == null) {
      return 0;
    }

    // First day of semester should always be 0
    if (allSchooldays.isNotEmpty) {
      final firstDay = allSchooldays.first.schoolday.toLocal();
      final currentDay = schoolday.schoolday.toLocal();
      final firstDayDate = DateTime(
        firstDay.year,
        firstDay.month,
        firstDay.day,
      );
      final currentDayDate = DateTime(
        currentDay.year,
        currentDay.month,
        currentDay.day,
      );
      if (firstDayDate == currentDayDate) {
        return 0;
      }
    }

    final pupils = _pupilManager.allPupils;
    final schooldayDate = schoolday.schoolday.toLocal();
    final dayDate = DateTime(
      schooldayDate.year,
      schooldayDate.month,
      schooldayDate.day,
    );
    final semesterStart = currentSemester.startDate.toLocal();
    final semesterStartDate = DateTime(
      semesterStart.year,
      semesterStart.month,
      semesterStart.day,
    );

    return pupils.where((pupil) {
      final pupilSince = pupil.pupilSince.toLocal();
      final sinceDate = DateTime(
        pupilSince.year,
        pupilSince.month,
        pupilSince.day,
      );
      // Pupil must be enrolled on or before this schoolday
      // AND pupilSince must be within the semester (on or after semester start)
      return (sinceDate.isBefore(dayDate) || sinceDate == dayDate) &&
          (sinceDate.isAfter(semesterStartDate) ||
              sinceDate == semesterStartDate);
    }).length;
  }

  /// Counts pupils with support level 3 (no special needs) for a given schoolday
  /// Only counts pupils where pupilSince <= schoolday date
  /// and latestSupportLevel.createdAt <= schoolday date
  int getSupportLevel3CountForSchoolday(Schoolday schoolday) {
    final pupils = _pupilManager.allPupils;
    final schooldayDate = schoolday.schoolday.toLocal();
    final dayDate = DateTime(
      schooldayDate.year,
      schooldayDate.month,
      schooldayDate.day,
    );

    return pupils.where((pupil) {
      final pupilSince = pupil.pupilSince.toLocal();
      final sinceDate = DateTime(
        pupilSince.year,
        pupilSince.month,
        pupilSince.day,
      );
      // Pupil must be enrolled on or before this schoolday
      if (sinceDate.isAfter(dayDate)) {
        return false;
      }

      // Pupil must NOT have specialNeeds
      if (pupil.specialNeeds != null && pupil.specialNeeds!.isNotEmpty) {
        return false;
      }

      // Pupil must have latestSupportLevel with level == 3
      final latestSupportLevel = pupil.latestSupportLevel;
      if (latestSupportLevel == null || latestSupportLevel.level != 3) {
        return false;
      }

      // latestSupportLevel.createdAt must be equal to or before the schoolday
      final supportCreatedAt = latestSupportLevel.createdAt.toLocal();
      final supportDate = DateTime(
        supportCreatedAt.year,
        supportCreatedAt.month,
        supportCreatedAt.day,
      );
      if (supportDate.isAfter(dayDate)) {
        return false;
      }

      return true;
    }).length;
  }

  /// Counts pupils without specialNeeds, migrationSupport, or support level 3 for a given schoolday
  /// Only counts pupils where pupilSince <= schoolday date
  int getRegularPupilsCountForSchoolday(Schoolday schoolday) {
    final pupils = _pupilManager.allPupils;
    final schooldayDate = schoolday.schoolday.toLocal();
    final dayDate = DateTime(
      schooldayDate.year,
      schooldayDate.month,
      schooldayDate.day,
    );

    return pupils.where((pupil) {
      final pupilSince = pupil.pupilSince.toLocal();
      final sinceDate = DateTime(
        pupilSince.year,
        pupilSince.month,
        pupilSince.day,
      );
      // Pupil must be enrolled on or before this schoolday
      if (sinceDate.isAfter(dayDate)) {
        return false;
      }

      // Pupil must NOT have specialNeeds
      if (pupil.specialNeeds != null && pupil.specialNeeds!.isNotEmpty) {
        return false;
      }

      // Pupil must NOT have active migrationSupportEnds
      // (migrationSupportEnds is null OR it's before this schoolday)
      if (pupil.migrationSupportEnds != null) {
        final supportEndsDate = pupil.migrationSupportEnds!.toLocal();
        final supportDate = DateTime(
          supportEndsDate.year,
          supportEndsDate.month,
          supportEndsDate.day,
        );
        // If migrationSupportEnds is on or after this schoolday, pupil has migration support
        if (dayDate.isBefore(supportDate) || dayDate == supportDate) {
          return false;
        }
      }

      // Pupil must NOT have support level 3 (no special needs)
      final latestSupportLevel = pupil.latestSupportLevel;
      if (latestSupportLevel != null && latestSupportLevel.level == 3) {
        final supportCreatedAt = latestSupportLevel.createdAt.toLocal();
        final supportDate = DateTime(
          supportCreatedAt.year,
          supportCreatedAt.month,
          supportCreatedAt.day,
        );
        // If support level 3 was created on or before this schoolday, exclude from regular
        if (supportDate.isBefore(dayDate) || supportDate == dayDate) {
          return false;
        }
      }

      return true;
    }).length;
  }

  /// Counts events by type for a given schoolday
  int getEventCountForSchoolday(
    Schoolday schoolday,
    SchooldayEventType eventType,
  ) {
    final allEvents = _schooldayEventManager.schooldayEvents;
    final schooldayDate = schoolday.schoolday.toLocal();
    final dayDate = DateTime(
      schooldayDate.year,
      schooldayDate.month,
      schooldayDate.day,
    );

    return allEvents.where((event) {
      // Match by schooldayId if available, otherwise by date
      if (event.schooldayId == schoolday.id) {
        return event.eventType == eventType;
      }
      
      // Fallback: match by date if schoolday object is available
      if (event.schoolday != null) {
        final eventDate = event.schoolday!.schoolday.toLocal();
        final eventDayDate = DateTime(
          eventDate.year,
          eventDate.month,
          eventDate.day,
        );
        if (eventDayDate == dayDate && event.eventType == eventType) {
          return true;
        }
      }
      
      return false;
    }).length;
  }

  /// Gets data for the chart: schooldays with their counts
  Map<
    DateTime,
    ({
      int specialNeeds,
      int migrationSupport,
      int supportLevel3,
      int regularPupils,
      int newPupils,
    })
  >
  getChartData() {
    final schooldays = getSchooldaysForCurrentSemester();
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
    data = {};

    for (final schoolday in schooldays) {
      data[schoolday.schoolday] = (
        specialNeeds: getSpecialNeedsCountForSchoolday(schoolday),
        migrationSupport: getMigrationSupportCountForSchoolday(schoolday),
        supportLevel3: getSupportLevel3CountForSchoolday(schoolday),
        regularPupils: getRegularPupilsCountForSchoolday(schoolday),
        newPupils: getNewPupilsCountForSchoolday(schoolday, schooldays),
      );
    }

    return data;
  }

  /// Gets event data for the chart: schooldays with event counts by type
  Map<
    DateTime,
    ({
      int parentsMeeting,
      int admonition,
      int afternoonCareAdmonition,
      int admonitionAndBanned,
      int otherEvent,
    })
  >
  getEventChartData() {
    final schooldays = getSchooldaysForCurrentSemester();
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
    data = {};

    for (final schoolday in schooldays) {
      data[schoolday.schoolday] = (
        parentsMeeting: getEventCountForSchoolday(
          schoolday,
          SchooldayEventType.parentsMeeting,
        ),
        admonition: getEventCountForSchoolday(
          schoolday,
          SchooldayEventType.admonition,
        ),
        afternoonCareAdmonition: getEventCountForSchoolday(
          schoolday,
          SchooldayEventType.afternoonCareAdmonition,
        ),
        admonitionAndBanned: getEventCountForSchoolday(
          schoolday,
          SchooldayEventType.admonitionAndBanned,
        ),
        otherEvent: getEventCountForSchoolday(
          schoolday,
          SchooldayEventType.otherEvent,
        ),
      );
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final chartData = getChartData();
    final schooldays = getSchooldaysForCurrentSemester();

    if (schooldays.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xfff2f2f7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(74, 76, 161, 1),
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart_rounded, size: 25, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Statistik Diagramm',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
        body: const Center(child: Text('Kein Schulhalbjahr gefunden')),
      );
    }

    final eventChartData = getEventChartData();

    return ChartPage(
      chartData: chartData,
      eventChartData: eventChartData,
      schooldays: schooldays,
    );
  }
}
