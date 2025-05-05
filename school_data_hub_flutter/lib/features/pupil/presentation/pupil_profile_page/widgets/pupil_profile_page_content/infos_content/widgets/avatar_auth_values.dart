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

class AvatarAuthValues extends WatchingWidget {
  final PupilProxy pupil;
  const AvatarAuthValues({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final avatarAuth = watchPropertyValue((m) => m.avatarAuth, target: pupil);
    final avatarAuthId =
        watchPropertyValue((m) => m.avatarAuthId, target: pupil);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Einwilligung avatar:', style: TextStyle(fontSize: 18.0)),
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
            value: (avatarAuth != null) ? false : true,
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
            value: (avatarAuth != null) ? true : false,
            onChanged: (newValue) async {
              // await _pupilManager.patchOnePupilProperty(
              //     pupilId: pupil.internalId,
              //     jsonKey: 'avatar_auth',
              //     value: newValue);
            },
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            final File? file = await createImageFile(context);
            if (file == null) return;
            await _pupilManager.updatePupilDocument(
                file, pupil, PupilDocumentType.avatarAuth);
          },
          onLongPress: () async {
            if (_serverpodSessionManager.isAdmin != true) return;
            if (avatarAuth == null) return;
            final bool? result = await confirmationDialog(
                context: context,
                title: 'Dokument löschen',
                message:
                    'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?');
            if (result != true) return;
            await _pupilManager.deletePupilDocument(
              pupil.pupilId,
              avatarAuth.documentId,
              PupilDocumentType.avatarAuth,
            );
            _notificationService.showSnackBar(
                NotificationType.success, 'Die Einwilligung wurde geändert!');
          },
          child: avatarAuthId != null
              ? DocumentImage(
                  documentId: avatarAuth!.documentId,
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
