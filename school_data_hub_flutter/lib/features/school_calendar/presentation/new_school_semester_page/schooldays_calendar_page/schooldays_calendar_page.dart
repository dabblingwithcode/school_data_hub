import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:watch_it/watch_it.dart';

final _schoolCalendarManager = di<SchoolCalendarManager>();

class SchooldaysCalendarPage extends WatchingStatefulWidget {
  const SchooldaysCalendarPage({super.key});

  @override
  SchooldaysCalendarState createState() => SchooldaysCalendarState();
}

class SchooldaysCalendarState extends State<SchooldaysCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  final kFirstDay = DateTime(
    DateTime.now().toLocal().year,
    DateTime.now().toLocal().month - 10,
    DateTime.now().toLocal().day,
  );
  final kLastDay = DateTime(DateTime.now().toLocal().year + 2, 8, 31);

  List<String> _getEventsForDay(DateTime day) {
    final schooldays = _schoolCalendarManager.schooldays.value;
    if (schooldays.any((element) => element.schoolday == day)) {
      return ['Schule'];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    final schooldays = watchValue((SchoolCalendarManager x) => x.schooldays);
    final schooldayDates =
        schooldays.map((e) => e.schoolday.toLocal()).toList();
    // List<MissedSchoolday> missedSchooldays =
    //     di<AttendanceManager>().getMissedSchooldayesOnADay(_selectedDay!);
    return Scaffold(
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
              setState(() {
                _focusedDay = DateTime.now().toLocal();
                _selectedDay = DateTime.now().toLocal();
              });
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     setState(() {
          //       _focusedDay = _focusedDay.subtract(const Duration(days: 7));
          //       _selectedDay = _selectedDay!.subtract(const Duration(days: 7));
          //     });
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              var results = await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(
                  selectableDayPredicate:
                      (day) =>
                          !schooldayDates.any(
                            (element) => element.isSameDate(day),
                          ),
                  calendarType: CalendarDatePicker2Type.multi,
                ),
                dialogSize: const Size(325, 400),
                value: [], //schooldayDates,
                borderRadius: BorderRadius.circular(15),
              );
              if (results == null) return;
              if (results.isEmpty) return;
              final newSchooldayDates = results.whereType<DateTime>().toList();
              await _schoolCalendarManager.postMultipleSchooldays(
                dates: newSchooldayDates.map((e) => e.toLocal()).toList(),
              );
              setState(() {});
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
                backgroundColor: Colors.white,
                collapsedHeight: 450,
                expandedHeight: 450,
                toolbarHeight: 450,
                stretch: true,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  titlePadding: const EdgeInsets.only(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  collapseMode: CollapseMode.none,
                  title: TableCalendar<String>(
                    daysOfWeekHeight: 52,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: const CalendarStyle(
                      canMarkersOverflow: false,
                    ),
                    selectedDayPredicate: (day) {
                      // check if the day is in schooldays
                      bool isSchoolday = schooldays.any(
                        (element) => element.schoolday.isSameDate(day),
                      );
                      return isSchoolday;
                    },
                    locale: 'de_DE',
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    enabledDayPredicate:
                        (day) => schooldayDates.any(
                          (element) => element.isSameDate(day),
                        ),
                    calendarBuilders: CalendarBuilders(
                      singleMarkerBuilder: null,
                      // singleMarkerBuilder: (context, date, events) =>
                      //     Container(
                      //   margin: const EdgeInsets.all(4.0),
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       color: Theme.of(context).primaryColor,
                      //       borderRadius: BorderRadius.circular(20.0)),
                      //   child: Text(
                      //     date.day.toString(),
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // selectedBuilder: (context, day, focusedDay) => Container(
                      //     margin: const EdgeInsets.all(4.0),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: Theme.of(context).primaryColor,
                      //         borderRadius: BorderRadius.circular(25.0)),
                      //     child: Text(
                      //       day.day.toString(),
                      //       style: TextStyle(color: Colors.white),
                      //     )),
                      todayBuilder:
                          (context, date, events) => Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              date.day.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                    ),
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    eventLoader: _getEventsForDay,
                    calendarFormat: _calendarFormat,
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onDayLongPressed: (selectedDay, focusedDay) async {
                      final bool? confirm = await confirmationDialog(
                        context: context,
                        title: 'Schultag löschen',
                        message:
                            'Möchtest du den Schultag ${selectedDay.formatForUser()} wirklich löschen?',
                      );
                      if (confirm == null || !confirm) return;
                      await _schoolCalendarManager.deleteSchoolday(selectedDay);
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:
                    _selectedDay != null
                        ? Row(
                          children: [
                            const Gap(15),
                            Text(
                              DateFormat(
                                'EEEE',
                                Localizations.localeOf(context).toString(),
                              ).format(_selectedDay!),
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(5),
                            Text(
                              ' ${_selectedDay?.formatForUser()}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(40),
                            // Text(
                            //     missedSchooldays
                            //         .where((missedSchoolday) =>
                            //             missedSchoolday.missedType == 'missed')
                            //         .length
                            //         .toString(),
                            //     style: const TextStyle(
                            //         fontSize: 28.0, fontWeight: FontWeight.bold)),
                            // const Gap(20)
                          ],
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
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (BuildContext context, int index) {
              //       return AttendanceCard(
              //           locator<PupilManager>()
              //               .getPupilById(missedSchooldays[index].missedPupilId)!,
              //           _selectedDay!);
              //     },
              //     childCount: missedSchooldays.length,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
