import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';

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
      int dialogDropdownValue = isEditing
          ? existingSupportLevel.level
          : (value ?? 0);

      DateTime selectedDate = isEditing
          ? existingSupportLevel.createdAt
          : DateTime.now().toUtc();
      String textValue = isEditing
          ? (existingSupportLevel.comment.isNotEmpty
                ? customEncrypter.decryptString(existingSupportLevel.comment)
                : '')
          : '';
      return StatefulBuilder(
        builder: (context, setState) {
          final style = Style.of(context);
          final hubSessionManager = di<HubSessionManager>();
          final notificationService = di<NotificationManager>();
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(Style.spacing.sm),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        value: dialogDropdownValue,
                        items: [
                          DropdownMenuItem(
                            value: 0,
                            child: Center(
                              child: Text(
                                "Förderebene 0",
                                textAlign: TextAlign.center,
                                style: context.typography.title
                                    .withColor(style.colors.foreground),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Center(
                              child: Text(
                                "Förderebene 1",
                                textAlign: TextAlign.center,
                                style: context.typography.title
                                    .withColor(style.colors.foreground),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Center(
                              child: Text(
                                "Förderebene 2",
                                textAlign: TextAlign.center,
                                style: context.typography.title
                                    .withColor(style.colors.foreground),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Center(
                              child: Text(
                                "Förderebene 3",
                                textAlign: TextAlign.center,
                                style: context.typography.title
                                    .withColor(style.colors.foreground),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Center(
                              child: Text(
                                "Regenbogenförderung",
                                textAlign: TextAlign.center,
                                style: context.typography.title
                                    .withColor(style.colors.foreground),
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
                  Gap(Style.spacing.md),
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
                      style: context.typography.title
                          .withColor(style.colors.accent),
                    ),
                  ),
                  Gap(Style.spacing.md),
                  TextFormField(
                    initialValue: textValue,
                    onChanged: (newTextValue) {
                      setState(() {
                        textValue = newTextValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Kommentar',
                      labelStyle: context.typography.title
                          .withColor(style.colors.foreground),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: style.colors.foreground),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              isEditing ? 'Förderebene bearbeiten' : 'Förderebene ändern',
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(Style.spacing.lg),
                child: GestureDetector(
                  child: Text(
                    'ABBRECHEN',
                    style: context.typography.title
                        .withColor(style.colors.accent),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Style.spacing.lg),
                child: GestureDetector(
                  child: Text(
                    'OK',
                    style: context.typography.title
                        .withColor(style.colors.accent),
                  ),
                  onTap: () async {
                    if (textValue.isEmpty) {
                      notificationService.showInformationDialog(
                        NotificationType.error,
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
