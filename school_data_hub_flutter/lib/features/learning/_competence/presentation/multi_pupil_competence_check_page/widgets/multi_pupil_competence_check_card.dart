import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';

class MultiPupilCompetenceCheckCard extends WatchingWidget {
  final String groupId;
  final String? groupCheckName;
  final int competenceId;
  final PupilProxy passedPupil;
  const MultiPupilCompetenceCheckCard({
    required this.passedPupil,
    required this.groupId,
    this.groupCheckName,
    required this.competenceId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: passedPupil, size: 70),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(5),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                di<BottomNavManager>().setPupilProfileNavPage(
                                  9,
                                );
                                Navigator.of(context).push<void>(
                                  MaterialPageRoute<void>(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: passedPupil),
                                  ),
                                );
                              },
                              child: _MultiPupilCompetenceNameRow(
                                pupil: passedPupil,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    _MultiPupilCompetenceCheckContent(
                      pupil: passedPupil,
                      groupId: groupId,
                      groupCheckName: groupCheckName,
                      competenceId: competenceId,
                    ),
                  ],
                ),
              ),
              const Gap(5),
            ],
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _MultiPupilCompetenceNameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _MultiPupilCompetenceNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName =
        watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName =
        watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Gap(5),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        const Gap(5),
      ],
    );
  }
}

/// Rebuilds only when [pupil.competenceChecks] (or related group check data) changes.
class _MultiPupilCompetenceCheckContent extends WatchingWidget {
  final PupilProxy pupil;
  final String groupId;
  final String? groupCheckName;
  final int competenceId;

  const _MultiPupilCompetenceCheckContent({
    required this.pupil,
    required this.groupId,
    required this.groupCheckName,
    required this.competenceId,
  });

  @override
  Widget build(BuildContext context) {
    watchPropertyValue((m) => m.competenceChecks, target: pupil);
    CompetenceCheck? competenceCheck =
        CompetenceHelper.getGroupCompetenceCheckFromPupil(
          pupil: pupil,
          groupId: groupId,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(5),
            competenceCheck != null
                            ? GrowthDropdown(
                                dropdownValue: competenceCheck.score,
                                onChangedFunction: (int value) async {
                                  if (value == competenceCheck.score) {
                                    return;
                                  }
                                  await di<CompetenceManager>()
                                      .updateCompetenceCheck(
                                        competenceCheckId:
                                            competenceCheck.checkId,
                                        score: (value: value),
                                      );
                                },
                              )
                            : GrowthDropdown(
                                dropdownValue: 0,
                                onChangedFunction: (int? value) async {
                                  if (value == 0) {
                                    return;
                                  }
                                  await di<CompetenceManager>()
                                      .postCompetenceCheck(
                                        pupilId: pupil.pupilId,
                                        competenceId: competenceId,
                                        competenceComment: '',
                                        groupId: groupId,
                                        groupCheckName: groupCheckName,
                                        score: value!,
                                      );
                                },
                              ),
                        const Spacer(),
                        //- Take picture button only visible if there are less than 4 pictures
                        if (competenceCheck != null &&
                            competenceCheck.documents!.length < 4)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final File? file =
                                      await createAndCropImageFile(context);
                                  if (file == null) return;
                                  await di<CompetenceManager>()
                                      .addFileToCompetenceCheck(
                                        competenceCheckId:
                                            competenceCheck.checkId,
                                        file: file,
                                      );
                                },
                                onLongPress: () async {
                                  // bool? confirm = await confirmationDialog(
                                  //     context: context,
                                  //     title: 'Dokument löschen',
                                  //     message: 'Dokument löschen?');
                                  // if (confirm != true) {
                                  //   return;
                                  // }
                                  // await di<CompetenceManager>()
                                  //     .deleteCompetenceCheckFile(
                                  //         competenceCheck.checkId,
                                  //         competenceCheck.competenceCheckFiles!
                                  //             .first.fileId!,
                                  //         true);
                                },
                                child: SizedBox(
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/document_camera.png',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (competenceCheck != null &&
                            competenceCheck.documents!.isNotEmpty)
                          for (HubDocument file
                              in competenceCheck.documents!) ...<Widget>[
                            const Gap(10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // final File? file = await uploadImage(context);
                                    // if (file == null) return;
                                    // await di<CompetenceManager>()
                                    //     .patchCompetenceCheckWithFile(
                                    //         file, competenceCheck.checkId, true);
                                    // di<NotificationService>().showSnackBar(
                                    //     NotificationType.success,
                                    //     'Vorfall geändert!');
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
                                    // TODO: Uncomment this when deleteCompetenceCheckFile is implemented
                                    // await di<CompetenceManager>()
                                    //     .deleteCompetenceCheckFile(
                                    //         competenceCheckId:
                                    //             competenceCheck.checkId,
                                    //         fileId: file.fileId);
                                  },
                                  child: EncryptedDocumentImage(
                                    documentId: file.documentId,
                                    size: 70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        if (competenceCheck == null)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final File? file =
                                      await createAndCropImageFile(context);

                                  if (file == null) return;
                                  await di<CompetenceManager>()
                                      .postCompetenceCheckWithFile(
                                        pupilId: pupil.pupilId,
                                        competenceId: competenceId,
                                        competenceComment: '',
                                        groupId: groupId,
                                        groupCheckName: groupCheckName,
                                        score: 0,
                                        file: file,
                                      );
                                },
                                child: SizedBox(
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/document_camera.png',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const Gap(5),
                      ],
                    ),
        if (competenceCheck != null) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              InkWell(
                onTap: () async {
                  if (SessionHelper.isAuthorized(competenceCheck.createdBy)) {
                    final result = await longTextFieldDialog(
                      parentContext: context,
                      title: 'Kommentar',
                      labelText: 'Kommentar eingeben',
                      initialValue: competenceCheck.comment,
                    );
                    if (result == null ||
                        result.value == competenceCheck.comment) {
                      return;
                    }
                    await di<CompetenceManager>().updateCompetenceCheck(
                      competenceCheckId: competenceCheck.checkId,
                      competenceComment: (value: result.value),
                    );
                  }
                },
                child: Text(
                  'Kommentar:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ),
              const Gap(5),
              Flexible(
                child: InkWell(
                  onTap: () async {
                    if (SessionHelper.isAuthorized(
                      competenceCheck.createdBy,
                    )) {
                      final result = await longTextFieldDialog(
                        parentContext: context,
                        title: 'Kommentar',
                        labelText: 'Kommentar eingeben',
                        initialValue: competenceCheck.comment,
                      );
                      if (result == null ||
                          result.value == competenceCheck.comment) {
                        return;
                      }
                      await di<CompetenceManager>().updateCompetenceCheck(
                        competenceCheckId: competenceCheck.checkId,
                        competenceComment: (value: result.value),
                      );
                    }
                  },
                  child: Text(
                    (competenceCheck.comment == null ||
                            competenceCheck.comment!.isEmpty)
                        ? 'Kein Kommentar'
                        : competenceCheck.comment!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
      ],
    );
  }
}
