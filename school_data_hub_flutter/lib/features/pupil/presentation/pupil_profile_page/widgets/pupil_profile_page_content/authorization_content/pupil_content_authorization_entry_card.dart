import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_checkbox_either_or.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/encrypted_document_image.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorization_pupils_page/authorization_pupils_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class PupilContentAuthorizationEntryCard extends WatchingWidget {
  final Authorization authorization;
  final PupilAuthorization pupilAuthorization;
  final PupilProxy pupil;
  const PupilContentAuthorizationEntryCard({
    required this.authorization,
    required this.pupilAuthorization,
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _authorizationManager = di<AuthorizationManager>();
    final thisAuthorization = watchValue(
      (AuthorizationManager x) => x.authorizations,
    ).firstWhere((authorization) => authorization.id == this.authorization.id);

    final PupilAuthorization pupilAuthorization = thisAuthorization
        .authorizedPupils!
        .firstWhere((element) => element.pupilId == pupil.pupilId);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        AuthorizationPupilsPage(authorization),
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
                                  _authorizationManager.updateAuthorization(
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
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.interactiveColor,
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
                                    style: const TextStyle(fontSize: 15),
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
                          InkWell(
                            onTap: () async {
                              final File? file = await createAndCropImageFile(
                                context,
                              );
                              if (file == null) return;
                              await _authorizationManager
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
                              await _authorizationManager
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
                      const Text(
                        'Kommentar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      //- TO-DO BACKEND: model needs a modifedBy field
                      if (pupilAuthorization.createdBy != null)
                        Text(
                          pupilAuthorization.createdBy!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      const Gap(15),
                      const Icon(Icons.close, color: Colors.red),
                      CustomCheckboxEitherOr(
                        representedBoolValue: false, // Red/negative checkbox
                        currentStatus: pupilAuthorization.status,
                        onStatusChanged: (newStatus) async {
                          await _authorizationManager.updatePupilAuthorization(
                            pupilId: pupil.pupilId,
                            authorizationId: authorization.id!,
                            status: (value: newStatus),
                            comment: null,
                          );
                        },
                      ),
                      const Gap(10),
                      const Icon(Icons.done, color: Colors.green),
                      CustomCheckboxEitherOr(
                        representedBoolValue: true, // Green/positive checkbox
                        currentStatus: pupilAuthorization.status,
                        onStatusChanged: (newStatus) async {
                          await _authorizationManager.updatePupilAuthorization(
                            pupilId: pupil.pupilId,
                            authorizationId: authorization.id!,
                            status: (value: newStatus),
                          );
                        },
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Flexible(
                        child: InkWell(
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
                            await di<AuthorizationManager>()
                                .updatePupilAuthorization(
                                  pupilId: pupil.pupilId,
                                  authorizationId: authorization.id!,
                                  comment: result.value,
                                );
                          },
                          child: Text(
                            pupilAuthorization.comment ?? 'kein Kommentar',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.interactiveColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
