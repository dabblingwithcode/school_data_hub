import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page.dart';
import 'package:watch_it/watch_it.dart';

class ChartPageController extends StatefulWidget {
  const ChartPageController({super.key});

  @override
  State<ChartPageController> createState() => _ChartPageControllerState();
}

class _ChartPageControllerState extends State<ChartPageController> {
  late final PupilProxyManager _pupilManager;
  late final SchoolCalendarManager _schoolCalendarManager;
  late final SchooldayEventManager _schooldayEventManager;
  late final AttendanceManager _attendanceManager;

  bool _isLoading = true;
  List<Schoolday> _schooldays = [];

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
  _chartData = {};

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
  _eventChartData = {};

  Map<DateTime, ({int excused, int unexcused, int goneHome})>
  _attendanceChartData = {};

  @override
  void initState() {
    super.initState();
    _pupilManager = di<PupilProxyManager>();
    _schoolCalendarManager = di<SchoolCalendarManager>();
    _schooldayEventManager = di<SchooldayEventManager>();
    _attendanceManager = di<AttendanceManager>();

    _loadData();
  }

  /// Gets schooldays for the current semester
  List<Schoolday> _getSchooldaysForCurrentSemester() {
    final currentSemester = _schoolCalendarManager.getCurrentSchoolSemester();
    if (currentSemester == null) {
      return [];
    }

    final allSchooldays = _schoolCalendarManager.schooldays.value;
    final semesterStart = currentSemester.startDate.toLocal();
    final semesterEnd = currentSemester.endDate.toLocal();
    final now = DateTime.now().toLocal();
    final today = DateTime(now.year, now.month, now.day);

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

      // Check if day is in future
      if (dayDate.isAfter(today)) {
        return false;
      }

      return (dayDate.isAfter(startDate) || dayDate == startDate) &&
          (dayDate.isBefore(endDate) || dayDate == endDate);
    }).toList()..sort((a, b) => a.schoolday.compareTo(b.schoolday));
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    // 1. Get Schooldays
    final schooldays = _getSchooldaysForCurrentSemester();

    if (schooldays.isEmpty) {
      if (mounted) {
        setState(() {
          _schooldays = [];
          _chartData = {};
          _eventChartData = {};
          _attendanceChartData = {};
          _isLoading = false;
        });
      }
      return;
    }

    // 2. Pre-process Events
    final allEvents = _schooldayEventManager.schooldayEvents;
    final eventsById = <int, List<SchooldayEvent>>{};
    final eventsByDateMap = <DateTime, List<SchooldayEvent>>{};

    for (final event in allEvents) {
      if (event.schooldayId != null) {
        eventsById.putIfAbsent(event.schooldayId!, () => []).add(event);
      }

      final d = event.schoolday!.schoolday.toLocal();
      final dayDate = DateTime(d.year, d.month, d.day);
      eventsByDateMap.putIfAbsent(dayDate, () => []).add(event);
    }

    // 3. Pre-process Attendance
    final allMissed = _attendanceManager.missedSchooldays.value;
    final missedById = <int, List<MissedSchoolday>>{};
    final missedByDate = <DateTime, List<MissedSchoolday>>{};

    for (final missed in allMissed) {
      if (missed.schooldayId != null) {
        missedById.putIfAbsent(missed.schooldayId!, () => []).add(missed);
      }

      final d = missed.schoolday!.schoolday.toLocal();
      final dayDate = DateTime(d.year, d.month, d.day);
      missedByDate.putIfAbsent(dayDate, () => []).add(missed);
    }

    // 4. Pre-process Pupils
    final pupils = _pupilManager.allPupils;
    final processedPupils = pupils.map((pupil) {
      final pupilSince = pupil.pupilSince.toLocal();
      final sinceDate = DateTime(
        pupilSince.year,
        pupilSince.month,
        pupilSince.day,
      );

      DateTime? migrationEnd;
      if (pupil.migrationSupportEnds != null) {
        final d = pupil.migrationSupportEnds!.toLocal();
        migrationEnd = DateTime(d.year, d.month, d.day);
      }

      DateTime? supportCreated;
      int? supportLevel;
      if (pupil.latestSupportLevel != null) {
        supportLevel = pupil.latestSupportLevel!.level;
        final d = pupil.latestSupportLevel!.createdAt.toLocal();
        supportCreated = DateTime(d.year, d.month, d.day);
      }

      return (
        sinceDate: sinceDate,
        hasSpecialNeeds:
            pupil.specialNeeds != null && pupil.specialNeeds!.isNotEmpty,
        migrationEnd: migrationEnd,
        supportLevel: supportLevel,
        supportCreated: supportCreated,
      );
    }).toList();

    final currentSemester = _schoolCalendarManager.getCurrentSchoolSemester();
    // currentSemester can't be null if schooldays is not empty (checked by _getSchooldaysForCurrentSemester)
    // but to be safe:
    if (currentSemester == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    final semesterStart = currentSemester.startDate.toLocal();
    final semesterStartDate = DateTime(
      semesterStart.year,
      semesterStart.month,
      semesterStart.day,
    );

    final chartData =
        <
          DateTime,
          ({
            int specialNeeds,
            int migrationSupport,
            int supportLevel3,
            int regularPupils,
            int newPupils,
          })
        >{};
    final eventChartData =
        <
          DateTime,
          ({
            int parentsMeeting,
            int admonition,
            int afternoonCareAdmonition,
            int admonitionAndBanned,
            int otherEvent,
          })
        >{};
    final attendanceChartData =
        <DateTime, ({int excused, int unexcused, int goneHome})>{};

    // 5. Iterate Schooldays
    for (final schoolday in schooldays) {
      final sDate = schoolday.schoolday.toLocal();
      final dayDate = DateTime(sDate.year, sDate.month, sDate.day);

      // --- Pupil Stats ---
      int specialNeeds = 0;
      int migrationSupport = 0;
      int supportLevel3 = 0;
      int regularPupils = 0;
      int newPupils = 0;

      for (final p in processedPupils) {
        // Enrolled check
        if (p.sinceDate.isAfter(dayDate)) continue;

        // New Pupils
        if ((p.sinceDate.isBefore(dayDate) || p.sinceDate == dayDate) &&
            (p.sinceDate.isAfter(semesterStartDate) ||
                p.sinceDate == semesterStartDate)) {
          newPupils++;
        }

        // Special Needs
        if (p.hasSpecialNeeds) {
          specialNeeds++;
        }

        // Migration Support
        bool isMigration = false;
        if (p.migrationEnd != null) {
          if (dayDate.isBefore(p.migrationEnd!) || dayDate == p.migrationEnd!) {
            migrationSupport++;
            isMigration = true;
          }
        }

        // Support Level 3
        bool isLevel3 = false;
        if (!p.hasSpecialNeeds &&
            p.supportLevel == 3 &&
            p.supportCreated != null) {
          if (p.supportCreated!.isBefore(dayDate) ||
              p.supportCreated == dayDate) {
            supportLevel3++;
            isLevel3 = true;
          }
        }

        // Regular
        if (!p.hasSpecialNeeds && !isMigration && !isLevel3) {
          regularPupils++;
        }
      }

      // Fix New Pupils for first day of semester logic
      if (schooldays.isNotEmpty) {
        final firstDay = schooldays.first.schoolday.toLocal();
        final firstDayDate = DateTime(
          firstDay.year,
          firstDay.month,
          firstDay.day,
        );
        if (dayDate == firstDayDate) {
          newPupils = 0;
        }
      }

      chartData[schoolday.schoolday] = (
        specialNeeds: specialNeeds,
        migrationSupport: migrationSupport,
        supportLevel3: supportLevel3,
        regularPupils: regularPupils,
        newPupils: newPupils,
      );

      // --- Events ---
      final List<SchooldayEvent> dayEvents = [];
      if (eventsById.containsKey(schoolday.id)) {
        dayEvents.addAll(eventsById[schoolday.id]!);
      }
      if (eventsByDateMap.containsKey(dayDate)) {
        for (final e in eventsByDateMap[dayDate]!) {
          if (e.schooldayId != schoolday.id) {
            dayEvents.add(e);
          }
        }
      }

      int parentsMeeting = 0;
      int admonition = 0;
      int afternoonCareAdmonition = 0;
      int admonitionAndBanned = 0;
      int otherEvent = 0;

      for (final e in dayEvents) {
        switch (e.eventType) {
          case SchooldayEventType.parentsMeeting:
            parentsMeeting++;
            break;
          case SchooldayEventType.admonition:
            admonition++;
            break;
          case SchooldayEventType.afternoonCareAdmonition:
            afternoonCareAdmonition++;
            break;
          case SchooldayEventType.admonitionAndBanned:
            admonitionAndBanned++;
            break;
          case SchooldayEventType.otherEvent:
            otherEvent++;
            break;
          default:
            break;
        }
      }

      eventChartData[schoolday.schoolday] = (
        parentsMeeting: parentsMeeting,
        admonition: admonition,
        afternoonCareAdmonition: afternoonCareAdmonition,
        admonitionAndBanned: admonitionAndBanned,
        otherEvent: otherEvent,
      );

      // --- Attendance ---
      final List<MissedSchoolday> dayMissed = [];
      if (missedById.containsKey(schoolday.id)) {
        dayMissed.addAll(missedById[schoolday.id]!);
      }
      if (missedByDate.containsKey(dayDate)) {
        for (final m in missedByDate[dayDate]!) {
          if (m.schooldayId != schoolday.id) {
            dayMissed.add(m);
          }
        }
      }

      int excused = 0;
      int unexcused = 0;
      int goneHome = 0;

      for (final m in dayMissed) {
        if (m.missedType == MissedType.missed) {
          if (m.unexcused == true) {
            unexcused++;
          } else {
            excused++;
          }
        }
        if (m.returned == true) {
          goneHome++;
        }
      }

      attendanceChartData[schoolday.schoolday] = (
        excused: excused,
        unexcused: unexcused,
        goneHome: goneHome,
      );
    }

    if (mounted) {
      setState(() {
        _schooldays = schooldays;
        _chartData = chartData;
        _eventChartData = eventChartData;
        _attendanceChartData = attendanceChartData;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
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
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_schooldays.isEmpty) {
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

    return ChartPage(
      chartData: _chartData,
      eventChartData: _eventChartData,
      attendanceChartData: _attendanceChartData,
      schooldays: _schooldays,
    );
  }
}
