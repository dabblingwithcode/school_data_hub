import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/dialogs/language_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/communication_values.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();
final _serverpodSessionManager = di<ServerpodSessionManager>();

class PupilProfileCommunicationContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileCommunicationContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final communicationPupil =
        watchPropertyValue((m) => m.communicationPupil, target: pupil);
    final tutorInfo = watchPropertyValue((m) => m.tutorInfo, target: pupil);

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
            onLongPress: () async {
              if (_serverpodSessionManager.isAdmin == false) {
                informationDialog(context, 'Keine Berechtigung',
                    'Diese Aktion ist nur für Admins verfügbar.');
                return;
              }
              await confirmationDialog(
                  context: context,
                  title: 'Eintrag zurücksetzen',
                  message: 'Eintrag zurücksetzen?');

              _pupilManager.updatePupilCommunicationSkills(
                pupilId: pupil.pupilId,
                communicationSkills: null,
              );
            },
            child: communicationPupil == null
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
                                  communicationSkills: communicationPupil),
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
            onLongPress: () async {
              final isAdmin = _serverpodSessionManager.isAdmin;
              if (!isAdmin) {
                informationDialog(context, 'Keine Berechtigung',
                    'Diese Aktion ist nur für Admins verfügbar.');
                return;
              }
              final success = await confirmationDialog(
                  context: context,
                  title: 'Eintrag zurücksetzen',
                  message: 'Eintrag zurücksetzen?');
              if (success == false) {
                return;
              }
              _pupilManager.updateTutorInfo(
                  pupilId: pupil.pupilId,
                  tutorInfo: tutorInfo?.copyWith(communicationTutor1: null));
            },
            child: tutorInfo == null
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
                                    tutorInfo.communicationTutor1),
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
                pupilId: pupil.pupilId,
                tutorInfo: tutorInfo != null
                    ? tutorInfo.copyWith(communicationTutor2: null)
                    : TutorInfo(createdBy: _serverpodSessionManager.userName!)),
            child: tutorInfo == null
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
                                    tutorInfo.communicationTutor2),
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
