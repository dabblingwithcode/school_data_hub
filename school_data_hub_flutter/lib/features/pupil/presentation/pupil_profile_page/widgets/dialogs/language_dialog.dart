import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/dialogs/language_dialog_dropdown.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();

final _serverpodSessionManager = di<ServerpodSessionManager>();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/
// TODO: It must be a better way to do this

Future<void> languageDialog(BuildContext context, PupilProxy pupil,
    CommunicationSubject subject) async {
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
        int dropdownUnderstandValue = languageValue?.understanding ?? 0;
        int dropdownSpeakValue = languageValue?.speaking ?? 0;
        int dropdownReadValue = languageValue?.reading ?? 0;

        return StatefulBuilder(builder: (context, setState) {
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
                )),
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
                    languageValue = CommunicationSkills(
                      understanding: dropdownUnderstandValue,
                      speaking: dropdownSpeakValue,
                      reading: dropdownReadValue,
                      createdBy: _serverpodSessionManager.userName!,
                    );
                    switch (subject) {
                      case CommunicationSubject.pupil:
                        _pupilManager.updateCommunicationSkills(
                            pupilId: pupil.pupilId, skills: languageValue);
                        break;
                      case CommunicationSubject.tutor1:
                        final tutorInfo = pupil.tutorInfo != null
                            ? pupil.tutorInfo!.copyWith(
                                communicationTutor1: languageValue,
                              )
                            : TutorInfo(
                                communicationTutor1: languageValue,
                                createdBy: _serverpodSessionManager.userName!,
                              );
                        _pupilManager.updateTutorInfo(
                            internalId: pupil.internalId, tutorInfo: tutorInfo);
                        break;
                      case CommunicationSubject.tutor2:
                        final tutorInfo = pupil.tutorInfo != null
                            ? pupil.tutorInfo!.copyWith(
                                communicationTutor2: languageValue,
                              )
                            : TutorInfo(
                                communicationTutor2: languageValue,
                                createdBy: _serverpodSessionManager.userName!,
                              );
                        _pupilManager.updateTutorInfo(
                            internalId: pupil.internalId, tutorInfo: tutorInfo);
                        break;
                    }
                    // _pupilManager.updateTutorInfo(internalId: pupil.internalId, tutorInfo: tutorInfo)
                    // patchOnePupilProperty(
                    //     pupilId: pupil.internalId,
                    //     jsonKey: type,
                    //     value: communicationValue);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
      });
}
