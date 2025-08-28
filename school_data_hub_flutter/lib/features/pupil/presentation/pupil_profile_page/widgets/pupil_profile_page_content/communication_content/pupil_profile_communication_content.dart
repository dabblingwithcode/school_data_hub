import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager_operations.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/communication_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/communication_content/dialogs/language_dialog.dart';
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
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.canvasColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.backgroundColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.language_rounded,
                  color: AppColors.groupColor,
                  size: 28,
                ),
                Gap(12),
                Text(
                  'Sprachen',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          // Language Information Section
          _buildInfoSection(
            icon: Icons.translate_rounded,
            title: 'Sprachinformationen',
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.home_outlined,
                  label: 'Familiensprache',
                  value: pupil.language,
                ),
                const Gap(8),
                _buildInfoRow(
                  icon: Icons.support_outlined,
                  label: 'Erstförderung',
                  value:
                      pupil.migrationSupportEnds != null
                          ? 'bis : ${pupil.migrationSupportEnds!.formatForUser()}'
                          : 'keine',
                ),
                const Gap(8),
                _buildInfoRow(
                  icon: Icons.support_outlined,
                  label: 'HKU',
                  value:
                      pupil.familyLanguageLessonsSince != null
                          ? 'seit ${pupil.familyLanguageLessonsSince!.formatForUser()}'
                          : 'nein',
                ),
              ],
            ),
          ),
          const Gap(8),
          // German Language Competence Section
          _buildInfoSection(
            icon: Icons.record_voice_over_outlined,
            title: 'Deutsch - Sprachkompetenz',
            child: Column(
              children: [
                _buildCommunicationRow(
                  label: 'Kind',
                  communicationSkills: communicationPupil,
                  onTap:
                      () => languageDialog(
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
                      PupilManagerOperations().updatePupilCommunicationSkills(
                        pupilId: pupil.pupilId,
                        communicationSkills: null,
                      );
                    }
                  },
                ),
                const Gap(10),
                _buildCommunicationRow(
                  label: 'Mutter / TutorIn 1',
                  communicationSkills: tutorInfo?.communicationTutor1,
                  onTap:
                      () => languageDialog(
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
                      PupilManagerOperations().updateTutorInfo(
                        pupilId: pupil.pupilId,
                        tutorInfo: tutorInfo?.copyWith(
                          communicationTutor1: null,
                        ),
                      );
                    }
                  },
                ),
                const Gap(10),
                _buildCommunicationRow(
                  label: 'Vater / TutorIn 2',
                  communicationSkills: tutorInfo?.communicationTutor2,
                  onTap:
                      () => languageDialog(
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
                      PupilManagerOperations().updateTutorInfo(
                        pupilId: pupil.pupilId,
                        tutorInfo:
                            tutorInfo != null
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

  // Helper method to build section containers
  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.backgroundColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        color: AppColors.cardInCardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.backgroundColor, size: 25),
              const Gap(10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backgroundColor,
                ),
              ),
            ],
          ),
          const Gap(12),
          child,
        ],
      ),
    );
  }

  // Helper method to build information rows
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Widget? actionButton,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.pupilProfileCardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.backgroundColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.backgroundColor.withValues(alpha: 0.7),
            size: 18,
          ),
          const Gap(8),
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.backgroundColor,
            ),
          ),
          const Gap(6),
          Expanded(
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      onTap != null
                          ? AppColors.interactiveColor.withValues(alpha: 0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        onTap != null
                            ? AppColors.interactiveColor
                            : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          if (actionButton != null) ...[const Gap(8), actionButton],
        ],
      ),
    );
  }

  // Helper method to build communication rows
  Widget _buildCommunicationRow({
    required String label,
    required CommunicationSkills? communicationSkills,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.pupilProfileCardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.backgroundColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: AppColors.backgroundColor,
                  size: 18,
                ),
              ),
              const Gap(3),
              Text(
                '$label:',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.backgroundColor,
                ),
              ),
            ],
          ),
          const Gap(8),
          InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.interactiveColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.interactiveColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child:
                  communicationSkills == null
                      ? const Text(
                        'kein Eintrag - tippen zum Hinzufügen',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: AppColors.interactiveColor,
                        ),
                      )
                      : CommunicationValues(
                        communicationSkills: communicationSkills,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
