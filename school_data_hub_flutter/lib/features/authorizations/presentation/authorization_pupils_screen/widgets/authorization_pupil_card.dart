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
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class AuthorizationPupilCard extends WatchingWidget {
  final int pupilId;
  final Authorization authorization;
  const AuthorizationPupilCard(this.pupilId, this.authorization, {super.key});
  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();
    final authorizationManager = di<AuthorizationManager>();
    final PupilProxy pupil = pupilManager.getPupilByPupilId(pupilId)!;

    final pupilAuthorization = watchValue(
      (AuthorizationManager x) =>
          x.watchPupilAuthorization(authorization.id!, pupilId),
    );

    if (pupilAuthorization == null) {
      return const SizedBox.shrink();
    }

    return CardBox(
      padding: EdgeInsets.only(
        left: Style.spacing.sm,
        top: Style.spacing.sm,
        bottom: Style.spacing.sm,
        right: Style.spacing.lg,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          di<BottomNavManager>().setPupilProfileNavPage(7);
                          context.push(
                            RoutePaths.pupilProfilePath(pupil.internalId),
                            extra: pupil,
                          );
                        },
                        onLongPress: () async {
                          final bool? confirmation = await confirmationDialog(
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            pupil.firstName,
                            overflow: TextOverflow.fade,
                            style: context.typography.title,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          pupil.lastName,
                          overflow: TextOverflow.fade,
                          style: context.typography.title.w400,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.close, color: Color(0xFFF44336)),
                          CustomCheckboxEitherOr(
                            representedBoolValue:
                                false, // Red/negative checkbox
                            currentStatus: pupilAuthorization.status,
                            onStatusChanged: (newStatus) async {
                              await authorizationManager
                                  .updatePupilAuthorization(
                                    pupilId: pupil.pupilId,
                                    authorizationId: authorization.id!,
                                    status: (value: newStatus),
                                    comment: null,
                                  );
                            },
                          ),
                          const Gap(10),
                          const Icon(Icons.done, color: Color(0xFF4CAF50)),
                          CustomCheckboxEitherOr(
                            representedBoolValue:
                                true, // Green/positive checkbox
                            currentStatus: pupilAuthorization.status,
                            onStatusChanged: (newStatus) async {
                              await authorizationManager
                                  .updatePupilAuthorization(
                                    pupilId: pupil.pupilId,
                                    authorizationId: authorization.id!,
                                    status: (value: newStatus),
                                    comment: null,
                                  );
                            },
                          ),
                          const Gap(15),
                          if (pupilAuthorization.createdBy != null)
                            Text(
                              pupilAuthorization.createdBy!,
                              style: context.typography.title,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(15),
                  GestureDetector(
                    onTap: () async {
                      final File? file = await createAndCropImageFile(context);
                      if (file == null) return;
                      await authorizationManager.addFileToPupilAuthorization(
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
                    child: EncryptedDocumentImage(
                      documentId: pupilAuthorization.file?.documentId,
                      size: 70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              final result = await longTextFieldDialog(
                title: 'Kommentar ändern',
                labelText: 'Kommentar',
                initialValue: pupilAuthorization.comment,
                parentContext: context,
              );
              if (result == null ||
                  result.value == pupilAuthorization.comment ||
                  result.value == '') {
                return;
              }

              await di<AuthorizationManager>().updatePupilAuthorization(
                pupilId: pupil.pupilId,
                authorizationId: authorization.id!,
                status: null,
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
                        style: context.typography.subtitle.w400,
                      ),
                    ],
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
