import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/new_school_semester_page/widgets/date_picker_button.dart';

class NewSchoolSemesterPage extends WatchingStatefulWidget {
  final SchoolSemester? semester;

  const NewSchoolSemesterPage({super.key, this.semester});

  @override
  State<NewSchoolSemesterPage> createState() => _NewSchoolSemesterPageState();
}

class _NewSchoolSemesterPageState extends State<NewSchoolSemesterPage> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime? classConferenceDate;
  DateTime? supportConferenceDate;
  DateTime? reportSignedDate;
  DateTime? reportConferenceDate;
  bool isFirst = false;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-populate fields if editing
    if (widget.semester != null) {
      final semester = widget.semester!;
      _textController.text = semester.schoolYear;
      startDate = semester.startDate;
      endDate = semester.endDate;
      classConferenceDate = semester.classConferenceDate;
      supportConferenceDate = semester.supportConferenceDate;
      reportSignedDate = semester.reportSignedDate;
      reportConferenceDate = semester.reportConferenceDate;
      isFirst = semester.isFirst;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final schoolCalendarManager = di<SchoolCalendarManager>();
    final List<SchoolSemester> semesters = watchValue(
      (SchoolCalendarManager m) => m.schoolSemesters,
    );

    bool isNotInExistingSemesters(DateTime day) {
      final dayUtc = day.toDateOnlyUtc();
      for (final semester in semesters) {
        final startUtc = semester.startDate.toDateOnlyUtc();
        final endUtc = semester.endDate.toDateOnlyUtc();
        final isInside = !dayUtc.isBefore(startUtc) && !dayUtc.isAfter(endUtc);
        if (isInside) return false;
      }
      return true;
    }

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_view_month_rounded,
              size: 25,
              color: Colors.white,
            ),
            const Gap(10),
            Text(
              widget.semester != null
                  ? 'Schulhalbjahr bearbeiten'
                  : 'Neues Schulhalbjahr',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  right: 10.00,
                ),
                child: Row(
                  children: [
                    const Text('Schuljahr:', style: TextStyle(fontSize: 13)),
                    const Gap(10),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: 'z.B. 2023/2024',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  right: 10.00,
                ),
                child: Row(
                  children: [
                    const Text('Startdatum:', style: TextStyle(fontSize: 13)),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: startDate,
                      selectableDayPredicate: isNotInExistingSemesters,
                      onDateSelected: (pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            startDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  right: 10.00,
                ),
                child: Row(
                  children: [
                    const Text('Enddatum:', style: TextStyle(fontSize: 13)),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: endDate,
                      firstDate: startDate ?? DateTime(2000),
                      selectableDayPredicate: isNotInExistingSemesters,
                      onDateSelected: (pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            endDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  right: 10.00,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Klassenkonferenzdatum:',
                      style: TextStyle(fontSize: 13),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: classConferenceDate,
                      selectableDayPredicate: isNotInExistingSemesters,
                      onDateSelected: (pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            classConferenceDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  right: 10.00,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Förderkonferenzdatum:',
                      style: TextStyle(fontSize: 13),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: supportConferenceDate,
                      selectableDayPredicate: isNotInExistingSemesters,
                      onDateSelected: (pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            supportConferenceDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  right: 10.00,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Zeugniskonferenzdatum:',
                      style: TextStyle(fontSize: 13),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: reportConferenceDate,
                      selectableDayPredicate: isNotInExistingSemesters,
                      onDateSelected: (pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            reportConferenceDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 15.0,
                  right: 10.00,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Zeugnisausgabe:',
                      style: TextStyle(fontSize: 13),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: reportSignedDate,
                      selectableDayPredicate: isNotInExistingSemesters,
                      onDateSelected: (pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            reportSignedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.semester != null) {
                    // Update existing semester
                    final updatedSemester = widget.semester!.copyWith(
                      schoolYear: _textController.text,
                      startDate: startDate ?? widget.semester!.startDate,
                      endDate: endDate ?? widget.semester!.endDate,
                      classConferenceDate: classConferenceDate,
                      supportConferenceDate: supportConferenceDate,
                      reportSignedDate: reportSignedDate,
                      reportConferenceDate: reportConferenceDate,
                      isFirst: isFirst,
                    );
                    await schoolCalendarManager.updateSchoolSemester(
                      updatedSemester,
                    );
                  } else {
                    // Create new semester
                    await schoolCalendarManager.postSchoolSemester(
                      schoolYearName: _textController.text,
                      startDate: startDate!,
                      endDate: endDate!,
                      classConferenceDate: classConferenceDate,
                      supportConferenceDate: supportConferenceDate,
                      reportSignedDate: reportSignedDate,
                      reportConferenceDate: reportConferenceDate,
                      isFirst: true,
                    );
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  widget.semester != null ? 'Aktualisieren' : 'Senden',
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Abbrechen'),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const SchoolListsBottomNavBar(),
    );
  }
}
