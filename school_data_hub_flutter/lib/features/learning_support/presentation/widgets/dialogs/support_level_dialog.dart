import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:flutter_it/flutter_it.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> supportLevelDialog(
  BuildContext context,
  PupilProxy pupil,
  int? value, {
  SupportLevel? existingSupportLevel,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      final bool isEditing = existingSupportLevel != null;
      int dialogDropdownValue =
          isEditing ? existingSupportLevel.level : (value ?? 0);

      DateTime selectedDate =
          isEditing ? existingSupportLevel.createdAt : DateTime.now().toUtc();
      String textValue =
          isEditing
              ? (existingSupportLevel.comment.isNotEmpty
                  ? customEncrypter.decryptString(
                    existingSupportLevel.comment,
                  )
                  : '')
              : '';
      return StatefulBuilder(
        builder: (context, setState) {
          final hubSessionManager = di<HubSessionManager>();
          final notificationService = di<NotificationService>();
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
                                "Förderebene 0",
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
                                "Förderebene 1",
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
                                "Förderebene 2",
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
                                "Förderebene 3",
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
                            value: 4,
                            child: Center(
                              child: Text(
                                "Regenbogenförderung",
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
                  const Gap(10),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Text(
                      selectedDate.formatDateForUser(),
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Gap(10),
                  TextFormField(
                    initialValue: textValue,
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
              ),
            ),
            title: Text(
              isEditing
                  ? 'Förderebene bearbeiten'
                  : 'Förderebene ändern',
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: Text(
                    'ABBRECHEN',
                    style: TextStyle(
                      color: AppColors.accentColor,
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
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    if (textValue.isEmpty) {
                      notificationService.showInformationDialog(
                        'Das Kommentarfeld darf nicht leer sein.',
                      );
                      return;
                    }
                    if (isEditing) {
                      await PupilMutator().deleteSupportLevelHistoryItem(
                        pupilId: pupil.pupilId,
                        supportLevelId: existingSupportLevel.id!,
                      );
                    }
                    PupilMutator().updatePupilSupportLevel(
                      pupilId: pupil.pupilId,
                      comment: textValue,
                      level: dialogDropdownValue,
                      createdAt: selectedDate,
                      createdBy: hubSessionManager.userName!,
                    );

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
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
