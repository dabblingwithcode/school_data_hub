import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _serverpodSessionManager = di<ServerpodSessionManager>();

final _pupilManager = di<PupilManager>();

final _notificationService = di<NotificationService>();

class PublicMediaAuthValues extends WatchingWidget {
  final PupilProxy pupil;
  const PublicMediaAuthValues({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final publicMediaAuth =
        watchPropertyValue((m) => m.publicMediaAuth, target: pupil);
    final publicMediaAuthDocumentId =
        watchPropertyValue((m) => m.publicMediaAuthDocumentId, target: pupil);
    final publicMediaAuthDocument =
        watchPropertyValue((m) => m.publicMediaAuthDocument, target: pupil);

    return Column(
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: const Text('Einwilligung in die Veröffentlichung von:',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Gruppenfotos Presse:',
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Row(
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
                        value:
                            publicMediaAuth.groupPicturesInPress ? false : true,
                        onChanged: (newValue) async {
                          if (newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesInPress: false);
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
                        value:
                            publicMediaAuth.groupPicturesInPress ? true : false,
                        onChanged: (newValue) async {
                          if (publicMediaAuth.groupPicturesInPress &&
                              newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesInPress: true);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Row(
                  children: [
                    Text('Gruppenfotos Website:',
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Row(
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
                        value: publicMediaAuth.groupPicturesOnWebsite
                            ? false
                            : true,
                        onChanged: (newValue) async {
                          if (newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesOnWebsite: false);
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
                        value: publicMediaAuth.groupPicturesOnWebsite
                            ? true
                            : false,
                        onChanged: (newValue) async {
                          if (publicMediaAuth.groupPicturesOnWebsite &&
                              newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesOnWebsite: true);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Row(
                  children: [
                    Text('Name in Presse:', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Row(
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
                        value: publicMediaAuth.nameInPress ? false : true,
                        onChanged: (newValue) async {
                          if (newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameInPress: false);
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
                        value: publicMediaAuth.nameInPress ? true : false,
                        onChanged: (newValue) async {
                          if (publicMediaAuth.nameInPress && newValue == false)
                            return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameInPress: true);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Row(
                  children: [
                    Text('Name in Website:', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Row(
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
                        value: publicMediaAuth.nameOnWebsite ? false : true,
                        onChanged: (newValue) async {
                          if (newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameOnWebsite: false);
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
                        value: publicMediaAuth.nameOnWebsite ? true : false,
                        onChanged: (newValue) async {
                          if (publicMediaAuth.nameOnWebsite &&
                              newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameOnWebsite: true);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                const Row(
                  children: [
                    Text('Porträtfoto in Presse:',
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Row(
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
                        value: publicMediaAuth.portraitPicturesInPress
                            ? false
                            : true,
                        onChanged: (newValue) async {
                          if (newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, portraitPicturesInPress: false);
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
                        value: publicMediaAuth.portraitPicturesInPress
                            ? true
                            : false,
                        onChanged: (newValue) async {
                          if (publicMediaAuth.portraitPicturesInPress &&
                              newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, portraitPicturesInPress: true);
                        },
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text('Porträtfoto in Website:',
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                Row(
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
                        value: publicMediaAuth.portraitPicturesOnWebsite
                            ? false
                            : true,
                        onChanged: (newValue) async {
                          if (newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, portraitPicturesOnWebsite: false);
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
                        value: publicMediaAuth.portraitPicturesOnWebsite
                            ? true
                            : false,
                        onChanged: (newValue) async {
                          if (publicMediaAuth.portraitPicturesOnWebsite &&
                              newValue == false) return;
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, portraitPicturesOnWebsite: true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                final File? file = await createImageFile(context);
                if (file == null) return;
                await _pupilManager.updatePupilDocument(
                    file, pupil, PupilDocumentType.publicMediaAuth);
              },
              onLongPress: () async {
                if (_serverpodSessionManager.isAdmin != true) return;
                if (publicMediaAuthDocumentId == null) return;
                final bool? result = await confirmationDialog(
                    context: context,
                    title: 'Dokument löschen',
                    message:
                        'Dokument für die Einwilligung in Veröffentlichungen von ${pupil.firstName} ${pupil.lastName} löschen?\nDie Werte werden zurückgesetzt! ');
                if (result != true) return;
                await _pupilManager.resetPublicMediaAuth(pupil.pupilId);
                _notificationService.showSnackBar(NotificationType.success,
                    'Die Einwilligung wurde geändert!');
              },
              child: publicMediaAuthDocumentId != null
                  ? DocumentImage(
                      documentId: publicMediaAuthDocument!.documentId,
                      size: 70,
                    )
                  : SizedBox(
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/document_camera.png'),
                      ),
                    ),
            ),
            const Gap(10),
          ],
        ),
      ],
    );
  }
}
