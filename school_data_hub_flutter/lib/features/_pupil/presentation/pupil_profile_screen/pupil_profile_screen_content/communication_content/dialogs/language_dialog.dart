import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/popup.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/communication_content/dialogs/language_dialog_dropdown.dart';

Future<void> languageDialog(
  BuildContext context,
  PupilProxy pupil,
  CommunicationSubject subject,
) async {
  final hubSessionManager = di<HubSessionManager>();
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

  return await Popup.show(
    context: context,
    title: 'Kommunikation auf Deutsch',
    child: _LanguageDialogContent(
      initialUnderstanding: languageValue?.understanding ?? 4,
      initialSpeaking: languageValue?.speaking ?? 4,
      initialReading: languageValue?.reading ?? 4,
      onConfirm: (understanding, speaking, reading) {
        final newValue = CommunicationSkills(
          understanding: understanding,
          speaking: speaking,
          reading: reading,
          createdBy: hubSessionManager.userName!,
          createdAt: DateTime.now(),
        );
        switch (subject) {
          case CommunicationSubject.pupil:
            PupilMutator().updateCommunicationSkills(
              pupilId: pupil.pupilId,
              skills: newValue,
            );
            break;
          case CommunicationSubject.tutor1:
            final tutorInfo = pupil.tutorInfo != null
                ? pupil.tutorInfo!.copyWith(communicationTutor1: newValue)
                : TutorInfo(
                    communicationTutor1: newValue,
                    createdBy: hubSessionManager.userName!,
                  );
            PupilMutator().updateTutorInfo(
              pupilId: pupil.pupilId,
              tutorInfo: tutorInfo,
            );
            break;
          case CommunicationSubject.tutor2:
            final tutorInfo = pupil.tutorInfo != null
                ? pupil.tutorInfo!.copyWith(communicationTutor2: newValue)
                : TutorInfo(
                    communicationTutor2: newValue,
                    createdBy: hubSessionManager.userName!,
                  );
            PupilMutator().updateTutorInfo(
              pupilId: pupil.pupilId,
              tutorInfo: tutorInfo,
            );
            break;
        }
      },
    ),
  );
}

class _LanguageDialogContent extends StatefulWidget {
  final int initialUnderstanding;
  final int initialSpeaking;
  final int initialReading;
  final void Function(int understanding, int speaking, int reading) onConfirm;

  const _LanguageDialogContent({
    required this.initialUnderstanding,
    required this.initialSpeaking,
    required this.initialReading,
    required this.onConfirm,
  });

  @override
  State<_LanguageDialogContent> createState() => _LanguageDialogContentState();
}

class _LanguageDialogContentState extends State<_LanguageDialogContent> {
  late int _understanding;
  late int _speaking;
  late int _reading;

  @override
  void initState() {
    super.initState();
    _understanding = widget.initialUnderstanding;
    _speaking = widget.initialSpeaking;
    _reading = widget.initialReading;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LanguageDialogDropdown(
          value: _understanding,
          onChanged: (newValue) {
            setState(() {
              _understanding = newValue!;
            });
          },
          label: "Versteht",
          icon: Icons.hearing,
        ),
        LanguageDialogDropdown(
          value: _speaking,
          onChanged: (newValue) {
            setState(() {
              _speaking = newValue!;
            });
          },
          label: "spricht",
          icon: Icons.chat_bubble_outline_rounded,
        ),
        LanguageDialogDropdown(
          value: _reading,
          onChanged: (newValue) {
            setState(() {
              _reading = newValue!;
            });
          },
          label: "liest",
          icon: Icons.book,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Button.small(
              variant: ButtonVariant.ghost,
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: 'ABBRECHEN',
            ),
            const SizedBox(width: 8),
            Button.small(
              onPressed: () {
                widget.onConfirm(_understanding, _speaking, _reading);
                Navigator.of(context).pop();
              },
              label: 'OK',
            ),
          ],
        ),
      ],
    );
  }
}
