import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';

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
    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
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
                    Gap(Style.spacing.xs),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
                              onTap: () {
                                di<BottomNavManager>().setPupilProfileNavPage(
                                  9,
                                );
                                context.push(RoutePaths.pupilProfilePath(passedPupil.internalId), extra: passedPupil);
                              },
                              child: _MultiPupilCompetenceNameRow(
                                pupil: passedPupil,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(Style.spacing.xs),
                    _MultiPupilCompetenceCheckContent(
                      pupil: passedPupil,
                      groupId: groupId,
                      groupCheckName: groupCheckName,
                      competenceId: competenceId,
                    ),
                  ],
                ),
              ),
              Gap(Style.spacing.xs),
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
    final style = Style.of(context);
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title.withColor(style.colors.foreground),
        ),
        Gap(Style.spacing.xs),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.title.w400.withColor(
            style.colors.foreground,
          ),
        ),
        Gap(Style.spacing.xs),
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
            Gap(Style.spacing.xs),
            competenceCheck != null
                ? GrowthDropdown(
                    dropdownValue: competenceCheck.score,
                    onChangedFunction: (int value) async {
                      if (value == competenceCheck.score) {
                        return;
                      }
                      await di<CompetenceManager>().updateCompetenceCheck(
                        competenceCheckId: competenceCheck.checkId,
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
                      await di<CompetenceManager>().postCompetenceCheck(
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
                  GestureDetector(
                    onTap: () async {
                      final File? file = await createAndCropImageFile(context);
                      if (file == null) return;
                      await di<CompetenceManager>().addFileToCompetenceCheck(
                        competenceCheckId: competenceCheck.checkId,
                        file: file,
                      );
                    },
                    onLongPress: () async {},
                    child: SizedBox(
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Style.radii.small),
                        child: Image.asset('assets/document_camera.png'),
                      ),
                    ),
                  ),
                ],
              ),
            if (competenceCheck != null &&
                competenceCheck.documents!.isNotEmpty)
              for (HubDocument file in competenceCheck.documents!) ...<Widget>[
                Gap(Style.spacing.md),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {},
                      onLongPress: () async {
                        bool? confirm = await confirmationDialog(
                          context: context,
                          title: 'Dokument loeschen',
                          message: 'Dokument loeschen?',
                        );
                        if (confirm != true) {
                          return;
                        }
                        await di<CompetenceManager>()
                            .removeFileFromCompetenceCheck(
                              competenceCheckId: competenceCheck.checkId,
                              documentId: file.documentId,
                            );
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
                  GestureDetector(
                    onTap: () async {
                      final File? file = await createAndCropImageFile(context);

                      if (file == null) return;
                      await di<CompetenceManager>().postCompetenceCheckWithFile(
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
                        borderRadius: BorderRadius.circular(Style.radii.small),
                        child: Image.asset('assets/document_camera.png'),
                      ),
                    ),
                  ),
                ],
              ),
            Gap(Style.spacing.xs),
          ],
        ),
        if (competenceCheck != null) ...[
          GestureDetector(
            onTap: () async {
              if (!SessionHelper.isAuthorized(competenceCheck.createdBy)) {
                return;
              }
              final result = await longTextFieldDialog(
                parentContext: context,
                title: 'Kommentar',
                labelText: 'Kommentar eingeben',
                initialValue: competenceCheck.comment,
              );
              if (result == null || result.value == competenceCheck.comment) {
                return;
              }
              await di<CompetenceManager>().updateCompetenceCheck(
                competenceCheckId: competenceCheck.checkId,
                competenceComment: (value: result.value),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: Style.spacing.md),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Kommentar: ',
                        style: context.typography.subtitle.bold,
                      ),
                      TextSpan(
                        text:
                            (competenceCheck.comment == null ||
                                competenceCheck.comment!.isEmpty)
                            ? 'Kein Kommentar'
                            : competenceCheck.comment!,
                      ),
                    ],
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ),
          Gap(Style.spacing.md),
        ],
      ],
    );
  }
}
