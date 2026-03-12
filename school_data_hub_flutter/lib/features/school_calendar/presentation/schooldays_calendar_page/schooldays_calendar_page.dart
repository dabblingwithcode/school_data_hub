import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/auth/auth_clearance_helper.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_list_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_pupil_list_card/schoolday_event_pupil_list_card.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_helper.dart'
    show SchoolCalendarHelper;
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/schooldays_calendar_page/widgets/schoolday_calendar_day_cell.dart';
import 'package:table_calendar/table_calendar.dart';

class SchooldaysCalendarPage extends WatchingWidget {
  const SchooldaysCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    // -- Local mutable state via createOnce -----------------------------------
    final calendarFormat = createOnce(
      () => ValueNotifier<CalendarFormat>(CalendarFormat.month),
    );
    final focusedDay = createOnce(
      () => ValueNotifier<DateTime>(DateTime.now()),
    );
    final selectedDay = createOnce(
      () => ValueNotifier<DateTime?>(DateTime.now()),
    );

    // false = show missed schooldays, true = show schoolday events
    final showEvents = createOnce(() => ValueNotifier<bool>(false));

    final kFirstDay = createOnce(() {
      final now = DateTime.now().toLocal();
      return DateTime(now.year, now.month - 10, now.day);
    });
    final kLastDay = createOnce(
      () => DateTime(DateTime.now().toLocal().year + 2, 8, 31),
    );

    // -- Watch local notifiers ------------------------------------------------
    final calendarFormatValue = watch(calendarFormat).value;
    final focusedDayValue = watch(focusedDay).value;
    final selectedDayValue = watch(selectedDay).value;
    final showEventsValue = watch(showEvents).value;

    // -- Watch manager data ---------------------------------------------------
    final schooldays = watchValue((SchoolCalendarManager x) => x.schooldays);
    final semesters = watchValue(
      (SchoolCalendarManager x) => x.schoolSemesters,
    );
    watchValue((AttendanceManager x) => x.missedSchooldays);
    final missedCountByDate =
        di<AttendanceManager>().missedSchooldaysCountByDate;
    final eventManager = watchIt<SchooldayEventManager>();
    final eventCountByDate = eventManager.schooldayEventsCountByDate;

    final schooldayDates = schooldays
        .map((e) => e.schoolday.toLocal())
        .toList();

    // -- One-time init (replaces initState) -----------------------------------
    callOnce((context) {
      final manager = di<SchoolCalendarManager>();
      if (manager.schoolSemesters.value.isEmpty) {
        manager.fetchSchoolSemesters();
      }
    });

