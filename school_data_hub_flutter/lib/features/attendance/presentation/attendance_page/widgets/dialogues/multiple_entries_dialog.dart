import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/schoolday/domain/schoolday_manager.dart';
import 'package:watch_it/watch_it.dart';

final GlobalKey<FormState> _missedDatesformKey = GlobalKey<FormState>();

final _attendanceManager = di<AttendanceManager>();

final _schooldayManager = di<SchooldayManager>();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> createMissedClassList(
    BuildContext context, PupilProxy pupil) async {
  final DateTime thisDate = _schooldayManager.thisDate.value;
  return await showDialog(
      context: context,
      builder: (context) {
        // final schooldayManager = di<SchooldayManager>();
        // schooldayManager.setStartDate(thisDate);
        // schooldayManager.setEndDate(thisDate);
        String dialogdropdownValue = 'missed';
        DateTime startDate = thisDate;
        DateTime endDate = thisDate;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _missedDatesformKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            value: dialogdropdownValue,
                            items: [
                              DropdownMenuItem(
                                  value: 'missed',
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.orange[300],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text("F",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          )),
                                    ),
                                  )),
                              DropdownMenuItem(
                                  value: 'home',
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text("H",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          )),
                                    ),
                                  )),
                            ],
                            onChanged: (newvalue) {
                              setState(() {
                                dialogdropdownValue = newvalue!;
                              });
                            }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('von',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        const Gap(15),
                        InkWell(
                            onTap: () async {
                              final DateTime? date =
                                  await selectSchooldayDate(context, thisDate);
                              if (date != null) {
                                setState(() {
                                  startDate = date;
                                });
                              }
                            },
                            child: Text(
                              startDate.formatForUser(),
                              style: const TextStyle(
                                color: AppColors.interactiveColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            )),
                        const Gap(5),
                        IconButton(
                            onPressed: () async {
                              final DateTime? date =
                                  await selectSchooldayDate(context, thisDate);
                              if (date != null) {
                                setState(() {
                                  startDate = date;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_today,
                              color: AppColors.interactiveColor,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('bis',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        const Gap(15),
                        InkWell(
                            onTap: () async {
                              final DateTime? date =
                                  await selectSchooldayDate(context, thisDate);
                              if (date != null) {
                                setState(() {
                                  endDate = date;
                                });
                              }
                            },
                            child: Text(
                              endDate.formatForUser(),
                              style: const TextStyle(
                                color: AppColors.interactiveColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            )),
                        const Gap(5),
                        IconButton(
                            onPressed: () async {
                              final DateTime? date =
                                  await selectSchooldayDate(context, thisDate);
                              if (date != null) {
                                setState(() {
                                  endDate = date;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_today,
                              color: AppColors.interactiveColor,
                            )),
                      ],
                    ),
                  ],
                )),
            title: const Text(
              'Mehrere Einträge',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    if (_missedDatesformKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  }, // Add onPressed
                  child: const Text(
                    "ABBRECHEN",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () {
                    if (_missedDatesformKey.currentState!.validate()) {
                      _attendanceManager.createManyMissedClasses(
                          pupil.internalId,
                          startDate,
                          endDate,
                          dialogdropdownValue);
                      _missedDatesformKey.currentState!.reset();
                      Navigator.of(context).pop();
                    }
                  }, // Add onPressed
                  child: const Text(
                    "OK",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
            ],
          );
        });
      });
}
