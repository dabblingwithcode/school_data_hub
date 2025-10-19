import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/support_goals_list.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/preschool_revision_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/support_category_statuses_list.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/learning_support_plan_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/support_level_history_expansion_tile.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfileLearningSupportContentList extends WatchingWidget {
  final PupilProxy pupil;
  late final CustomExpansionTileController _plansExpansionController;

  PupilProfileLearningSupportContentList({required this.pupil, super.key}) {
    _plansExpansionController = CustomExpansionTileController();
  }

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    final isAdmin = _hubSessionManager.isAdmin;
    final kindergarden = watchPropertyValue(
      (m) => m.kindergarden,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text('Eingangsuntersuchung: ', style: TextStyle(fontSize: 15.0)),
            Gap(5),
          ],
        ),
        const Gap(10),
        if (isAdmin)
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => preschoolRevisionDialog(
                    context,
                    pupil,
                    pupil.preSchoolMedical?.preschoolMedicalStatus,
                  ),
                  child: Text(
                    PupilHelper.preschoolRevisionPredicate(
                      pupil.preSchoolMedical,
                    ),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.interactiveColor,
                    ),
                  ),
                ),
              ),
              // HubDocument files display (following competence check pattern)
              if (pupil.preSchoolMedical?.preschoolMedicalFiles != null)
                for (HubDocument file
                    in pupil.preSchoolMedical!.preschoolMedicalFiles!) ...[
                  const Gap(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          // Show document in full screen dialog
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 600,
                                  maxHeight: 800,
                                ),
                                child: DocumentImage(
                                  documentId: file.documentId,
                                  size: 400,
                                ),
                              ),
                            ),
                          );
                        },
                        onLongPress: () async {
                          bool? confirm = await confirmationDialog(
                            context: context,
                            title: 'Dokument löschen',
                            message: 'Dokument löschen?',
                          );
                          if (confirm != true) {
                            return;
                          }

                          await _removeFileFromPreSchoolMedical(file, pupil);
                        },
                        child: DocumentImage(
                          documentId: file.documentId,
                          size: 70,
                        ),
                      ),
                    ],
                  ),
                ],
              // Upload button (following competence check pattern)
              if (pupil.preSchoolMedical?.preschoolMedicalFiles == null ||
                  (pupil.preSchoolMedical?.preschoolMedicalFiles?.length ?? 0) <
                      4)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        final File? file = await createImageFile(context);
                        if (file == null) return;

                        await _uploadFileToPreSchoolMedical(file, pupil);
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
        if (isAdmin)
          const Row(
            children: [
              Text('Kindergartenbesuch: ', style: TextStyle(fontSize: 15.0)),
              Gap(5),
            ],
          ),
        const Gap(10),
        if (isAdmin)
          Row(
            children: [
              InkWell(
                //- TODO: implement long text field dialog
                onTap: () async {
                  //   final newKindergardenValue = await longTextFieldDialog(
                  //       title: 'Informationen zum Kindergartenbesuch',
                  //       labelText: 'Kindergartenbesuch',
                  //       initialValue: kindergarden ?? '',
                  //       parentContext: context);
                  //   if (newKindergardenValue == null ||
                  //       newKindergardenValue.isEmpty) {
                  //     return;
                  //   }
                  //   await _pupilManager.updateStringProperty(
                  //       pupilId: pupil.pupilId,
                  //       property: 'kindergarden',
                  //       value: newKindergardenValue);
                },
                child: Text(
                  kindergarden?.name ?? 'kein Eintrag',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ),
            ],
          ),
        const Gap(10),
        if (supportLevelHistory != null)
          supportLevelHistory.isNotEmpty
              ? SupportLevelHistoryExpansionTile(pupil: pupil)
              : Row(
                  children: [
                    const Text(
                      'Förderebene:',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const Gap(10),
                    InkWell(
                      onTap: () => supportLevelDialog(
                        context,
                        pupil,
                        pupil.latestSupportLevel?.level,
                      ),
                      child: Text(
                        latestSupportLevel == null
                            ? 'kein Eintrag'
                            : latestSupportLevel.level == 0
                            ? 'Förderebene 0'
                            : latestSupportLevel.level == 1
                            ? 'Förderebene 1'
                            : latestSupportLevel.level == 2
                            ? 'Förderebene 2'
                            : latestSupportLevel.level == 3
                            ? 'Förderebene 3'
                            : latestSupportLevel.level == 4
                            ? 'Regenbogenförderung'
                            : 'unbekannt',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.interactiveColor,
                        ),
                      ),
                    ),
                  ],
                ),
        const Gap(10),
        Row(
          children: [
            const Text('Förderschwerpunkt: ', style: TextStyle(fontSize: 15.0)),
            const Gap(5),
            pupil.specialNeeds == '' || pupil.specialNeeds == null
                ? const Text(
                    'keins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${pupil.specialNeeds}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),

        const Gap(10),
        // Learning Support Plans Section
        _buildLearningSupportPlansSection(context),
        const Gap(10),
        const Row(
          children: [
            Text(
              'Förderbereiche',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const Gap(5),
        if (pupil.learningSupportPlans?.isNotEmpty ?? true)
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
        ...pupilCategoryStatusesList(pupil, context),

        const Gap(5),
        SupportGoalsList(pupil: pupil),

        // const Gap(10),
        // ...buildPupilCategoryTree(context, pupil, null, 0, null),
        const Gap(15),
      ],
    );
  }

  /// Build the learning support plans section with active plan and expansion tile
  Widget _buildLearningSupportPlansSection(BuildContext context) {
    final schoolCalendarManager = di<SchoolCalendarManager>();
    final currentSemester = schoolCalendarManager.currentSemester.value;

    // Find the active plan (current semester) and other plans
    LearningSupportPlan? activePlan;
    List<LearningSupportPlan> otherPlans = [];

    if (pupil.learningSupportPlans != null && currentSemester != null) {
      for (final plan in pupil.learningSupportPlans!) {
        if (plan.schoolSemesterId == currentSemester.id) {
          activePlan = plan;
        } else {
          otherPlans.add(plan);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with expansion switch
        Row(
          children: [
            const Text(
              'Förderpläne',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            CustomExpansionTileSwitch(
              customExpansionTileController: _plansExpansionController,
              switchColor: AppColors.interactiveColor,
            ),
          ],
        ),
        const Gap(10),

        // Active plan card (always visible)
        if (activePlan != null)
          _buildPlanCard(context, activePlan)
        else
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Kein aktiver Förderplan verfügbar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

        // Other plans in expansion tile
        CustomExpansionTileContent(
          tileController: _plansExpansionController,
          widgetList: [
            if (otherPlans.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Keine weiteren Förderpläne verfügbar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ...otherPlans.map((plan) => _buildPlanCard(context, plan)),
            const Gap(10),
            // New Learning Support Plan Button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: AppStyles.actionButtonStyle,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => NewLearningSupportPlan(pupil: pupil),
                    ),
                  );
                },
                child: const Text(
                  "NEUER FÖRDERPLAN",
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build a card widget for displaying a learning support plan
  Widget _buildPlanCard(BuildContext context, LearningSupportPlan plan) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan ID and Support Level
            Row(
              children: [
                Expanded(
                  child: Text(
                    plan.planId,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: AppColors.backgroundColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'Förderebene ${plan.learningSupportLevelId}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ),
                const Gap(10),
                // PDF Generation Button
                InkWell(
                  onTap: () => _generatePlanPdf(context, plan),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: AppColors.accentColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.picture_as_pdf,
                      size: 20,
                      color: AppColors.accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),

            // Created info
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const Gap(4),
                Text(
                  'Erstellt von: ${plan.createdBy}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const Gap(4),
                Text(
                  '${plan.createdAt.day}.${plan.createdAt.month}.${plan.createdAt.year}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            // Optional fields if they exist
            if (plan.comment?.isNotEmpty ?? false) ...[
              const Gap(8),
              const Text(
                'Kommentar:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Gap(2),
              Text(plan.comment!, style: const TextStyle(fontSize: 12)),
            ],

            if (plan.socialPedagogue?.isNotEmpty ?? false) ...[
              const Gap(8),
              const Text(
                'Sozialpädagoge:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Gap(2),
              Text(plan.socialPedagogue!, style: const TextStyle(fontSize: 12)),
            ],

            if (plan.proffesionalsInvolved?.isNotEmpty ?? false) ...[
              const Gap(8),
              const Text(
                'Beteiligte Fachkräfte:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Gap(2),
              Text(
                plan.proffesionalsInvolved!,
                style: const TextStyle(fontSize: 12),
              ),
            ],

            if (plan.strengthsDescription?.isNotEmpty ?? false) ...[
              const Gap(8),
              const Text(
                'Stärken:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Gap(2),
              Text(
                plan.strengthsDescription!,
                style: const TextStyle(fontSize: 12),
              ),
            ],

            if (plan.problemsDescription?.isNotEmpty ?? false) ...[
              const Gap(8),
              const Text(
                'Probleme:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Gap(2),
              Text(
                plan.problemsDescription!,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Generate PDF for a learning support plan
  Future<void> _generatePlanPdf(
    BuildContext context,
    LearningSupportPlan plan,
  ) async {
    try {
      final supportCategoryManager = di<SupportCategoryManager>();
      final supportCategories = supportCategoryManager.supportCategories.value;

      final file =
          await LearningSupportPlanPdfGenerator.generateLearningSupportPlanPdf(
            plan: plan,
            pupil: pupil,
            supportCategories: supportCategories,
          );

      // Navigate to PDF viewer
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => LearningSupportPlanPdfViewPage(pdfFile: file),
          ),
        );
      }
    } catch (e) {
      di<NotificationService>().showSnackBar(
        NotificationType.error,
        'Fehler beim Erstellen des PDFs: $e',
      );
    }
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
      final pupilManager = di<PupilManager>();

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
        file,
        ServerStorageFolder.documents,
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
      final pupilManager = di<PupilManager>();

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
