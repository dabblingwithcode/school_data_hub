import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class MultiPupilCompetenceCheckCard extends WatchingWidget {
  final String groupId;
  final int competenceId;
  final PupilProxy passedPupil;
  const MultiPupilCompetenceCheckCard({
    required this.passedPupil,
    required this.groupId,
    required this.competenceId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pupil = watch(passedPupil);
    CompetenceCheck? competenceCheck =
        CompetenceHelper.getGroupCompetenceCheckFromPupil(
          pupil: pupil,
          groupId: groupId,
        );

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
              AvatarWithBadges(pupil: pupil, size: 70),
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: pupil),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    pupil.firstName,
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
                                    pupil.lastName,
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
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
                                        pupilId: pupil.internalId,
                                        competenceId: competenceId,
                                        competenceComment: '',
                                        groupId: groupId,
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
                                  child: DocumentImage(
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
                                  // TODO: Uncomment this when postCompetenceCheckWithFile is implemented
                                  // await di<CompetenceManager>()
                                  //     .postCompetenceCheckWithFile(
                                  //         pupilId: pupil.internalId,
                                  //         competenceId: competenceId,
                                  //         competenceComment: '',
                                  //         groupId: groupId,
                                  //         competenceStatus: 0,
                                  //         file: file);
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
                    const Gap(10),
                  ],
                ),
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
                      final String? comment = await longTextFieldDialog(
                        parentContext: context,
                        title: 'Kommentar',
                        labelText: 'Kommentar eingeben',
                        initialValue: competenceCheck.comment,
                      );
                      if (comment != null) {
                        await di<CompetenceManager>().updateCompetenceCheck(
                          competenceCheckId: competenceCheck.checkId,
                          competenceComment: (value: comment),
                        );
                      }
                    }
                  },
                  child: const Text(
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
                        final String? comment = await longTextFieldDialog(
                          parentContext: context,
                          title: 'Kommentar',
                          labelText: 'Kommentar eingeben',
                          initialValue: competenceCheck.comment,
                        );
                        if (comment != null) {
                          await di<CompetenceManager>().updateCompetenceCheck(
                            competenceCheckId: competenceCheck.checkId,
                            competenceComment: (value: comment),
                          );
                        }
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
      ),
    );
  }
}
