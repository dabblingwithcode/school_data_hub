import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/dialogs/language_dialog_dropdown.dart';
import 'package:watch_it/watch_it.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/
// TODO: It must be a better way to do this

Future<void> languageDialog(
  BuildContext context,
  PupilProxy pupil,
  CommunicationSubject subject,
) async {
  final _hubSessionManager = di<HubSessionManager>();
  CommunicationSkills? languageValue;
  switch (subject) {
    case CommunicationSubject.pupil:
      languageValue = pupil.communicationPupil;
      break;
    case CommunicationSubject.tutor1:
      languageValue = pupil.tutorInfo?.communicationTutor1;
      break;
    case CommunicationSubject.tutor2:
      languageValue = pupil.tutorInfo?.communicationTutor2;
      break;
  }
  return await showDialog(
    context: context,
    builder: (context) {
      int dropdownUnderstandValue = languageValue?.understanding ?? 4;
      int dropdownSpeakValue = languageValue?.speaking ?? 4;
      int dropdownReadValue = languageValue?.reading ?? 4;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: SizedBox(
              width: 700,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LanguageDialogDropdown(
                    value: dropdownUnderstandValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownUnderstandValue = newValue!;
                      });
                    },
                    label: "Versteht",
                    icon: Icons.hearing,
                  ),
                  LanguageDialogDropdown(
                    value: dropdownSpeakValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownSpeakValue = newValue!;
                      });
                    },
                    label: "spricht",
                    icon: Icons.chat_bubble_outline_rounded,
                  ),
                  LanguageDialogDropdown(
                    value: dropdownReadValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownReadValue = newValue!;
                      });
                    },
                    label: "liest",
                    icon: Icons.book,
                  ),
                ],
              ),
            ),
            title: const Text('Kommunikation auf Deutsch'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
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
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    languageValue = CommunicationSkills(
                      understanding: dropdownUnderstandValue,
                      speaking: dropdownSpeakValue,
                      reading: dropdownReadValue,
                      createdBy: _hubSessionManager.userName!,
                      createdAt: DateTime.now(),
                    );
                    switch (subject) {
                      case CommunicationSubject.pupil:
                        PupilMutator().updateCommunicationSkills(
                          pupilId: pupil.pupilId,
                          skills: languageValue,
                        );
                        break;
                      case CommunicationSubject.tutor1:
                        final tutorInfo = pupil.tutorInfo != null
                            ? pupil.tutorInfo!.copyWith(
                                communicationTutor1: languageValue,
                              )
                            : TutorInfo(
                                communicationTutor1: languageValue,
                                createdBy: _hubSessionManager.userName!,
                              );
                        PupilMutator().updateTutorInfo(
                          pupilId: pupil.pupilId,
                          tutorInfo: tutorInfo,
                        );
                        break;
                      case CommunicationSubject.tutor2:
                        final tutorInfo = pupil.tutorInfo != null
                            ? pupil.tutorInfo!.copyWith(
                                communicationTutor2: languageValue,
                              )
                            : TutorInfo(
                                communicationTutor2: languageValue,
                                createdBy: _hubSessionManager.userName!,
                              );
                        PupilMutator().updateTutorInfo(
                          pupilId: pupil.pupilId,
                          tutorInfo: tutorInfo,
                        );
                        break;
                    }

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
