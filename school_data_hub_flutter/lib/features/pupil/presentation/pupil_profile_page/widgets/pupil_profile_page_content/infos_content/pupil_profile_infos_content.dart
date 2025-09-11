import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/widgets/dialogues/logout_devices_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_page/new_matrix_user_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/widgets/avatar_auth_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/widgets/pupil_media_auth_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();

final _matrixPolicyManager = di<MatrixPolicyManager>();

final _hubSessionManager = di<HubSessionManager>();

class PupilProfileInfosContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileInfosContent({required this.pupil, super.key});
  TextEditingController createController() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final pupilSiblings = _pupilManager.getSiblings(pupil);
    watch(pupil);
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pupilProfileBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: AppColors.backgroundColor,
                    size: 28,
                  ),
                  const Gap(12),
                  Text(
                    'Persönliche Informationen',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(8), // Reduced from 24 to 16
          // Special Information Section
          _buildInfoSection(
            icon: Icons.priority_high_rounded,
            title: 'Besondere Infos',
            child: InkWell(
              onTap: () async {
                final String? specialInformation = await longTextFieldDialog(
                  title: 'Besondere Infos',
                  labelText: 'Besondere Infos',
                  initialValue: pupil.specialInformation ?? '',
                  parentContext: context,
                );
                if (specialInformation == null) return;
                await PupilMutator().updateStringProperty(
                  pupilId: pupil.pupilId,
                  property: 'specialInformation',
                  value: specialInformation,
                );
              },
              onLongPress: () async {
                if (pupil.specialInformation == null) return;
                final bool? confirm = await confirmationDialog(
                  context: context,
                  title: 'Besondere Infos löschen',
                  message: 'Besondere Informationen für dieses Kind löschen?',
                );
                if (confirm == false || confirm == null) return;
                await PupilMutator().updateStringProperty(
                  pupilId: pupil.pupilId,
                  property: 'specialInformation',
                  value: null,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      pupil.specialInformation != null
                          ? AppColors.backgroundColor.withValues(alpha: 0.05)
                          : AppColors.interactiveColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        pupil.specialInformation != null
                            ? AppColors.backgroundColor.withValues(alpha: 0.2)
                            : AppColors.interactiveColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  pupil.specialInformation ??
                      'Tippen Sie hier, um besondere Informationen hinzuzufügen',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        pupil.specialInformation != null
                            ? FontWeight.w500
                            : FontWeight.normal,
                    color:
                        pupil.specialInformation != null
                            ? AppColors.backgroundColor
                            : AppColors.interactiveColor,
                    fontStyle:
                        pupil.specialInformation == null
                            ? FontStyle.italic
                            : FontStyle.normal,
                  ),
                ),
              ),
            ),
          ),
          const Gap(8),
          // Basic Information Section
          _buildInfoSection(
            icon: Icons.person_outline,
            title: 'Grunddaten',
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.wc,
                  label: 'Geschlecht',
                  value: pupil.gender == 'm' ? 'männlich' : 'weiblich',
                ),
                const Gap(8), // Reduced from 12 to 8
                _buildInfoRow(
                  icon: Icons.cake_outlined,
                  label: 'Geburtsdatum',
                  value: pupil.birthday.formatForUser(),
                ),
                const Gap(8), // Reduced from 12 to 8
                _buildInfoRow(
                  icon: Icons.school_outlined,
                  label: 'Aufnahmedatum',
                  value: pupil.pupilSince.formatForUser(),
                ),
              ],
            ),
          ),
          const Gap(8),
          // Contact Information Section
          _buildInfoSection(
            icon: Icons.contact_phone_outlined,
            title: 'Kontaktinformationen',
            child: Column(
              children: [
                _buildContactRow(
                  icon: Icons.person_outline,
                  label: 'Schüler/in Kontakt',
                  value:
                      pupil.contact?.isNotEmpty == true
                          ? pupil.contact!
                          : 'keine Angabe',
                  onTap: () {
                    if (pupil.contact != null && pupil.contact!.isNotEmpty) {
                      MatrixPolicyHelper.launchMatrixUrl(
                        context,
                        pupil.contact!,
                      );
                    }
                  },
                  onLongPress: () async {
                    final String? contact = await shortTextfieldDialog(
                      title: 'Kontakt',
                      hintText: 'Kontakt des Schülers/der Schülerin',
                      labelText: 'Kontakt',
                      textinField: pupil.contact ?? '',
                      context: context,
                    );
                    if (contact == null) return;
                    await PupilMutator().updateStringProperty(
                      pupilId: pupil.pupilId,
                      property: 'contact',
                      value: contact,
                    );
                  },
                  actionButton:
                      pupil.contact == null || pupil.contact!.isEmpty
                          ? IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (ctx) => NewMatrixUserPage(
                                        pupil: pupil,
                                        matrixId:
                                            MatrixPolicyHelper.generateMatrixId(
                                              isParent: false,
                                            ),
                                        displayName:
                                            '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (${pupil.group})',
                                      ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 24,
                              color: AppColors.interactiveColor,
                            ),
                          )
                          : IconButton(
                            onPressed: () async {
                              final confirmation = await confirmationDialog(
                                context: context,
                                title: 'Passwort zurücksetzen',
                                message:
                                    'Möchten Sie das Passwort wirklich zurücksetzen?',
                              );
                              if (confirmation != true) return;
                              if (context.mounted) {
                                final logOutDevices = await logoutDevicesDialog(
                                  context,
                                );
                                if (logOutDevices == null) return;
                                final file = await _matrixPolicyManager.users
                                    .resetPasswordAndPrintCredentialsFile(
                                      user:
                                          MatrixUserHelper.usersFromUserIds([
                                            pupil.contact!,
                                          ]).first,
                                      logoutDevices: logOutDevices,
                                      isStaff: false,
                                    );
                                if (file != null && context.mounted) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              PdfViewerPage(pdfFile: file),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.qr_code_2_rounded,
                              size: 24,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                ),
                const Gap(10), // Reduced from 16 to 10
                _buildContactRow(
                  icon: Icons.family_restroom_outlined,
                  label: 'Familie Kontakt',
                  value: pupil.tutorInfo?.parentsContact ?? 'keine Angabe',
                  onTap: () {
                    final bool tutorInfoExists = pupil.tutorInfo != null;
                    if (tutorInfoExists &&
                        pupil.tutorInfo!.parentsContact != null) {
                      MatrixPolicyHelper.launchMatrixUrl(
                        context,
                        pupil.tutorInfo!.parentsContact!,
                      );
                    }
                  },
                  onLongPress: () async {
                    final String? parentsContact = await shortTextfieldDialog(
                      title: 'Kontakt Familie',
                      hintText: 'Kontakt der Familie',
                      labelText: 'Kontakt Familie',
                      textinField:
                          pupil.tutorInfo?.parentsContact ?? 'keine Angabe',
                      context: context,
                    );
                    if (parentsContact == null) return;
                    await PupilMutator().updateTutorInfo(
                      pupilId: pupil.pupilId,
                      tutorInfo:
                          pupil.tutorInfo != null
                              ? pupil.tutorInfo!.copyWith(
                                parentsContact: parentsContact,
                              )
                              : TutorInfo(
                                parentsContact: parentsContact,
                                createdBy: _hubSessionManager.userName!,
                              ),
                    );
                  },
                  actionButton:
                      pupil.tutorInfo?.parentsContact == null
                          ? IconButton(
                            onPressed: () {
                              String? pupilSiblingsGroups;
                              if (pupil.family != null) {
                                pupilSiblingsGroups =
                                    [
                                      ..._pupilManager.getSiblings(pupil),
                                      pupil,
                                    ].map((e) => e.group).toList().join();
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (ctx) => NewMatrixUserPage(
                                        pupil: pupil,
                                        matrixId:
                                            MatrixPolicyHelper.generateMatrixId(
                                              isParent: true,
                                            ),
                                        displayName:
                                            pupilSiblingsGroups != null
                                                ? 'Fa. ${pupil.lastName} (E) $pupilSiblingsGroups'
                                                : '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (E) ${pupil.group}',
                                        isParent: true,
                                      ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 24,
                              color: AppColors.interactiveColor,
                            ),
                          )
                          : IconButton(
                            onPressed: () async {
                              final confirmation = await confirmationDialog(
                                context: context,
                                title: 'Passwort zurücksetzen',
                                message:
                                    'Möchten Sie das Passwort wirklich zurücksetzen?',
                              );
                              if (confirmation != true) return;
                              if (context.mounted) {
                                final logOutDevices = await logoutDevicesDialog(
                                  context,
                                );
                                if (logOutDevices == null) return;
                                final file = await _matrixPolicyManager.users
                                    .resetPasswordAndPrintCredentialsFile(
                                      user:
                                          MatrixUserHelper.usersFromUserIds([
                                            pupil.tutorInfo!.parentsContact!,
                                          ]).first,
                                      logoutDevices: logOutDevices,
                                      isStaff: false,
                                    );
                                if (file != null && context.mounted) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              PdfViewerPage(pdfFile: file),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.qr_code_2_rounded,
                              size: 24,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                ),
              ],
            ),
          ),
          const Gap(8),
          // Authorizations Section
          _buildInfoSection(
            icon: Icons.verified_user_outlined,
            title: 'Einwilligungen',
            child: Column(
              children: [
                AvatarAuthValues(pupil: pupil),
                const Gap(16),
                PublicMediaAuthValues(pupil: pupil),
              ],
            ),
          ),
          const Gap(8),
          // Siblings Section
          _buildInfoSection(
            icon: Icons.family_restroom_outlined,
            title: 'Geschwister',
            child:
                pupilSiblings.isNotEmpty
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pupilSiblings.length,
                      itemBuilder: (context, int index) {
                        PupilProxy sibling = pupilSiblings[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Card(
                            color: AppColors.pupilProfileCardColor,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (ctx) =>
                                            PupilProfilePage(pupil: sibling),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AvatarWithBadges(pupil: sibling, size: 60),
                                    const Gap(16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${sibling.firstName} ${sibling.lastName}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppColors.backgroundColor,
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            'Klasse ${sibling.group}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.withValues(
                                                alpha: 0.8,
                                              ),
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            'Geburtsdatum: ${sibling.birthday.formatForUser()}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.withValues(
                                                alpha: 0.7,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.interactiveColor,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey.withValues(alpha: 0.6),
                              size: 24,
                            ),
                            const Gap(12),
                            Text(
                              'Keine Geschwister erfasst',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.withValues(alpha: 0.7),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.backgroundColor, size: 25),
                const Gap(10), // Reduced from 12 to 10
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20, // Reduced from 20 to 18
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
            const Gap(12), // Reduced from 16 to 12
            child,
          ],
        ),
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
    return Card(
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.backgroundColor.withValues(alpha: 0.7),
            size: 18, // Reduced from 20 to 18
          ),
          const Gap(8), // Reduced from 12 to 8
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14, // Reduced from 16 to 14
              fontWeight: FontWeight.w500,
              color: AppColors.backgroundColor,
            ),
          ),
          const Gap(6), // Reduced from 8 to 6
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
                    fontSize: 14, // Reduced from 16 to 14
                    fontWeight: FontWeight.w600,
                    color:
                        onTap != null
                            ? AppColors
                                .interactiveColor // Keep blue for interactive elements
                            : Colors
                                .black87, // Changed from AppColors.backgroundColor to black for non-interactive
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

  // Helper method to build contact rows
  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    Widget? actionButton,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4), // Reduced from 16 to 12
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6), // Reduced from 8 to 6
              decoration: BoxDecoration(
                color: AppColors.backgroundColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6), // Reduced from 8 to 6
              ),
              child: Icon(
                icon,
                color: AppColors.backgroundColor,
                size: 18,
              ), // Reduced from 20 to 18
            ),
            const Gap(10), // Reduced from 12 to 10
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12, // Reduced from 14 to 12
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.withValues(alpha: 0.8),
                    ),
                  ),
                  const Gap(3), // Reduced from 4 to 3
                  InkWell(
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
                                ? AppColors.interactiveColor.withValues(
                                  alpha: 0.1,
                                )
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14, // Reduced from 16 to 14
                          fontWeight: FontWeight.w600,
                          color:
                              onTap != null
                                  ? AppColors
                                      .interactiveColor // Keep blue for interactive elements
                                  : Colors
                                      .black87, // Changed from AppColors.backgroundColor to black for non-interactive
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (actionButton != null) ...[const Gap(8), actionButton],
          ],
        ),
      ),
    );
  }
}
