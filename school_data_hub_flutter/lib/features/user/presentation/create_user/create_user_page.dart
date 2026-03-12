import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_set_avatar.dart'
    show CropAvatarView;
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/widgets/scope_names_selector.dart';
import 'package:school_data_hub_flutter/features/user/presentation/widgets/roles_dropdown.dart';

class CreateOrEditUserPage extends WatchingWidget {
  /// When editing from the user list, pass [userWithDevices] to show IDs, created date and devices.
  final UserWithDevices? userWithDevices;

  /// When editing without devices data, or for backward compatibility, pass [user].
  final User? user;

  const CreateOrEditUserPage({this.userWithDevices, this.user, super.key});

  User? get _effectiveUser => userWithDevices?.user ?? user;
  bool get _isEditing => _effectiveUser != null;

  @override
  Widget build(BuildContext context) {
    final userManager = di<UserManager>();
    final pupilManager = di<PupilProxyManager>();
    final user = _effectiveUser;

    registerHandler(
      select: (UserManager m) => m.deleteDeviceCommand.errors,
      handler: (context, error, cancel) {
        if (error != null) {
          di<NotificationService>().showSnackBar(
            NotificationType.error,
            'Gerät konnte nicht gelöscht werden.',
          );
        }
      },
    );

    // When editing, use list from UserManager so device list updates after delete.
    final usersWithDevicesList = watch(userManager.usersWithDevices).value;
    final effectiveUserWithDevices = _isEditing && userWithDevices != null
        ? (usersWithDevicesList
                  .where(
                    (uwd) =>
                        uwd.user.userInfoId == userWithDevices!.user.userInfoId,
                  )
                  .firstOrNull ??
              userWithDevices)
        : userWithDevices;
    final devices = effectiveUserWithDevices?.userDevices ?? [];

    final childrenCustomExpansionController = createOnce(
      () => CustomExpansionTileController(),
    );

    final TextEditingController fullNameController = createOnce(
      () => TextEditingController(text: user?.userInfo?.fullName ?? ''),
    );
    final TextEditingController userNameController = createOnce(
      () => TextEditingController(text: user?.userInfo?.userName ?? ''),
    );
    final TextEditingController passwordController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController repeatPasswordController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController emailController = createOnce(
      () => TextEditingController(text: user?.userInfo?.email ?? ''),
    );
    final TextEditingController matrixIdController = createOnce(
      () => TextEditingController(text: user?.matrixUserId ?? ''),
    );
    final setAsAdmin = createOnce(
      () => ValueNotifier<bool>(user?.role == Role.admin),
    );
    final setAsTester = createOnce(
      () => ValueNotifier<bool>(user?.userFlags.isTester ?? false),
    );
    final role = createOnce(
      () => ValueNotifier<Role>(user?.role ?? Role.notAssigned),
    );
    final scopeNames = createOnce(() => ValueNotifier<List<String>>([]));
    final watchedScopeNames = watch(scopeNames).value;
    final multipleEntries = createOnce(() => ValueNotifier<bool>(false));
    final watchedMultipleEntries = watch(multipleEntries).value;
    final pupilsAuth = createOnce(
      () => ValueNotifier<Set<int>>(user?.pupilsAuth ?? {}),
    );
    final watchedPupilsAuth = watch(pupilsAuth).value;

    void changeRole(Role? newRole) {
      role.value = newRole!;
    }

    final TextEditingController timeUnitsController = createOnce(
      () => TextEditingController(
        text: user != null ? user.timeUnits.toString() : '',
      ),
    );
    final TextEditingController reliefTimeUnitsController = createOnce(
      () => TextEditingController(
        text: user != null ? user.reliefTimeUnits.toString() : '',
      ),
    );
    final TextEditingController creditController = createOnce(
      () => TextEditingController(
        text: user != null ? user.credit.toString() : '',
      ),
    );

    final watchedSetAsAdmin = watch(setAsAdmin).value;
    final watchedSetAsTester = watch(setAsTester).value;
    final watchedRole = watch(role).value;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_box_rounded,
              size: 25,
              color: Colors.white,
            ),
            const Gap(10),
            Text(
              _isEditing ? 'Team-Konto bearbeiten' : 'Neues Team-Konto',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Read-only Kontoinformationen when editing
                  if (_isEditing && user != null) ...[
                    if (user.userInfo?.created != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Erstellt: ${user.userInfo!.created.formatDateForUser()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    if (devices.isNotEmpty) ...[
                      _SectionCard(
                        title: 'Geräte / Sitzungen',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: devices
                              .map(
                                (d) => InkWell(
                                  onLongPress: () async {
                                    final confirm = await confirmationDialog(
                                      context: context,
                                      title: 'Gerät löschen',
                                      message:
                                          'Sind Sie sicher, dass Sie das Gerät löschen möchten?',
                                    );
                                    if (confirm == true) {
                                      await userManager.deleteDevice(d);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          d.isActive
                                              ? Icons.devices
                                              : Icons.devices_other,
                                          size: 20,
                                          color: d.isActive
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                        const Gap(8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                d.deviceName.isNotEmpty
                                                    ? d.deviceName
                                                    : d.deviceId,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                'Zuletzt: ${d.lastLogin.formatDateForUser()} · ${d.isActive ? "Aktiv" : "Inaktiv"}',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Gap(16),
                    ],
                  ],

                  // Persönliche Daten
                  _SectionCard(
                    title: 'Persönliche Daten',
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _UserAvatarPicker(
                              currentImageUrl: user?.userInfo?.imageUrl,
                            ),
                            const Gap(20),
                            Expanded(
                              child: _LabeledField(
                                label: 'Name',
                                child: TextField(
                                  controller: fullNameController,
                                  decoration: AppStyles.textFieldDecoration(
                                    labelText: 'Name',
                                  ),
                                  minLines: 1,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 2,
                              child: _LabeledField(
                                label: 'Kürzel',
                                child: TextField(
                                  controller: userNameController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  decoration: AppStyles.textFieldDecoration(
                                    labelText: 'Kürzel',
                                  ),
                                  minLines: 1,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            const Gap(16),
                            Expanded(
                              flex: 3,
                              child: _LabeledField(
                                label: 'E-Mail',
                                child: TextField(
                                  controller: emailController,
                                  decoration: AppStyles.textFieldDecoration(
                                    labelText: 'E-Mail',
                                  ),
                                  minLines: 1,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),

                  // Rolle & Rechte
                  _SectionCard(
                    title: 'Rolle & Rechte',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: watchedSetAsAdmin,
                              onChanged: (bool? v) =>
                                  setAsAdmin.value = v ?? false,
                            ),
                            const Text('Ist Admin'),
                            const Gap(24),
                            Checkbox(
                              value: watchedSetAsTester,
                              onChanged: (bool? v) =>
                                  setAsTester.value = v ?? false,
                            ),
                            const Text('Ist Tester*in'),
                          ],
                        ),
                        const Gap(12),
                        RolesDropdown(
                          selectedRole: watchedRole,
                          changeRole: changeRole,
                        ),
                        const Gap(16),
                        ScopeNamesSelector(scopeNames: scopeNames),
                      ],
                    ),
                  ),
                  const Gap(16),

                  // Berechtigte Kinder
                  _SectionCard(
                    title: 'Berechtigte Kinder',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Wählen Sie die Kinder aus, für die dieser Benutzer berechtigt ist.',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const Gap(12),
                        ElevatedButton.icon(
                          style: AppStyles.actionButtonStyle,
                          onPressed: () async {
                            final List<int> selectedPupilIds =
                                await Navigator.of(context).push(
                                  MaterialPageRoute<List<int>>(
                                    builder: (ctx) => SelectPupilsListPage(
                                      selectablePupils: pupilManager
                                          .getPupilsNotListed(
                                            watchedPupilsAuth.toList(),
                                          ),
                                    ),
                                  ),
                                ) ??
                                [];
                            if (selectedPupilIds.isNotEmpty) {
                              pupilsAuth.value = {
                                ...watchedPupilsAuth,
                                ...selectedPupilIds,
                              };
                            }
                          },
                          icon: const Icon(
                            Icons.group_add_rounded,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'KINDER AUSWÄHLEN',
                            style: AppStyles.buttonTextStyle,
                          ),
                        ),
                        if (watchedPupilsAuth.isNotEmpty) ...[
                          const Gap(16),
                          Row(
                            children: [
                              Text(
                                '${watchedPupilsAuth.length} ${watchedPupilsAuth.length == 1 ? "Kind" : "Kinder"} ausgewählt',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              CustomExpansionTileSwitch(
                                customExpansionTileController:
                                    childrenCustomExpansionController,
                                includeSwitch: true,
                                switchColor: AppColors.interactiveColor,
                              ),
                            ],
                          ),
                          const Gap(8),
                          CustomExpansionTileContent(
                            tileController: childrenCustomExpansionController,
                            widgetList: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: pupilManager
                                    .getPupilsFromPupilIds(
                                      watchedPupilsAuth.toList(),
                                    )
                                    .length,
                                itemBuilder: (context, int index) {
                                  final pupilsList = pupilManager
                                      .getPupilsFromPupilIds(
                                        watchedPupilsAuth.toList(),
                                      );
                                  PupilProxy listedPupil = pupilsList[index];
                                  return InkWell(
                                    onLongPress: () {
                                      pupilsAuth.value = watchedPupilsAuth
                                          .where(
                                            (id) => id != listedPupil.pupilId,
                                          )
                                          .toSet();
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            AvatarWithBadges(
                                              pupil: listedPupil,
                                              size: 50,
                                            ),
                                            const Gap(10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listedPupil.firstName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  listedPupil.lastName,
                                                  style: const TextStyle(),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              children: [
                                                Text(
                                                  listedPupil.group,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.groupColor,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  listedPupil.schoolGrade.name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .schoolyearColor,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(15),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ] else ...[
                          const Gap(8),
                          const Text(
                            'Keine Kinder ausgewählt',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Gap(16),

                  // Konto (Matrix-ID, Passwort)
                  _SectionCard(
                    title: 'Konto',
                    child: Column(
                      children: [
                        _LabeledField(
                          label: 'Matrix-ID',
                          child: TextField(
                            controller: matrixIdController,
                            decoration: AppStyles.textFieldDecoration(
                              labelText: 'Matrix-ID',
                            ),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                        if (!_isEditing) ...[
                          const Gap(16),
                          _LabeledField(
                            label: 'Passwort',
                            child: TextField(
                              controller: passwordController,
                              decoration: AppStyles.textFieldDecoration(
                                labelText: 'Passwort',
                              ),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                          const Gap(16),
                          _LabeledField(
                            label: 'Passwort wiederholen',
                            child: TextField(
                              controller: repeatPasswordController,
                              decoration: AppStyles.textFieldDecoration(
                                labelText: 'Passwort wiederholen',
                              ),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Gap(16),

                  // Zeiten & Guthaben
                  _SectionCard(
                    title: 'Zeiten & Guthaben',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: _LabeledField(
                            label: 'Stunden',
                            child: TextField(
                              controller: timeUnitsController,
                              decoration: AppStyles.textFieldDecoration(
                                labelText: 'Stunden',
                              ),
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: _LabeledField(
                            label: 'Entlastung',
                            child: TextField(
                              controller: reliefTimeUnitsController,
                              decoration: AppStyles.textFieldDecoration(
                                labelText: 'Entlastungsstunden',
                              ),
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: _LabeledField(
                            label: 'Guthaben',
                            child: TextField(
                              controller: creditController,
                              decoration: AppStyles.textFieldDecoration(
                                labelText: 'Guthaben',
                              ),
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),

                  if (!_isEditing)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Checkbox(
                            value: watchedMultipleEntries,
                            onChanged: (bool? v) =>
                                multipleEntries.value = v ?? false,
                          ),
                          const Text('mehrere Einträge'),
                        ],
                      ),
                    ),
                  if (!_isEditing) const Gap(8),

                  ElevatedButton(
                    style: AppStyles.successButtonStyle,
                    onPressed: () async {
                      if (_isEditing && user != null) {
                        final userInfoId = user.userInfo!.id!;
                        await userManager.updateUser((
                          userInfoId: userInfoId,
                          userName: userNameController.text,
                          fullName: fullNameController.text,
                          email: emailController.text,
                          role: watchedSetAsAdmin ? Role.admin : watchedRole,
                          matrixUserId: matrixIdController.text.trim().isEmpty
                              ? null
                              : matrixIdController.text.trim(),
                          timeUnits:
                              int.tryParse(timeUnitsController.text) ?? 0,
                          reliefTimeUnits:
                              int.tryParse(reliefTimeUnitsController.text) ?? 0,
                          credit: int.tryParse(creditController.text) ?? 0,
                          isTester: setAsTester.value,
                          pupilsAuth: watchedPupilsAuth,
                        ));
                        if (context.mounted) Navigator.pop(context);
                        return;
                      }
                      if (passwordController.text !=
                          repeatPasswordController.text) {
                        informationDialog(
                          context,
                          'Passwörter stimmen nicht überein',
                          'Bitte Passwort überprüfen',
                        );
                        return;
                      }
                      final trimmedEmail = emailController.text.trim();
                      final trimmedUserName = userNameController.text.trim();
                      if (trimmedUserName.isEmpty) {
                        informationDialog(
                          context,
                          'Kürzel fehlt',
                          'Bitte ein Kürzel eingeben.',
                        );
                        return;
                      }
                      if (trimmedEmail.isEmpty) {
                        informationDialog(
                          context,
                          'E-Mail fehlt',
                          'Bitte eine E-Mail-Adresse eingeben.',
                        );
                        return;
                      }
                      if (userManager.users.value.any(
                        (u) => u.userInfo?.email == trimmedEmail,
                      )) {
                        informationDialog(
                          context,
                          'E-Mail-Adresse ist bereits in Verwendung',
                          'Bitte eine andere E-Mail-Adresse eingeben',
                        );
                        return;
                      }
                      if (userManager.users.value.any(
                        (u) => u.userInfo?.userName == trimmedUserName,
                      )) {
                        informationDialog(
                          context,
                          'Kürzel ist bereits in Verwendung',
                          'Bitte einen anderen Kürzel eingeben',
                        );
                        return;
                      }
                      try {
                        await userManager.createUser(
                          userName: trimmedUserName,
                          fullName: fullNameController.text,
                          matrixUserId: matrixIdController.text,
                          email: trimmedEmail,
                          password: passwordController.text,
                          role: watchedSetAsAdmin ? Role.admin : watchedRole,
                          timeUnits:
                              int.tryParse(timeUnitsController.text) ?? 0,
                          reliefTimeUnits:
                              int.tryParse(reliefTimeUnitsController.text) ?? 0,
                          credit: int.tryParse(creditController.text) ?? 0,
                          isTester: setAsTester.value,
                          scopeNames: watchedScopeNames.isNotEmpty
                              ? watchedScopeNames
                              : (watchedSetAsAdmin ? ['Serverpod.admin'] : []),
                          pupilsAuth: watchedPupilsAuth,
                        );
                        if (context.mounted && !multipleEntries.value) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          di<NotificationService>().showSnackBar(
                            NotificationType.error,
                            'Benutzer konnte nicht erstellt werden.',
                          );
                        }
                      }
                    },
                    child: Text(
                      _isEditing ? 'SPEICHERN' : 'SENDEN',
                      style: AppStyles.buttonTextStyle,
                    ),
                  ),
                  const Gap(12),
                  ElevatedButton(
                    style: AppStyles.cancelButtonStyle,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'ABBRECHEN',
                      style: AppStyles.buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserAvatarPicker extends StatefulWidget {
  final String? currentImageUrl;

  const _UserAvatarPicker({this.currentImageUrl});

  @override
  State<_UserAvatarPicker> createState() => _UserAvatarPickerState();
}

class _UserAvatarPickerState extends State<_UserAvatarPicker> {
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _uploading ? null : _pickAndUploadImage,
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: _uploading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : _buildImage(),
          ),
          if (!_uploading)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.interactiveColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final url = widget.currentImageUrl;
    if (url == null || url.isEmpty) {
      return const Icon(Icons.person, size: 40, color: Colors.white);
    }
    // Serverpod stores user images as relative paths
    // (e.g. "serverpod/user_images/1-2.jpg").
    // Resolve them against the server base URL.
    final resolvedUrl =
        '${di<EnvManager>().activeEnv!.serverUrl}serverpod_cloud_storage?method=file&path=$url';
    return Image.network(
      resolvedUrl,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.person, size: 40, color: Colors.white),
    );
  }

  Future<void> _pickAndUploadImage() async {
    ImageSource? source;
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      source = ImageSource.gallery;
    } else {
      source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie'),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );
      if (source == null) return;
    }

    final image = await ImagePicker().pickImage(source: source);
    if (image == null || !mounted) return;

    final File? croppedFile = await Navigator.push<File?>(
      context,
      MaterialPageRoute<File?>(builder: (ctx) => CropAvatarView(image: image)),
    );
    if (croppedFile == null || !mounted) return;

    setState(() => _uploading = true);

    final bytes = await croppedFile.readAsBytes();
    final byteData = ByteData.view(bytes.buffer);
    final success = await di<HubSessionManager>().uploadUserImage(byteData);

    if (success) {
      await di<UserManager>().fetchUsers();
    }

    if (mounted) {
      setState(() => _uploading = false);
      di<NotificationService>().showSnackBar(
        success ? NotificationType.success : NotificationType.error,
        success
            ? 'Profilbild aktualisiert'
            : 'Profilbild konnte nicht hochgeladen werden',
      );
    }
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColor,
              ),
            ),
            const Gap(12),
            child,
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Gap(6),
        child,
      ],
    );
  }
}
