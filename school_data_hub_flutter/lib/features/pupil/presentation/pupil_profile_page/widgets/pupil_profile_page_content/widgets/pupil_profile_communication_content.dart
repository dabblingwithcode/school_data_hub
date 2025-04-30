import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/dialogs/language_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/communication_values.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();
final _serverpodSessionManager = di<ServerpodSessionManager>();

class PupilCommunicationContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilCommunicationContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: AppPaddings.pupilProfileCardPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.language_rounded,
                color: AppColors.groupColor,
                size: 24,
              ),
              Gap(5),
              Text(
                'Sprache(n)',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor),
              ),
            ],
          ),
          const Gap(15),
          Row(
            children: [
              const Text('Familiensprache:', style: TextStyle(fontSize: 18.0)),
              const Gap(10),
              Text(pupil.language,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold))
            ],
          ),
          const Gap(10),
          Row(
            children: [
              const Text('Erstförderung:', style: TextStyle(fontSize: 18.0)),
              const Gap(10),
              Text(
                  pupil.migrationSupportEnds != null
                      ? 'bis : ${pupil.migrationSupportEnds!.formatForUser()}'
                      : 'keine',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold)),
            ],
          ),
          const Gap(10),
          const Row(
            children: [
              Text(
                'Deutsch - Sprachkompetenz',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(10),
          const Row(
            children: [
              Text(
                'Kind:',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const Gap(10),
          InkWell(
            onTap: () =>
                languageDialog(context, pupil, CommunicationSubject.pupil),
            onLongPress: () => _pupilManager.updatePupilCommunicationSkills(
              pupilId: pupil.pupilId,
              communicationSkills: CommunicationSkills(
                understanding: 0,
                speaking: 0,
                reading: 0,
                createdBy: _serverpodSessionManager.userName!,
                createdAt: DateTime.now(),
              ),
            ),
            child: pupil.communicationPupil == null
                ? const Text(
                    'kein Eintrag',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundColor),
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Center(
                            child: InkWell(
                              child: CommunicationValues(
                                  communicationSkills:
                                      pupil.communicationPupil!),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          const Gap(10),
          const Row(
            children: [
              Text(
                'Mutter / TutorIn 1:',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const Gap(10),
          InkWell(
            onTap: () =>
                languageDialog(context, pupil, CommunicationSubject.tutor1),
            onLongPress: () => _pupilManager.updateTutorInfo(
                internalId: pupil.internalId,
                tutorInfo: pupil.tutorInfo != null
                    ? pupil.tutorInfo!.copyWith(communicationTutor1: null)
                    : TutorInfo(createdBy: _serverpodSessionManager.userName!)),
            child: pupil.tutorInfo == null
                ? const Text(
                    'kein Eintrag',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundColor),
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Gap(10),
                          InkWell(
                            child: CommunicationValues(
                                communicationSkills:
                                    pupil.tutorInfo!.communicationTutor1),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          const Gap(10),
          const Row(
            children: [
              Text(
                'Vater / TutorIn 2:',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const Gap(10),
          InkWell(
            onTap: () =>
                languageDialog(context, pupil, CommunicationSubject.tutor2),
            onLongPress: () => _pupilManager.updateTutorInfo(
                internalId: pupil.internalId,
                tutorInfo: pupil.tutorInfo != null
                    ? pupil.tutorInfo!.copyWith(communicationTutor2: null)
                    : TutorInfo(createdBy: _serverpodSessionManager.userName!)),
            child: pupil.tutorInfo == null
                ? const Text(
                    'kein Eintrag',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundColor),
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Gap(10),
                          InkWell(
                            child: CommunicationValues(
                                communicationSkills:
                                    pupil.tutorInfo!.communicationTutor2),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          const Gap(10)
        ]),
      ),
    );
  }
}
