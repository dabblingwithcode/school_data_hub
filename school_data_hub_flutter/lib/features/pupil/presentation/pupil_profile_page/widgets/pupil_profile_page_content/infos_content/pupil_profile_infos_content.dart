import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/widgets/dialogues/logout_devices_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_page/new_matrix_user_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/widgets/avatar_auth_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/widgets/pupil_media_auth_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfileInfosContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileInfosContent({required this.pupil, super.key});
  TextEditingController createController() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();

    final hubSessionManager = di<HubSessionManager>();
    final pupilSiblings = pupilManager.getSiblings(pupil);
    watch(pupil);
    return Container(
      decoration: BoxDecoration(color: AppColors.pupilProfileBackgroundColor),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section

            // Special Information Section
            // Special Information Section
            PupilProfileContentSection(
              icon: Icons.priority_high_rounded,
              title: 'Besondere Infos',
              child: InkWell(
                onTap: () async {
                  final result = await longTextFieldDialog(
                    title: 'Besondere Infos',
                    labelText: 'Besondere Infos',
                    initialValue: pupil.specialInformation ?? '',
                    parentContext: context,
                  );
                  if (result == null ||
                      result.value == pupil.specialInformation) {
                    return;
                  }
                  await PupilMutator().updateStringProperty(
                    pupilId: pupil.pupilId,
                    property: 'specialInformation',
                    propertyValue: (value: result.value),
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
                    propertyValue: (value: null),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: pupil.specialInformation != null
                        ? AppColors.backgroundColor.withValues(alpha: 0.05)
                        : AppColors.interactiveColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: pupil.specialInformation != null
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
                      fontWeight: pupil.specialInformation != null
                          ? FontWeight.w500
                          : FontWeight.normal,
                      color: pupil.specialInformation != null
                          ? AppColors.backgroundColor
                          : AppColors.interactiveColor,
                      fontStyle: pupil.specialInformation == null
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(8),
            // Basic Information Section
            // Basic Information Section
            PupilProfileContentSection(
              icon: Icons.person_outline,
              title: 'Grunddaten',
              child: Column(
                children: [
                  PupilProfileContentRow(
                    icon: Icons.wc,
                    label: 'Geschlecht',
                    value: pupil.gender == 'm' ? 'männlich' : 'weiblich',
                  ),
                  const Gap(8),
                  PupilProfileContentRow(
                    icon: Icons.cake_outlined,
                    label: 'Geburtsdatum',
                    value: pupil.birthday.formatDateForUser(),
                  ),
                  const Gap(8),
                  PupilProfileContentRow(
                    icon: Icons.school_outlined,
                    label: 'Aufnahmedatum',
                    value: pupil.pupilSince.formatDateForUser(),
                  ),
                ],
              ),
            ),
            const Gap(8),
            // Contact Information Section
            // Contact Information Section
            PupilProfileContentSection(
              icon: Icons.contact_phone_outlined,
              title: 'Kontaktinformationen',
              child: Column(
                children: [
                  PupilProfileContentRow(
                    icon: Icons.person_outline,
                    label: 'Schüler/in Kontakt',
                    value: pupil.contact?.isNotEmpty == true
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
                        propertyValue: (value: contact),
                      );
                    },
                    actionButton:
                        pupil.contact == null || pupil.contact!.isEmpty
                        ? IconButton(
                            onPressed: () async {
                              if (_isMatrixAuthorized() == false) {
                                di<NotificationService>().showInformationDialog(
                                  'Keine Berechtigung. Admin-Rechte erforderlich.',
                                );
                                return;
                              }
                              final confirm = await confirmationDialog(
                                context: context,
                                title: 'Matrix-Admindaten erstellen',
                                message:
                                    'Möchten Sie die Matrix-Admindaten wirklich erstellen?',
                              );
                              if (confirm != true) return;
                              if (context.mounted) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => NewMatrixUserPage(
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
                              }
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 24,
                              color: AppColors.interactiveColor,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              if (_isMatrixAuthorized() == false) {
                                di<NotificationService>().showInformationDialog(
                                  'Keine Berechtigung. Admin-Rechte erforderlich.',
                                );
                                return;
                              }

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
                                if (!di.isRegistered<MatrixPolicyManager>()) {
                                  await InitManager.registerMatrixManagers();
                                }
                                final file = await di<MatrixPolicyManager>()
                                    .users
                                    .resetPasswordAndPrintCredentialsFile(
                                      user: MatrixUserHelper.usersFromUserIds([
                                        pupil.contact!,
                                      ]).first,
                                      logoutDevices: logOutDevices,
                                      isStaff: false,
                                    );
                                if (file != null && context.mounted) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PdfViewerPage(pdfFile: file),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: Icon(
                              Icons.qr_code_2_rounded,
                              size: 24,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                  ),
                  const Gap(10),
                  PupilProfileContentRow(
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
                        tutorInfo: pupil.tutorInfo != null
                            ? pupil.tutorInfo!.copyWith(
                                parentsContact: parentsContact,
                              )
                            : TutorInfo(
                                parentsContact: parentsContact,
                                createdBy: hubSessionManager.userName!,
                              ),
                      );
                    },
                    actionButton: pupil.tutorInfo?.parentsContact == null
                        ? IconButton(
                            onPressed: () {
                              String? pupilSiblingsGroups;
                              if (pupil.family != null) {
                                pupilSiblingsGroups = [
                                  ...pupilManager.getSiblings(pupil),
                                  pupil,
                                ].map((e) => e.group).toList().join();
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => NewMatrixUserPage(
                                    pupil: pupil,
                                    matrixId:
                                        MatrixPolicyHelper.generateMatrixId(
                                          isParent: true,
                                        ),
                                    displayName: pupilSiblingsGroups != null
                                        ? 'Fa. ${pupil.lastName} (E) $pupilSiblingsGroups'
                                        : '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (E) ${pupil.group}',
                                    isParent: true,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 24,
                              color: AppColors.interactiveColor,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              if (_isMatrixAuthorized() == false) return;
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
                                if (!di.isRegistered<MatrixPolicyManager>()) {
                                  await InitManager.registerMatrixManagers();
                                }
                                final file = await di<MatrixPolicyManager>()
                                    .users
                                    .resetPasswordAndPrintCredentialsFile(
                                      user: MatrixUserHelper.usersFromUserIds([
                                        pupil.tutorInfo!.parentsContact!,
                                      ]).first,
                                      logoutDevices: logOutDevices,
                                      isStaff: false,
                                    );
                                if (file != null && context.mounted) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PdfViewerPage(pdfFile: file),
                                    ),
                                  );
                                }
                              }
                            },
                            icon: Icon(
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
            // Authorizations Section
            PupilProfileContentSection(
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
            // Siblings Section
            PupilProfileContentSection(
              icon: Icons.family_restroom_outlined,
              title: 'Geschwister',
              child: pupilSiblings.isNotEmpty
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
                                    builder: (ctx) =>
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
                                            style: TextStyle(
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
                                            'Geburtsdatum: ${sibling.birthday.formatDateForUser()}',
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
            // Extra spacing at the bottom to avoid nav overlap
          ],
        ),
      ),
    );
  }
}

bool _isMatrixAuthorized() {
  if (!di.isRegistered<MatrixPolicyManager>() ||
      !di<HubSessionManager>().isAdmin) {
    di<NotificationService>().showInformationDialog(
      !di<HubSessionManager>().isAdmin
          ? 'Keine Berechtigung. Admin-Rechte erforderlich.'
          : 'Es sind keine Matrix-Admindaten hinterlegt.',
    );
    return false;
  }
  return true;
}
