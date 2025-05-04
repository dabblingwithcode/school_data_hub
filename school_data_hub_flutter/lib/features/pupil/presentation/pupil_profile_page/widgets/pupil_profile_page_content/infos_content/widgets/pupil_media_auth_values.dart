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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Einwilligung in die Veröffentlichung von:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Text('Gruppenfotos Presse:',
                        style: TextStyle(fontSize: 16.0)),
                    const Gap(10),
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesInPress: !newValue!);
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesInPress: newValue!);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text('Gruppenfotos Website:',
                        style: TextStyle(fontSize: 16.0)),
                    const Gap(10),
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesOnWebsite: !newValue!);
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesOnWebsite: newValue!);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text('Name in Presse:',
                        style: TextStyle(fontSize: 16.0)),
                    const Gap(10),
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameInPress: !newValue!);
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameInPress: newValue!);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text('Name in Website:',
                        style: TextStyle(fontSize: 16.0)),
                    const Gap(10),
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameOnWebsite: !newValue!);
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, nameOnWebsite: newValue!);
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text('Porträtfoto in Presse:',
                        style: TextStyle(fontSize: 16.0)),
                    const Gap(10),
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil,
                              portraitPicturesInPress: !newValue!);
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, portraitPicturesInPress: newValue!);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Porträtfoto in Website:',
                        style: TextStyle(fontSize: 16.0)),
                    const Gap(5),
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil,
                              portraitPicturesOnWebsite: !newValue!);
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
                          if (publicMediaAuthDocumentId == null) return;
                          await _pupilManager.updatePublicMediaAuth(
                              pupil: pupil, groupPicturesOnWebsite: newValue!);
                        },
                      ),
                    ),
                  ],
                )
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
