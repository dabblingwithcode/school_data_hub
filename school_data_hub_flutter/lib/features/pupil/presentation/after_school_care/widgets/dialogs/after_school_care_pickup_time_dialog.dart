import 'package:flutter/material.dart';

// Dialog for selecting pickup times for after school care
// This is a legacy dialog that needs to be updated to use proper AfterSchoolCare model
// TODO: Update to use proper AfterSchoolCare model with per-day pickup times

Future<void> pickUpTimeDialog(
  BuildContext context,
  dynamic pupil,
  String? value,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      int dialogDropdownValue = value != null ? int.parse(value) : 0;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        value: dialogDropdownValue,
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Center(
                              child: Text(
                                "kein Eintrag",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Center(
                              child: Text(
                                "14:00 Uhr",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Center(
                              child: Text(
                                "15:00 Uhr",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Center(
                              child: Text(
                                "16:00 Uhr",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (newvalue) {
                          setState(() {
                            dialogDropdownValue = newvalue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: const Text('OGS-Abholzeit'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'ABBRECHEN',
                    style: TextStyle(
                      color:
                          Colors
                              .blue, // Using Colors.blue instead of AppColors.accentColor
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color:
                          Colors
                              .blue, // Using Colors.blue instead of AppColors.accentColor
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    // TODO: This method doesn't exist and needs to be implemented
                    // For now, we're using a placeholder that shows the intended functionality
                    // The actual implementation would need an updateAfterSchoolCare method

                    // locator<PupilManager>().updateAfterSchoolCarePickupTime(
                    //     pupilId: pupil.pupilId,
                    //     pickupTime: dialogDropdownValue.toString());

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
