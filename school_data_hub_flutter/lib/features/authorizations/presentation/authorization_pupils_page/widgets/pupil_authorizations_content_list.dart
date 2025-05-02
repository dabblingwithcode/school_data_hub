import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:schuldaten_hub/common/domain/env_manager.dart';
import 'package:schuldaten_hub/common/domain/models/enums.dart';
import 'package:schuldaten_hub/common/services/api/api_settings.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/notification_service.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/authorizations/presentation/authorization_pupils_page/authorization_pupils_page.dart';
import 'package:schuldaten_hub/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class PupilAuthorizationsContentList extends WatchingWidget {
  final PupilProxy pupil;
  const PupilAuthorizationsContentList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final authorizations =
        watchValue((AuthorizationManager x) => x.authorizations);
    List<PupilAuthorization> pupilAuthorizations = [];
    for (final authorization in authorizations) {
      for (final pupilAuthorization in authorization.authorizedPupils) {
        if (pupilAuthorization.pupilId == pupil.internalId) {
          pupilAuthorizations.add(pupilAuthorization);
        }
      }
    }
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pupilAuthorizations.length,
      itemBuilder: (BuildContext context, int index) {
        final Authorization authorization = locator<AuthorizationManager>()
            .getAuthorization(pupilAuthorizations[index].originAuthorization);
        final PupilAuthorization pupilAuthorization =
            pupilAuthorizations[index];
        return GestureDetector(
            onTap: () {},
            onLongPress: () async {},
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (ctx) =>
                                              AuthorizationPupilsPage(
                                            authorization,
                                          ),
                                        ));
                                      },
                                      child: Row(children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              authorization.authorizationName,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors
                                                      .interactiveColor),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    const Gap(5),
                                    Row(children: [
                                      Flexible(
                                        child: Text(
                                          authorization
                                              .authorizationDescription,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      const Gap(5),
                                    ]),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final File? file =
                                          await uploadImageFile(context);
                                      if (file == null) return;
                                      await locator<AuthorizationManager>()
                                          .postAuthorizationFile(
                                              file,
                                              pupil.internalId,
                                              authorization.authorizationId);
                                      locator<NotificationService>().showSnackBar(
                                          NotificationType.success,
                                          'Die Einwilligung wurde geändert!');
                                    },
                                    onLongPress: (pupilAuthorization.fileId ==
                                            null)
                                        ? () {}
                                        : () async {
                                            if (pupilAuthorization.fileId ==
                                                null) return;
                                            final bool? result =
                                                await confirmationDialog(
                                                    context: context,
                                                    title: 'Dokument löschen',
                                                    message:
                                                        'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?');
                                            if (result != true) return;
                                            await locator<
                                                    AuthorizationManager>()
                                                .deleteAuthorizationFile(
                                              pupil.internalId,
                                              authorization.authorizationId,
                                              pupilAuthorization.fileId!,
                                            );
                                            locator<NotificationService>()
                                                .showSnackBar(
                                                    NotificationType.success,
                                                    'Die Einwilligung wurde geändert!');
                                          },
                                    child: pupilAuthorization.fileId != null
                                        ? Provider<DocumentImageData>.value(
                                            updateShouldNotify:
                                                (oldValue, newValue) =>
                                                    oldValue.documentUrl !=
                                                    newValue.documentUrl,
                                            value: DocumentImageData(
                                                documentTag:
                                                    pupilAuthorization.fileId!,
                                                documentUrl:
                                                    '${locator<EnvManager>().env!.serverUrl}${AuthorizationApiService().getPupilAuthorizationFile(pupil.internalId, authorization.authorizationId)}',
                                                size: 70),
                                            child: const DocumentImage(),
                                          )
                                        : SizedBox(
                                            height: 70,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.asset(
                                                  'assets/document_camera.png'),
                                            ),
                                          ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Kommentar',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                //- TO-DO BACKEND: model needs a modifedBy field
                                if (pupilAuthorization.createdBy != null)
                                  Text(pupilAuthorization.createdBy!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),

                                const Gap(15),
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
                                      await locator<AuthorizationManager>()
                                          .updatePupilAuthorizationProperty(
                                              pupil.internalId,
                                              pupilAuthorizations[index]
                                                  .originAuthorization,
                                              false,
                                              null);
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
                                    value: pupilAuthorization.status ?? false,
                                    onChanged: (value) async {
                                      await locator<AuthorizationManager>()
                                          .updatePupilAuthorizationProperty(
                                              pupil.internalId,
                                              pupilAuthorizations[index]
                                                  .originAuthorization,
                                              value,
                                              null);
                                    },
                                  ),
                                ),
                              ]),
                          const Gap(5),
                          Row(children: [
                            Flexible(
                              child: InkWell(
                                onTap: () async {
                                  final String? comment =
                                      await longTextFieldDialog(
                                          title: 'Kommentar',
                                          labelText: 'Kommentar eintragen',
                                          textinField:
                                              pupilAuthorization.comment ?? '',
                                          parentContext: context);
                                  if (comment == null) {
                                    return;
                                  }
                                  await locator<AuthorizationManager>()
                                      .updatePupilAuthorizationProperty(
                                          pupil.internalId,
                                          pupilAuthorization
                                              .originAuthorization,
                                          null,
                                          comment);
                                },
                                child: Text(
                                  pupilAuthorization.comment ??
                                      'kein Kommentar',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.interactiveColor,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          const Gap(5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
