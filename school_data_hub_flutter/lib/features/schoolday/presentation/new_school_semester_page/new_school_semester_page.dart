import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday/presentation/new_school_semester_page/widgets/date_picker_button.dart';
import 'package:watch_it/watch_it.dart';

final _schooldayManager = di<SchooldayManager>();

class NewSchoolSemesterPage extends StatefulWidget {
  const NewSchoolSemesterPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_view_month_rounded,
                size: 25, color: Colors.white),
            Gap(10),
            Text(
              'Neuer Schulsemester',
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
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.00),
                child: Row(
                  children: [
                    const Text(
                      'Startdatum:',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: startDate,
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
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.00),
                child: Row(
                  children: [
                    const Text(
                      'Enddatum:',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: endDate,
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
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.00),
                child: Row(
                  children: [
                    const Text(
                      'Klassenkonferenzdatum:',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: classConferenceDate,
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
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.00),
                child: Row(
                  children: [
                    const Text(
                      'Förderkonferenzdatum:',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: supportConferenceDate,
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
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.00),
                child: Row(
                  children: [
                    const Text(
                      'Zeugniskonferenzdatum:',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: reportConferenceDate,
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
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, right: 10.00),
                child: Row(
                  children: [
                    const Text(
                      'Zeugnisausgabe:',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const Gap(10),
                    DatePickerButton(
                      dateToSelect: reportSignedDate,
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
                  onPressed: () => _schooldayManager.postSchoolSemester(
                      startDate: startDate!,
                      endDate: endDate!,
                      classConferenceDate: classConferenceDate!,
                      supportConferenceDate: supportConferenceDate!,
                      reportSignedDate: reportSignedDate!,
                      reportConferenceDate: reportConferenceDate!,
                      isFirst: true),
                  child: Text('send')),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const SchoolListsBottomNavBar(),
    );
  }
}
