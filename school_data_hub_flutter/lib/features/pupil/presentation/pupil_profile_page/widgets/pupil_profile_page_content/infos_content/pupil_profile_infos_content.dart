import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper_functions.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_user_helpers.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/new_matrix_user_page/new_matrix_user_page.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/widgets/dialogues/logout_devices_dialog.dart';
import 'package:school_data_hub_flutter/features/matrix/services/matrix_credentials_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/widgets/avatar_auth_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/infos_content/widgets/pupil_media_auth_values.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();

final _matrixPolicyManager = di<MatrixPolicyManager>();

final _serverpodSessionManager = di<ServerpodSessionManager>();

class PupilInfosContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilInfosContent({required this.pupil, super.key});
  TextEditingController createController() {
    return TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //  final pupil = watch(passedPupil);
    List<PupilProxy> pupilSiblings = _pupilManager.siblings(pupil);
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: AppPaddings.pupilProfileCardPadding,
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_rounded,
                  color: AppColors.backgroundColor,
                  size: 24,
                ),
                Gap(5),
                Text(
                  'Infos',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor),
                ),
              ],
            ),
            const Gap(15),
            const Row(
              children: [
                Text('Besondere Infos:', style: TextStyle(fontSize: 18.0)),
                Gap(5),
              ],
            ),
            const Gap(5),
            InkWell(
              onTap: () async {
                final String? specialInformation = await longTextFieldDialog(
                  title: 'Besondere Infos',
                  labelText: 'Besondere Infos',
                  textinField: pupil.specialInformation ?? '',
                  parentContext: context,
                );
                if (specialInformation == null) return;
                await _pupilManager.updateStringProperty(
                    pupilId: pupil.pupilId,
                    property: 'specialInformation',
                    value: specialInformation);
              },
              onLongPress: () async {
                if (pupil.specialInformation == null) return;
                final bool? confirm = await confirmationDialog(
                    context: context,
                    title: 'Besondere Infos löschen',
                    message:
                        'Besondere Informationen für dieses Kind löschen?');
                if (confirm == false || confirm == null) return;
                await _pupilManager.updateStringProperty(
                    pupilId: pupil.pupilId,
                    property: 'specialInformation',
                    value: null);
              },
              child: Row(
                children: [
                  Flexible(
                    child: pupil.specialInformation != null
                        ? Text(pupil.specialInformation!,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.backgroundColor))
                        : const Text(
                            'keine Einträge',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.interactiveColor),
                          ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Row(
              children: [
                const Text('Geschlecht:', style: TextStyle(fontSize: 18.0)),
                const Gap(10),
                Text(pupil.gender == 'm' ? 'männlich' : 'weiblich',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold))
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Text('Geburtsdatum:', style: TextStyle(fontSize: 18.0)),
                const Gap(10),
                Text(pupil.birthday.formatForUser(),
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold))
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Text('Aufnahmedatum:', style: TextStyle(fontSize: 18.0)),
                const Gap(10),
                Text(pupil.pupilSince.formatForUser(),
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold))
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Text('Kontakt:', style: TextStyle(fontSize: 18.0)),
                const Gap(10),
                InkWell(
                  onTap: () {
                    if (pupil.contact != null && pupil.contact!.isNotEmpty) {
                      MatrixPolicyHelper.launchMatrixUrl(
                          context, pupil.contact!);
                    }
                  },
                  onLongPress: () async {
                    final String? contact = await shortTextfieldDialog(
                      title: 'Kontakt',
                      hintText: 'Kontakt des Schülers/der Schülerin',
                      labelText: 'Kontakt',
                      textinField: pupil.contact ?? '',
                      context: context,
                    );
                    if (contact == null) return;
                    await _pupilManager.updateStringProperty(
                        pupilId: pupil.pupilId,
                        property: 'contact',
                        value: contact);
                  },
                  child: Text(
                      pupil.contact?.isNotEmpty == true
                          ? pupil.contact!
                          : 'keine Angabe',
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.interactiveColor)),
                ),
                pupil.contact == null || pupil.contact!.isEmpty
                    ? IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => NewMatrixUserPage(
                              pupil: pupil,
                              matrixId: MatrixPolicyHelper.generateMatrixId(
                                  isParent: false),
                              displayName:
                                  '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (${pupil.group})',
                            ),
                          ));
                        },
                        icon: const Icon(Icons.add, size: 30))
                    : IconButton(
                        onPressed: () async {
                          final confirmation = await confirmationDialog(
                              context: context,
                              title: 'Passwort zurücksetzen',
                              message:
                                  'Möchten Sie das Passwort wirklich zurücksetzen?');
                          if (confirmation != true) return;
                          if (context.mounted) {
                            final logOutDevices =
                                await logoutDevicesDialog(context);
                            if (logOutDevices == null) return;
                            final file =
                                await _matrixPolicyManager.resetPassword(
                                    user: MatrixUserHelper.usersFromUserIds(
                                        [pupil.contact!]).first,
                                    logoutDevices: logOutDevices,
                                    isStaff: false);
                            if (file != null && context.mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(pdfFile: file),
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.qr_code_2_rounded, size: 30)),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Text('Kontakt Familie:',
                    style: TextStyle(fontSize: 18.0)),
                const Gap(10),
                InkWell(
                  onTap: () {
                    final bool tutorInfoExists = pupil.tutorInfo != null;

                    if (tutorInfoExists &&
                        pupil.tutorInfo!.parentsContact != null) {
                      MatrixPolicyHelper.launchMatrixUrl(
                          context, pupil.tutorInfo!.parentsContact!);
                    }
                  },
                  onLongPress: () async {
                    final String? parentsContact = await shortTextfieldDialog(
                        title: 'Kontakt Familie',
                        hintText: 'Kontakt der Familie',
                        labelText: 'Kontakt Familie',
                        textinField:
                            pupil.tutorInfo?.parentsContact ?? 'keine Angabe',
                        context: context);
                    if (parentsContact == null) return;
                    await _pupilManager.updateTutorInfo(
                      pupilId: pupil.pupilId,
                      tutorInfo: pupil.tutorInfo != null
                          ? pupil.tutorInfo!
                              .copyWith(parentsContact: parentsContact)
                          : TutorInfo(
                              parentsContact: parentsContact,
                              createdBy: _serverpodSessionManager.userName!),
                    );
                  },
                  child: Text(pupil.tutorInfo?.parentsContact ?? 'keine Angabe',
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.interactiveColor)),
                ),
                pupil.tutorInfo?.parentsContact == null
                    ? IconButton(
                        onPressed: () {
                          String? pupilSiblingsGroups;
                          if (pupil.family != null) {
                            pupilSiblingsGroups = [
                              ..._pupilManager.siblings(pupil),
                              pupil
                            ].map((e) => e.group).toList().join();
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => NewMatrixUserPage(
                              pupil: pupil,
                              matrixId: MatrixPolicyHelper.generateMatrixId(
                                  isParent: true),
                              displayName: pupilSiblingsGroups != null
                                  ? 'Fa. ${pupil.lastName} (E) $pupilSiblingsGroups'
                                  : '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (E) ${pupil.group}',
                              isParent: true,
                            ),
                          ));
                        },
                        icon: const Icon(Icons.add, size: 30))
                    : IconButton(
                        onPressed: () async {
                          final confirmation = await confirmationDialog(
                              context: context,
                              title: 'Passwort zurücksetzen',
                              message:
                                  'Möchten Sie das Passwort wirklich zurücksetzen?');
                          if (confirmation != true) return;
                          if (context.mounted) {
                            final logOutDevices =
                                await logoutDevicesDialog(context);
                            if (logOutDevices == null) return;
                            final file =
                                await _matrixPolicyManager.resetPassword(
                                    user: MatrixUserHelper.usersFromUserIds(
                                        [pupil.contact!]).first,
                                    logoutDevices: logOutDevices,
                                    isStaff: false);
                            if (file != null && context.mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(pdfFile: file),
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.qr_code_2_rounded, size: 30)),
              ],
            ),
            const Gap(10),
            AvatarAuthValues(pupil: pupil),
            const Gap(10),
            PublicMediaAuthValues(pupil: pupil),
            const Gap(10),
            pupilSiblings.isNotEmpty
                ? const Row(
                    children: [
                      Text(
                        'Geschwister:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            pupilSiblings.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 5, bottom: 15),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pupilSiblings.length,
                    itemBuilder: (context, int index) {
                      PupilProxy sibling = pupilSiblings[index];
                      return Column(
                        children: [
                          const Gap(5),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PupilProfilePage(
                                  pupil: sibling,
                                ),
                              ));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AvatarWithBadges(pupil: sibling, size: 80),
                                    const Gap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Gap(5),
                                        Text(
                                          sibling.firstName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          sibling.lastName,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          'Geburtsdatum: ${sibling.birthday.formatForUser()}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
