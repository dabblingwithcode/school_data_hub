import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/custom_checkbox_either_or.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/hub_document/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorization_pupils_screen/authorization_pupils_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class PupilProfileAuthorizationCard extends WatchingWidget {
  final Authorization authorization;
  final PupilAuthorization pupilAuthorization;
  final PupilProxy pupil;
  const PupilProfileAuthorizationCard({
    required this.authorization,
    required this.pupilAuthorization,
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authorizationManager = di<AuthorizationManager>();
    final thisAuthorization = watchValue(
      (AuthorizationManager x) => x.authorizations,
    ).firstWhere((authorization) => authorization.id == this.authorization.id);

    final PupilAuthorization pupilAuthorization = thisAuthorization
        .authorizedPupils!
        .firstWhere((element) => element.pupilId == pupil.pupilId);
    return CardBox(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (ctx) =>
                                      AuthorizationPupilsScreen(authorization),
                                ),
                              );
                            },
                            onLongPress: () async {
                              final bool?
                              confirmation = await confirmationDialog(
                                context: context,
                                title: 'Kind aus der Liste löschen',
                                message:
                                    'Die Einwilligung von ${pupil.firstName} löschen?',
                              );
                              if (confirmation == true) {
                                authorizationManager.updateAuthorization(
                                  authId: authorization.id!,
                                  membersToUpdate: (
                                    operation: MemberOperation.remove,
                                    pupilIds: [pupil.pupilId],
                                  ),
                                );
                              }
                              return;
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      authorization.name,
                                      style: context.typography.title.bold.withColor(
                                        Style.of(context).colors.interactive,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  authorization.description,
                                  style: context.typography.body,
                                ),
                              ),
                              const Gap(5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final File? file = await createAndCropImageFile(
                              context,
                            );
                            if (file == null) return;
                            await authorizationManager
                                .addFileToPupilAuthorization(
                                  file,
                                  pupilAuthorization.id!,
                                );
                          },
                          onLongPress: () async {
                            if (pupilAuthorization.fileId == null) return;
                            final bool? result = await confirmationDialog(
                              context: context,
                              title: 'Dokument löschen',
                              message:
                                  'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?',
                            );
                            if (result != true) return;
                            await authorizationManager
                                .removeFileFromPupilAuthorization(
                                  pupilAuthorization.id!,
                                  pupilAuthorization.file!.documentId,
                                );
                          },
                          child: pupilAuthorization.fileId != null
                              ? EncryptedDocumentImage(
                                  documentId:
                                      pupilAuthorization.file!.documentId,
                                  size: 70,
                                )
                              : SizedBox(
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
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Kommentar',
                      style: context.typography.body.bold,
                    ),
                    const Spacer(),
                    //- TO-DO BACKEND: model needs a modifedBy field
                    if (pupilAuthorization.createdBy != null)
                      Text(
                        pupilAuthorization.createdBy!,
                        style: context.typography.title.bold,
                      ),

                    const Gap(15),
                    Icon(Icons.close, color: Style.of(context).colors.error),
                    CustomCheckboxEitherOr(
                      representedBoolValue: false, // Red/negative checkbox
                      currentStatus: pupilAuthorization.status,
                      onStatusChanged: (newStatus) async {
                        await authorizationManager.updatePupilAuthorization(
                          pupilId: pupil.pupilId,
                          authorizationId: authorization.id!,
                          status: (value: newStatus),
                          comment: null,
                        );
                      },
                    ),
                    const Gap(10),
                    Icon(Icons.done, color: Style.of(context).colors.success),
                    CustomCheckboxEitherOr(
                      representedBoolValue: true, // Green/positive checkbox
                      currentStatus: pupilAuthorization.status,
                      onStatusChanged: (newStatus) async {
                        await authorizationManager.updatePupilAuthorization(
                          pupilId: pupil.pupilId,
                          authorizationId: authorization.id!,
                          status: (value: newStatus),
                        );
                      },
                    ),
                  ],
                ),
                Gap(Style.spacing.xs),
                GestureDetector(
                  onTap: () async {
                    final result = await longTextFieldDialog(
                      title: 'Kommentar',
                      labelText: 'Kommentar eintragen',
                      initialValue: pupilAuthorization.comment ?? '',
                      parentContext: context,
                    );
                    if (result == null ||
                        result.value == pupilAuthorization.comment) {
                      return;
                    }
                    await di<AuthorizationManager>().updatePupilAuthorization(
                      pupilId: pupil.pupilId,
                      authorizationId: authorization.id!,
                      comment: result.value,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
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
                                  (pupilAuthorization.comment == null ||
                                      pupilAuthorization.comment!.isEmpty)
                                  ? 'Kein Kommentar'
                                  : pupilAuthorization.comment!,
                            ),
                          ],
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
                const Gap(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