    // -- Build ----------------------------------------------------------------
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.backgroundColor,
        title: const Center(
          child: Text('Schultage', style: AppStyles.appBarTextStyle),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              focusedDay.value = DateTime.now().toLocal();
              selectedDay.value = DateTime.now().toLocal();
            },
          ),
          if (AuthClearanceHelper.isAdmin())
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    selectableDayPredicate: (day) => !schooldayDates.any(
                      (element) => element.isSameDate(day),
                    ),
                    calendarType: CalendarDatePicker2Type.multi,
                  ),
                  dialogSize: const Size(325, 400),
                  value: [],
                  borderRadius: BorderRadius.circular(15),
                );
                if (results == null) return;
                if (results.isEmpty) return;
                final newSchooldayDates = results
                    .whereType<DateTime>()
                    .toList();
                await di<SchoolCalendarManager>().postMultipleSchooldays(
                  dates: newSchooldayDates.map((e) => e.toLocal()).toList(),
                );
              },
            ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                automaticallyImplyLeading: false,
                leading: const SizedBox.shrink(),
                backgroundColor: AppColors.canvasColor,
                collapsedHeight: 452,
                expandedHeight: 452,
                toolbarHeight: 452,
                stretch: true,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(color: AppColors.canvasColor),
                  titlePadding: const EdgeInsets.only(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  collapseMode: CollapseMode.none,
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      child: TableCalendar<String>(
                        daysOfWeekHeight: 52,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        calendarStyle: const CalendarStyle(
                          canMarkersOverflow: false,
                        ),
                        selectedDayPredicate: (day) {
                          return schooldays.any(
                            (element) => element.schoolday.isSameDate(day),
                          );
                        },
                        locale: 'de_DE',
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month',
                        },
                        enabledDayPredicate: (day) => schooldayDates.any(
                          (element) => element.isSameDate(day),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) =>
                              const SizedBox.shrink(),
                          singleMarkerBuilder: null,
                          defaultBuilder: (context, date, focusedDay) {
                            final key = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            );
                            return schooldayCalendarDayCell(
                              context,
                              date,
                              isFirstSemester:
                                  SchoolCalendarHelper.isDayInFirstSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              showSemesterBadge:
                                  SchoolCalendarHelper.isDayInSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              missedCount: missedCountByDate[key] ?? 0,
                              eventCount: eventCountByDate[key] ?? 0,
                            );
                          },
                          disabledBuilder: (context, date, focusedDay) {
                            final key = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            );
                            return schooldayCalendarDayCell(
                              context,
                              date,
                              fadedText: true,
                              isFirstSemester:
                                  SchoolCalendarHelper.isDayInFirstSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              showSemesterBadge:
                                  SchoolCalendarHelper.isDayInSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              missedCount: missedCountByDate[key] ?? 0,
                              eventCount: eventCountByDate[key] ?? 0,
                            );
                          },
                          outsideBuilder: (context, date, focusedDay) {
                            final key = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            );
                            return schooldayCalendarDayCell(
                              context,
                              date,
                              fadedText: true,
                              isFirstSemester:
                                  SchoolCalendarHelper.isDayInFirstSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              showSemesterBadge:
                                  SchoolCalendarHelper.isDayInSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              missedCount: missedCountByDate[key] ?? 0,
                              eventCount: eventCountByDate[key] ?? 0,
                            );
                          },
                          selectedBuilder: (context, date, focusedDay) {
                            final key = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            );
                            return schooldayCalendarDayCell(
                              context,
                              date,
                              backgroundColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              isFirstSemester:
                                  SchoolCalendarHelper.isDayInFirstSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              showSemesterBadge:
                                  SchoolCalendarHelper.isDayInSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              missedCount: missedCountByDate[key] ?? 0,
                              eventCount: eventCountByDate[key] ?? 0,
                            );
                          },
                          todayBuilder: (context, date, focusedDay) {
                            final key = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            );
                            return schooldayCalendarDayCell(
                              context,
                              date,
                              backgroundColor: Theme.of(context).highlightColor,
                              textColor: Colors.white,
                              isFirstSemester:
                                  SchoolCalendarHelper.isDayInFirstSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              showSemesterBadge:
                                  SchoolCalendarHelper.isDayInSemester(
                                    day: date,
                                    semesters: semesters,
                                    schooldays: schooldays,
                                  ),
                              missedCount: missedCountByDate[key] ?? 0,
                              eventCount: eventCountByDate[key] ?? 0,
                            );
                          },
                        ),
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: focusedDayValue,
                        eventLoader: (day) =>
                            SchoolCalendarHelper.getEventsForDay(
                              day,
                              schooldays,
                            ),
                        calendarFormat: calendarFormatValue,
                        onDaySelected: (selected, focused) {
                          if (!isSameDay(selectedDayValue, selected)) {
                            selectedDay.value = selected;
                            focusedDay.value = focused;
                          }
                        },
                        onDayLongPressed: (selected, focused) async {
                          if (AuthClearanceHelper.isAdmin()) {
                            di<NotificationService>().showInformationDialog(
                              NotificationType.error,
                              'Keine Berechtigung für das Löschen von Schultagen.',
                            );
                            return;
                          }
                          final bool? confirm = await confirmationDialog(
                            context: context,
                            title: 'Schultag löschen',
                            message:
                                'Möchtest du den Schultag ${selected.formatDateForUser()} wirklich löschen?',
                          );
                          if (confirm == null || !confirm) return;
                          await di<SchoolCalendarManager>().deleteSchoolday(
                            selected,
                          );
                        },
                        onFormatChanged: (format) {
                          if (calendarFormatValue != format) {
                            calendarFormat.value = format;
                          }
                        },
                        onPageChanged: (focused) {
                          focusedDay.value = focused;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: selectedDayValue != null
                    ? Builder(
                        builder: (context) {
                          final key = DateTime(
                            selectedDayValue.year,
                            selectedDayValue.month,
                            selectedDayValue.day,
                          );
                          final missed = missedCountByDate[key] ?? 0;
                          final events = eventCountByDate[key] ?? 0;
                          return Row(
                            children: [
                              const Gap(15),
                              Expanded(
                                child: Text(
                                  '${DateFormat('EEEE', Localizations.localeOf(context).toString()).format(selectedDayValue)} ${selectedDayValue.formatDateForUser()}',
                                  style: const TextStyle(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Gap(10),
                              IconButton(
                                icon: Icon(
                                  Icons.person_off,
                                  color: !showEventsValue
                                      ? AppColors.backgroundColor
                                      : null,
                                ),
                                onPressed: () => showEvents.value = false,
                              ),
                              Text(
                                '$missed',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: !showEventsValue
                                      ? AppColors.backgroundColor
                                      : null,
                                ),
                              ),
                              const Gap(10),
                              IconButton(
                                icon: Icon(
                                  Icons.warning_rounded,
                                  color: showEventsValue
                                      ? AppColors.cancelButtonColor
                                      : null,
                                ),
                                onPressed: () => showEvents.value = true,
                              ),
                              Text(
                                '$events',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: showEventsValue
                                      ? AppColors.cancelButtonColor
                                      : null,
                                ),
                              ),
                              const Gap(15),
                            ],
                          );
                        },
                      )
                    : const Row(
                        children: [
                          Gap(15),
                          Text(
                            'Kein Tag ausgewählt',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
              if (selectedDayValue != null)
                Builder(
                  builder: (context) {
                    final key = DateTime(
                      selectedDayValue.year,
                      selectedDayValue.month,
                      selectedDayValue.day,
                    );
                    if (showEventsValue) {
                      // -- Schoolday events mode --
                      final eventsForDay =
                          eventManager.schooldayEventsByDate[key] ?? [];
                      // Deduplicate by pupilId to show one card per pupil.
                      final uniquePupilIds = eventsForDay
                          .map((e) => e.pupilId)
                          .toSet()
                          .toList();
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((
                          BuildContext context,
                          int index,
                        ) {
                          final pupil = di<PupilProxyManager>()
                              .getPupilByPupilId(uniquePupilIds[index]);
                          if (pupil == null) return const SizedBox.shrink();
                          return SchooldayEventPupilListCard(pupil);
                        }, childCount: uniquePupilIds.length),
                      );
                    } else {
                      // -- Missed schooldays mode --
                      final missedForDay =
                          di<AttendanceManager>().missedSchooldaysByDate[key] ??
                          [];
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((
                          BuildContext context,
                          int index,
                        ) {
                          final missed = missedForDay[index];
                          final pupil = di<PupilProxyManager>()
                              .getPupilByPupilId(missed.pupilId);
                          if (pupil == null) return const SizedBox.shrink();
                          return AttendanceCard(pupil, selectedDayValue);
                        }, childCount: missedForDay.length),
                      );
                    }
                  },
                )
              else
                const SliverToBoxAdapter(child: SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
