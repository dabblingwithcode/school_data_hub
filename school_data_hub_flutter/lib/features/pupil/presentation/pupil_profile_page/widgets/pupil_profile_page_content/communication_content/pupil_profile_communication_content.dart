import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/communication_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/dialogs/language_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();
final _hubSessionManager = di<HubSessionManager>();

class PupilProfileCommunicationContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileCommunicationContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final communicationPupil = watchPropertyValue(
      (m) => m.communicationPupil,
      target: pupil,
    );
    final tutorInfo = watchPropertyValue((m) => m.tutorInfo, target: pupil);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pupilProfileBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Language Information Section
          // Language Information Section
          PupilProfileContentSection(
            icon: Icons.translate_rounded,
            title: 'Sprachinformationen',
            child: Column(
              children: [
                PupilProfileContentRow(
                  icon: Icons.home_outlined,
                  label: 'Familiensprache',
                  value: pupil.language,
                ),
                const Gap(8),
                PupilProfileContentRow(
                  icon: Icons.support_outlined,
                  label: 'Erstförderung',
                  value: pupil.migrationSupportEnds != null
                      ? 'bis : ${pupil.migrationSupportEnds!.formatDateForUser()}'
                      : 'keine',
                ),
                const Gap(8),
                PupilProfileContentRow(
                  icon: Icons.support_outlined,
                  label: 'HKU',
                  value: pupil.familyLanguageLessonsSince != null
                      ? 'seit ${pupil.familyLanguageLessonsSince!.formatDateForUser()}'
                      : 'nein',
                ),
              ],
            ),
          ),
          const Gap(8),
          // German Language Competence Section
          // German Language Competence Section
          PupilProfileContentSection(
            icon: Icons.record_voice_over_outlined,
            title: 'Deutsch - Sprachkompetenz',
            child: Column(
              children: [
                PupilProfileContentRow(
                  icon: Icons.person_outline,
                  label: 'Kind',
                  valueWidget: communicationPupil == null
                      ? const Text(
                          'kein Eintrag - tippen zum Hinzufügen',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: AppColors.interactiveColor,
                          ),
                        )
                      : CommunicationValues(
                          communicationSkills: communicationPupil,
                        ),
                  onTap: () => languageDialog(
                    context,
                    pupil,
                    CommunicationSubject.pupil,
                  ),
                  onLongPress: () async {
                    if (_hubSessionManager.isAdmin == false) {
                      informationDialog(
                        context,
                        'Keine Berechtigung',
                        'Diese Aktion ist nur für Admins verfügbar.',
                      );
                      return;
                    }
                    final confirm = await confirmationDialog(
                      context: context,
                      title: 'Eintrag zurücksetzen',
                      message: 'Eintrag zurücksetzen?',
                    );
                    if (confirm == true) {
                      PupilMutator().updatePupilCommunicationSkills(
                        pupilId: pupil.pupilId,
                        communicationSkills: null,
                      );
                    }
                  },
                ),
                const Gap(10),
                PupilProfileContentRow(
                  icon: Icons.person_outline,
                  label: 'Mutter / TutorIn 1',
                  valueWidget: tutorInfo?.communicationTutor1 == null
                      ? const Text(
                          'kein Eintrag - tippen zum Hinzufügen',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: AppColors.interactiveColor,
                          ),
                        )
                      : CommunicationValues(
                          communicationSkills: tutorInfo!.communicationTutor1,
                        ),
                  onTap: () => languageDialog(
                    context,
                    pupil,
                    CommunicationSubject.tutor1,
                  ),
                  onLongPress: () async {
                    final isAdmin = _hubSessionManager.isAdmin;
                    if (!isAdmin) {
                      informationDialog(
                        context,
                        'Keine Berechtigung',
                        'Diese Aktion ist nur für Admins verfügbar.',
                      );
                      return;
                    }
                    final success = await confirmationDialog(
                      context: context,
                      title: 'Eintrag zurücksetzen',
                      message: 'Eintrag zurücksetzen?',
                    );
                    if (success == true) {
                      PupilMutator().updateTutorInfo(
                        pupilId: pupil.pupilId,
                        tutorInfo: tutorInfo?.copyWith(
                          communicationTutor1: null,
                        ),
                      );
                    }
                  },
                ),
                const Gap(10),
                PupilProfileContentRow(
                  icon: Icons.person_outline,
                  label: 'Vater / TutorIn 2',
                  valueWidget: tutorInfo?.communicationTutor2 == null
                      ? const Text(
                          'kein Eintrag - tippen zum Hinzufügen',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: AppColors.interactiveColor,
                          ),
                        )
                      : CommunicationValues(
                          communicationSkills: tutorInfo!.communicationTutor2,
                        ),
                  onTap: () => languageDialog(
                    context,
                    pupil,
                    CommunicationSubject.tutor2,
                  ),
                  onLongPress: () async {
                    final isAdmin = _hubSessionManager.isAdmin;
                    if (!isAdmin) {
                      informationDialog(
                        context,
                        'Keine Berechtigung',
                        'Diese Aktion ist nur für Admins verfügbar.',
                      );
                      return;
                    }
                    final success = await confirmationDialog(
                      context: context,
                      title: 'Eintrag zurücksetzen',
                      message: 'Eintrag zurücksetzen?',
                    );
                    if (success == true) {
                      PupilMutator().updateTutorInfo(
                        pupilId: pupil.pupilId,
                        tutorInfo: tutorInfo != null
                            ? tutorInfo.copyWith(communicationTutor2: null)
                            : TutorInfo(
                                createdBy: _hubSessionManager.userName!,
                              ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const Gap(20), // Extra spacing at the bottom
        ],
      ),
    );
  }
}
