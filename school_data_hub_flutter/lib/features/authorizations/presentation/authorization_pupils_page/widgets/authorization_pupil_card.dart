import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/api/api_settings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_service.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/main_menu/widgets/landing_bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
import 'package:schuldaten_hub/features/pupil/domain/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationPupilCard extends StatelessWidget with WatchItMixin {
  final int internalId;
  final Authorization authorization;
  AuthorizationPupilCard(this.internalId, this.authorization, {super.key});
  @override
  Widget build(BuildContext context) {
    final authorizationLocator = locator<AuthorizationManager>();

    final PupilProxy pupil =
        watch(locator<PupilManager>().getPupilById(internalId)!);
    final thisAuthorization =
        watchValue((AuthorizationManager x) => x.authorizations).firstWhere(
            (authorization) =>
                authorization.authorizationId ==
                this.authorization.authorizationId);
    final PupilAuthorization pupilAuthorization = thisAuthorization
        .authorizedPupils
        .firstWhere((element) => element.pupilId == internalId);

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarWithBadges(pupil: pupil, size: 80),
                //const SizedBox(width: 10), // Add some spacing
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            locator<MainMenuBottomNavManager>()
                                .setPupilProfileNavPage(7);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PupilProfilePage(
                                pupil: pupil,
                              ),
                            ));
                          },
                          onLongPress: () async {
                            final bool? confirmation = await confirmationDialog(
                                context: context,
                                title: 'Kind aus der Liste löschen',
                                message:
                                    'Die Einwilligung von ${pupil.firstName} löschen?');
                            if (confirmation == true) {
                              locator<AuthorizationManager>()
                                  .deletePupilAuthorization(pupil.internalId,
                                      authorization.authorizationId);
                            }
                            return;
                          },
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              pupil.firstName,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            pupil.lastName,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                activeColor: Colors.red,
                                value: (pupilAuthorization.status == null ||
                                        pupilAuthorization.status == true)
                                    ? false
                                    : true,
                                onChanged: (value) async {
                                  await authorizationLocator
                                      .updatePupilAuthorizationProperty(
                                    pupil.internalId,
                                    authorization.authorizationId,
                                    false,
                                    null,
                                  );
                                },
                              ),
                            ),
                            const Gap(10),
                            const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: (pupilAuthorization.status != true ||
                                        pupilAuthorization.status == null)
                                    ? false
                                    : true,
                                onChanged: (value) async {
                                  await authorizationLocator
                                      .updatePupilAuthorizationProperty(
                                    pupil.internalId,
                                    authorization.authorizationId,
                                    true,
                                    null,
                                  );
                                },
                              ),
                            ),
                            const Gap(15),
                            if (pupilAuthorization.createdBy != null)
                              Text(
                                pupilAuthorization.createdBy!,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                    InkWell(
                      onTap: () async {
                        final File? file = await uploadImageFile(context);
                        if (file == null) return;
                        await locator<AuthorizationManager>()
                            .postAuthorizationFile(file, pupil.internalId,
                                authorization.authorizationId);
                        locator<NotificationService>().showSnackBar(
                            NotificationType.success,
                            'Dem Nachweis wurde ein Dokument hinzugefügt!');
                      },
                      onLongPress: (pupilAuthorization.fileId == null)
                          ? () {}
                          : () async {
                              if (pupilAuthorization.fileId == null) return;
                              final bool? result = await confirmationDialog(
                                  context: context,
                                  title: 'Dokument löschen',
                                  message:
                                      'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?');
                              if (result != true) return;
                              await locator<AuthorizationManager>()
                                  .deleteAuthorizationFile(
                                pupil.internalId,
                                authorization.authorizationId,
                                pupilAuthorization.fileId!,
                              );
                              locator<NotificationService>().showSnackBar(
                                  NotificationType.success,
                                  'Die Einwilligung wurde geändert!');
                            },
                      child: pupilAuthorization.fileId != null
                          ? Provider<DocumentImageData>.value(
                              updateShouldNotify: (oldValue, newValue) =>
                                  oldValue.documentTag != newValue.documentTag,
                              value: DocumentImageData(
                                  documentTag: pupilAuthorization.fileId!,
                                  documentUrl: AuthorizationApiService()
                                      .getPupilAuthorizationFile(
                                          pupil.internalId,
                                          authorization.authorizationId),
                                  size: 70),
                              child: const DocumentImage(),
                            )
                          : SizedBox(
                              height: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child:
                                    Image.asset('assets/document_camera.png'),
                              ),
                            ),
                    )
                  ],
                ),
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(10),
                Text('Kommentar: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Gap(5),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final String? authorizationComment =
                          await longTextFieldDialog(
                              title: 'Kommentar ändern',
                              labelText: 'Kommentar',
                              textinField: pupilAuthorization.comment,
                              parentContext: context);
                      if (authorizationComment == null) return;
                      if (authorizationComment == '') {}
                      await locator<AuthorizationManager>()
                          .updatePupilAuthorizationProperty(
                        pupil.internalId,
                        authorization.authorizationId,
                        null,
                        authorizationComment == ''
                            ? null
                            : authorizationComment,
                      );
                    },
                    child: Text(
                      pupilAuthorization.comment != null
                          ? pupilAuthorization.comment!
                          : 'kein Kommentar',
                      style: const TextStyle(color: AppColors.backgroundColor),
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
