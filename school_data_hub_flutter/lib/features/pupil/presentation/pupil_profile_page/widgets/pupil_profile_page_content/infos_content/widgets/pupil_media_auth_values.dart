import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

class PublicMediaAuthValues extends StatelessWidget {
  final PupilProxy pupil;
  const PublicMediaAuthValues({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                const Text('Gruppenfotos Presse:',
                    style: TextStyle(fontSize: 18.0)),
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
                    value: pupil.publicMediaAuth.groupPicturesInPress
                        ? false
                        : true,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: !newValue!);
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
                    value: pupil.publicMediaAuth.groupPicturesInPress
                        ? true
                        : false,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: newValue);
                    },
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                const Text('Gruppenfotos Website:',
                    style: TextStyle(fontSize: 18.0)),
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
                    value: pupil.publicMediaAuth.groupPicturesOnWebsite
                        ? false
                        : true,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: !newValue!);
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
                    value: pupil.publicMediaAuth.groupPicturesOnWebsite
                        ? true
                        : false,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: newValue);
                    },
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                const Text('Name in Presse:', style: TextStyle(fontSize: 18.0)),
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
                    value: pupil.publicMediaAuth.nameInPress ? false : true,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: !newValue!);
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
                    value: pupil.publicMediaAuth.nameInPress ? true : false,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: newValue);
                    },
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                const Text('Name in Website:',
                    style: TextStyle(fontSize: 18.0)),
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
                    value: pupil.publicMediaAuth.nameOnWebsite ? false : true,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: !newValue!);
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
                    value: pupil.publicMediaAuth.nameOnWebsite ? true : false,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: newValue);
                    },
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                const Text('Porträtfoto in Presse:',
                    style: TextStyle(fontSize: 18.0)),
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
                    value: pupil.publicMediaAuth.portraitPicturesInPress
                        ? false
                        : true,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: !newValue!);
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
                    value: pupil.publicMediaAuth.portraitPicturesInPress
                        ? true
                        : false,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: newValue);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Porträtfoto in Website:',
                    style: TextStyle(fontSize: 18.0)),
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
                    value: pupil.publicMediaAuth.portraitPicturesOnWebsite
                        ? false
                        : true,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: !newValue!);
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
                    value: pupil.publicMediaAuth.portraitPicturesOnWebsite
                        ? true
                        : false,
                    onChanged: (newValue) async {
                      // await _pupilManager.patchOnePupilProperty(
                      //     pupilId: pupil.internalId,
                      //     jsonKey: 'avatar_auth',
                      //     value: newValue);
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
            await _pupilManager.updatePupilPublicMediaAuth(file, pupil);
          },
          onLongPress: () async {
            if (_serverpodSessionManager.isAdmin != true) return;
            if (pupil.publicMediaAuthDocumentId == null) return;
            final bool? result = await confirmationDialog(
                context: context,
                title: 'Dokument löschen',
                message:
                    'Dokument für die Einwilligung in Veröffentlichungen von ${pupil.firstName} ${pupil.lastName} löschen?\nDie Werte werden zurückgesetzt! ');
            if (result != true) return;
            await _pupilManager.resetPublicMediaAuth(pupil.pupilId);
            _notificationService.showSnackBar(
                NotificationType.success, 'Die Einwilligung wurde geändert!');
          },
          child: pupil.publicMediaAuthDocumentId != null
              ? DocumentImage(
                  documentId: pupil.publicMediaAuthDocument!.documentId,
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
    );
  }
}
