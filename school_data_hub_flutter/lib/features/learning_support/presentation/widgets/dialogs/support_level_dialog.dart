import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> supportLevelDialog(
    BuildContext context, PupilProxy pupil, int? value) async {
  return await showDialog(
      context: context,
      builder: (context) {
        int dialogDropdownValue = value ?? 0;

        DateTime selectedDate = DateTime.now().toUtc();
        String textValue = '';
        return StatefulBuilder(builder: (context, setState) {
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
                                child: Text("kein Eintrag",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: 1,
                              child: Center(
                                child: Text("Förderebene 1",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: 2,
                              child: Center(
                                child: Text("Förderebene 2",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: 3,
                              child: Center(
                                child: Text("Förderebene 3",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                          DropdownMenuItem(
                              value: 4,
                              child: Center(
                                child: Text("Regenbogenförderung",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              )),
                        ],
                        onChanged: (newvalue) {
                          setState(() {
                            dialogDropdownValue = newvalue!;
                          });
                        }),
                  ),
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Text(selectedDate.formatForUser(),
                      style: const TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                ),
                const Gap(10),
                TextFormField(
                  onChanged: (newTextValue) {
                    setState(() {
                      textValue = newTextValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Kommentar',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            )),
            title: const Text('Förderebene ändern'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'ABBRECHEN',
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                        color: AppColors.accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // TODO: uncomment when ready
                    // _pupilManager. .patchPupilWithNewSupportLevel(
                    //       pupilId: pupil.internalId,
                    //       level: dialogDropdownValue,
                    //       createdAt: selectedDate,
                    //       createdBy: 'Test',
                    //       comment: textValue);

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
      });
}
