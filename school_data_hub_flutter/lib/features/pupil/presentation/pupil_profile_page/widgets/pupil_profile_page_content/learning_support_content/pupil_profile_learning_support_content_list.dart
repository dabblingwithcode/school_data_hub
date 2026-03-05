import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/set_bulk_support_categoies_status_page/set_bulk_support_categoies_status_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/kindergarden_info_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/preschool_revision_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/support_category_statuses_list.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/support_level_history_expansion_tile.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/widgets/learning_support_plans_section.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class PupilProfileLearningSupportContentList extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfileLearningSupportContentList({
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool hasActivePlan() {
      if (pupil.learningSupportPlans != null &&
          pupil.learningSupportPlans!.any(
            (plan) =>
                plan.schoolSemesterId ==
                di<SchoolCalendarManager>().currentSemester.value?.id,
          ) &&
          di<SchoolCalendarManager>().currentSemester.value != null) {
        return true;
      }
      return false;
    }

    final plansExpansionController = createOnce(
      () => CustomExpansionTileController(),
    );
    final hubSessionManager = di<HubSessionManager>();
    final isAdmin = hubSessionManager.isAdmin;

    final kindergardenInfo = watchPropertyValue(
      (m) => m.kindergardenInfo,
      target: pupil,
    );
    final latestSupportLevel = watchPropertyValue(
      (m) => m.latestSupportLevel,
      target: pupil,
    );
    final supportLevelHistory = watchPropertyValue(
      (m) => m.supportLevelHistory,
      target: pupil,
    );
    watchPropertyValue((m) => m.learningSupportPlans, target: pupil);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PupilProfileContentRow(
          icon: Icons.medical_services_outlined,
          label: 'Eingangsuntersuchung',
          valueWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => preschoolRevisionDialog(
                  context,
                  pupil,
                  pupil.preSchoolMedical?.preschoolMedicalStatus,
                ),
                borderRadius: BorderRadius.circular(8),
                child: Text(
                  PupilProxyHelper.preschoolRevisionPredicate(
                    pupil.preSchoolMedical,
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (pupil.preSchoolMedical?.preschoolMedicalFiles != null)
                    for (HubDocument file
                        in pupil.preSchoolMedical!.preschoolMedicalFiles!)
                      InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 600,
                                  maxHeight: 800,
                                ),
                                child: EncryptedDocumentImage(
                                  documentId: file.documentId,
                                  size: 400,
                                ),
                              ),
                            ),
                          );
                        },
                        onLongPress: () async {
                          if (!isAdmin) {
                            di<NotificationService>().showSnackBar(
                              NotificationType.error,
                              'Nur Admins können Dokumente ansehen',
                            );
                            return;
                          }
                          bool? confirm = await confirmationDialog(
                            context: context,
                            title: 'Dokument löschen',
                            message: 'Dokument löschen?',
                          );
                          if (confirm != true) return;
                          await _removeFileFromPreSchoolMedical(file, pupil);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: EncryptedDocumentImage(
                            documentId: file.documentId,
                            size: 70,
                          ),
                        ),
                      ),
                  if (pupil.preSchoolMedical?.preschoolMedicalFiles == null ||
                      (pupil.preSchoolMedical?.preschoolMedicalFiles?.length ??
                              0) <
                          4)
                    InkWell(
                      onTap: () async {
                        if (!isAdmin) {
                          di<NotificationService>().showSnackBar(
                            NotificationType.error,
                            'Nur Admins können Dokumente hochladen',
                          );
                          return;
                        }
                        final File? file = await createAndCropImageFile(
                          context,
                        );
                        if (file == null) return;
                        final encryptedFile = await customEncrypter.encryptFile(
                          file,
                        );
                        await _uploadFileToPreSchoolMedical(
                          encryptedFile,
                          pupil,
                        );
                      },
                      child: SizedBox(
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('assets/document_camera.png'),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (isAdmin) ...[
          const Gap(8),
          PupilProfileContentRow(
            icon: Icons.child_care,
            label: 'Kindergartenbesuch',
            onTap: () =>
                kindergardenInfoDialog(context, pupil, kindergardenInfo),
            valueWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kindergardenInfo != null
                      ? '${kindergardenInfo.attendedMonths} Monate'
                      : 'kein Eintrag',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.interactiveColor,
                  ),
                ),
                if (kindergardenInfo != null &&
                    kindergardenInfo.comments.isNotEmpty) ...[
                  const Gap(4),
                  Text(
                    kindergardenInfo.comments,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.interactiveColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
        const Gap(8),
        if (supportLevelHistory != null)
          supportLevelHistory.isNotEmpty
              ? SupportLevelHistoryExpansionTile(pupil: pupil)
              : PupilProfileContentRow(
                  icon: Icons.layers_outlined,
                  label: 'Förderebene',
                  onTap: () => supportLevelDialog(
                    context,
                    pupil,
                    pupil.latestSupportLevel?.level,
                  ),
                  value: _supportLevelText(latestSupportLevel),
                ),
        const Gap(8),
        PupilProfileContentRow(
          icon: Icons.accessibility_new,
          label: 'Förderschwerpunkt(e)',
          value: pupil.specialNeeds == '' || pupil.specialNeeds == null
              ? 'keins'
              : pupil.specialNeeds!,
        ),
        const Gap(10),
        // Learning Support Plans Section
        LearningSupportPlansSection(
          pupil: pupil,
          plansExpansionController: plansExpansionController,
        ),
        const Gap(10),
        if (hasActivePlan()) ...[
          ...[
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        SetBulkSupportCategoriesStatusPage(pupil: pupil),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.category_outlined,
                      color: AppColors.backgroundColor,
                      size: 22,
                    ),
                    const Gap(8),
                    Text(
                      'Förderbereiche',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.backgroundColor.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],

        const Gap(5),
        if (hasActivePlan())
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: AppStyles.actionButtonStyle,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => NewSupportCategoryStatus(
                      appBarTitle: 'Neuer Förderbereich',
                      pupilId: pupil.pupilId,
                      goalCategoryId: 0,
                      elementType: 'status',
                    ),
                  ),
                );
              },
              child: const Text(
                "NEUER FÖRDERBEREICH",
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ),
        const Gap(5),
        SupportCategoryStatusesList(pupil: pupil),

        const Gap(5),
      ],
    );
  }

  String _supportLevelText(SupportLevel? level) {
    if (level == null) return 'kein Eintrag';
    return switch (level.level) {
      0 => 'Förderebene 0',
      1 => 'Förderebene 1',
      2 => 'Förderebene 2',
      3 => 'Förderebene 3',
      4 => 'Regenbogenförderung',
      _ => 'unbekannt',
    };
  }

  /// Upload a file to PreSchoolMedical record
  Future<void> _uploadFileToPreSchoolMedical(
    File file,
    PupilProxy pupil,
  ) async {
    try {
      final client = di<Client>();
      final notificationService = di<NotificationService>();
      final hubSessionManager = di<HubSessionManager>();
      final pupilManager = di<PupilProxyManager>();

      // Ensure PreSchoolMedical record exists
      if (pupil.preSchoolMedical == null) {
        // Create PreSchoolMedical record first
        await ClientHelper.apiCall(
          call: () => client.preSchoolMedical.createPreSchoolMedical(
            pupil.pupilId,
            PreSchoolMedicalStatus.notAvailable,
            hubSessionManager.userName!,
          ),
          errorMessage: 'Fehler beim Erstellen der Eingangsuntersuchung',
        );

        // Refresh pupil data to get the newly created PreSchoolMedical record
        await pupilManager.updatePupilData(pupil.pupilId);
      }

      // Get the updated pupil data (in case we just created a PreSchoolMedical record)
      final updatedPupil = pupilManager.getPupilByPupilId(pupil.pupilId);
      if (updatedPupil == null) {
        notificationService.showSnackBar(
          NotificationType.error,
          'Schülerdaten konnten nicht geladen werden',
        );
        return;
      }

      // Check if PreSchoolMedical record exists after refresh
      if (updatedPupil.preSchoolMedical == null) {
        notificationService.showSnackBar(
          NotificationType.error,
          'Eingangsuntersuchung konnte nicht erstellt werden',
        );
        return;
      }

      // Upload file to server storage
      final fileResponse = await ClientFileUpload.uploadFile(
        file: file,
        storageId: StorageId.private,
        folder: ServerStorageFolder.documents,
      );

      if (fileResponse.success == false) {
        notificationService.showSnackBar(
          NotificationType.error,
          'Die Datei konnte nicht hochgeladen werden!',
        );
        return;
      }

      // Add file to PreSchoolMedical record
      final updatedPreSchoolMedical = await ClientHelper.apiCall(
        call: () => client.preSchoolMedical.addFileToPreSchoolMedical(
          updatedPupil.preSchoolMedical!.id!,
          fileResponse.path!,
          hubSessionManager.userName!,
        ),
        errorMessage:
            'Fehler beim Hinzufügen der Datei zur Eingangsuntersuchung',
      );

      if (updatedPreSchoolMedical != null) {
        // Refresh pupil data from server to get the updated PreSchoolMedical record
        await pupilManager.updatePupilData(pupil.pupilId);

        notificationService.showSnackBar(
          NotificationType.success,
          'Datei zur Eingangsuntersuchung hinzugefügt',
        );
      }
    } catch (e) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Fehler beim Hochladen der Datei: $e',
      );
    }
  }

  /// Remove a file from PreSchoolMedical record
  Future<void> _removeFileFromPreSchoolMedical(
    HubDocument file,
    PupilProxy pupil,
  ) async {
    try {
      final client = di<Client>();
      final notificationService = di<NotificationService>();
      final pupilManager = di<PupilProxyManager>();

      if (pupil.preSchoolMedical == null) {
        notificationService.showSnackBar(
          NotificationType.error,
          'Keine Eingangsuntersuchung gefunden',
        );
        return;
      }

      // Remove file from PreSchoolMedical record
      final success = await ClientHelper.apiCall(
        call: () => client.preSchoolMedical.removeFileFromPreSchoolMedical(
          pupil.preSchoolMedical!.id!,
          file.documentId,
        ),
        errorMessage:
            'Fehler beim Entfernen der Datei von der Eingangsuntersuchung',
      );

      if (success == true) {
        // Refresh pupil data from server to get the updated PreSchoolMedical record
        await pupilManager.updatePupilData(pupil.pupilId);

        notificationService.showSnackBar(
          NotificationType.success,
          'Datei von der Eingangsuntersuchung entfernt',
        );
      }
    } catch (e) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen der Datei: $e',
      );
    }
  }
}
