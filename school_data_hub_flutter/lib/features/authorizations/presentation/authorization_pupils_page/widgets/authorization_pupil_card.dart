import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/document_image.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();
final _authorizationManager = di<AuthorizationManager>();

class AuthorizationPupilCard extends WatchingWidget {
  final int pupilId;
  final Authorization authorization;
  const AuthorizationPupilCard(this.pupilId, this.authorization, {super.key});
  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = _pupilManager.getPupilByPupilId(pupilId)!;

    final thisAuthorization =
        watchValue((AuthorizationManager x) => x.authorizations).firstWhere(
            (authorization) => authorization.id == this.authorization.id);

    final PupilAuthorization pupilAuthorization = thisAuthorization
        .authorizedPupils!
        .firstWhere((element) => element.pupilId == pupilId);

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
                            di<MainMenuBottomNavManager>()
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
                              _authorizationManager.updateAuthorization(
                                  authId: authorization.id!,
                                  membersToUpdate: (
                                    operation: MemberOperation.remove,
                                    pupilIds: [pupil.pupilId],
                                  ));
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
                                  await _authorizationManager
                                      .updatePupilAuthorization(
                                    pupil.pupilId,
                                    authorization.id!,
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
                                  await _authorizationManager
                                      .updatePupilAuthorization(
                                    pupil.pupilId,
                                    authorization.id!,
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
                        final File? file = await createImageFile(context);
                        if (file == null) return;
                        await _authorizationManager.addFileToPupilAuthorization(
                            file, pupilAuthorization.id!);
                      },
                      onLongPress: () async {
                        if (pupilAuthorization.fileId == null) return;
                        final bool? result = await confirmationDialog(
                            context: context,
                            title: 'Dokument löschen',
                            message:
                                'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?');
                        if (result != true) return;

                        await _authorizationManager
                            .removeFileFromPupilAuthorization(
                          pupilAuthorization.id!,
                          pupilAuthorization.file!.documentId,
                        );
                      },
                      child: pupilAuthorization.fileId != null
                          ? DocumentImage(
                              documentId: pupilAuthorization.file!.documentId,
                              size: 70)
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
                      if (authorizationComment == '') return;
                      await di<AuthorizationManager>().updatePupilAuthorization(
                        pupil.pupilId,
                        authorization.id!,
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
