import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/pupil_set_avatar.dart'
    show CropAvatarView;
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/multi_choice.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/widgets/scope_names_selector.dart';
import 'package:school_data_hub_flutter/features/user/presentation/widgets/roles_dropdown.dart';

class CreateOrEditUserScreen extends WatchingWidget {
  /// When editing from the user list, pass [userWithDevices] to show IDs, created date and devices.
  final UserWithDevices? userWithDevices;

  /// When editing without devices data, or for backward compatibility, pass [user].
  final User? user;

  const CreateOrEditUserScreen({this.userWithDevices, this.user, super.key});

  User? get _effectiveUser => userWithDevices?.user ?? user;
  bool get _isEditing => _effectiveUser != null;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final userManager = di<UserManager>();
    final pupilManager = di<PupilProxyManager>();
    final user = _effectiveUser;

    registerHandler(
      select: (UserManager m) => m.deleteDeviceCommand.errors,
      handler: (context, error, cancel) {
        if (error != null) {
          di<NotificationManager>().showSnackBar(
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
      () => ExpansionController(),
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
      backgroundColor: style.colors.background,
      appBar: AppHeader(
        iconData: Icons.account_box_rounded,
        title: _isEditing ? 'Team-Konto bearbeiten' : 'Neues Team-Konto',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
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
                        padding: EdgeInsets.only(bottom: Style.spacing.sm),
                        child: Text(
                          'Erstellt: ${user.userInfo!.created.formatDateForUser()}',
                          style: context.typography.bodySmall.withColor(
                            style.colors.mutedForeground,
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
                                (d) => GestureDetector(
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
                                    padding: EdgeInsets.only(
                                      bottom: Style.spacing.sm,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          d.isActive
                                              ? Icons.devices
                                              : Icons.devices_other,
                                          size: 20,
                                          color: d.isActive
                                              ? style.colors.success
                                              : style.colors.mutedForeground,
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
                                                style: context
                                                    .typography
                                                    .bodySmall
                                                    .w600,
                                              ),
                                              Text(
                                                'Zuletzt: ${d.lastLogin.formatDateForUser()} · ${d.isActive ? "Aktiv" : "Inaktiv"}',
                                                style: context
                                                    .typography
                                                    .caption
                                                    .withColor(
                                                      style
                                                          .colors
                                                          .mutedForeground,
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
                      Gap(Style.spacing.lg),
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
                        Gap(Style.spacing.lg),
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
                            Gap(Style.spacing.lg),
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
                  Gap(Style.spacing.lg),

                  // Rolle & Rechte
                  _SectionCard(
                    title: 'Rolle & Rechte',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MultiChoice(
                              value: watchedSetAsAdmin,
                              onChanged: (bool v) => setAsAdmin.value = v,
                            ),
                            const Gap(8),
                            Text('Ist Admin', style: context.typography.body),
                            Gap(Style.spacing.xl),
                            MultiChoice(
                              value: watchedSetAsTester,
                              onChanged: (bool v) => setAsTester.value = v,
                            ),
                            const Gap(8),
                            Text(
                              'Ist Tester*in',
                              style: context.typography.body,
                            ),
                          ],
                        ),
                        Gap(Style.spacing.md),
                        RolesDropdown(
                          selectedRole: watchedRole,
                          changeRole: changeRole,
                        ),
                        Gap(Style.spacing.lg),
                        ScopeNamesSelector(scopeNames: scopeNames),
                      ],
                    ),
                  ),
                  Gap(Style.spacing.lg),

                  // Berechtigte Kinder
                  _SectionCard(
                    title: 'Berechtigte Kinder',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wählen Sie die Kinder aus, für die dieser Benutzer berechtigt ist.',
                          style: context.typography.bodySmall.withColor(
                            style.colors.mutedForeground,
                          ),
                        ),
                        Gap(Style.spacing.md),
                        Button(
                          variant: ButtonVariant.secondary,
                          icon: const Icon(Icons.group_add_rounded),
                          label: 'KINDER AUSWÄHLEN',
                          onPressed: () async {
                            final List<int> selectedPupilIds =
                                await context.push<List<int>>(
                                  RoutePaths.utilSelectPupils,
                                  extra: pupilManager
                                      .getPupilsNotListed(
                                        watchedPupilsAuth.toList(),
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
                        ),
                        if (watchedPupilsAuth.isNotEmpty) ...[
                          Gap(Style.spacing.lg),
                          Row(
                            children: [
                              Text(
                                '${watchedPupilsAuth.length} ${watchedPupilsAuth.length == 1 ? "Kind" : "Kinder"} ausgewählt',
                                style: context.typography.subtitle.bold,
                              ),
                              const Spacer(),
                              ExpansionHeader(
                                expansionController:
                                    childrenCustomExpansionController,
                                includeSwitch: true,
                                switchColor: style.colors.interactive,
                              ),
                            ],
                          ),
                          const Gap(8),
                          ExpansionBody(
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
                                  return GestureDetector(
                                    onLongPress: () {
                                      pupilsAuth.value = watchedPupilsAuth
                                          .where(
                                            (id) => id != listedPupil.pupilId,
                                          )
                                          .toSet();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: Style.spacing.sm,
                                      ),
                                      child: CardBox(
                                        padding: EdgeInsets.all(
                                          Style.spacing.sm,
                                        ),
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
                                                  style: context
                                                      .typography
                                                      .subtitle
                                                      .bold,
                                                ),
                                                Text(
                                                  listedPupil.lastName,
                                                  style:
                                                      context.typography.body,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              children: [
                                                Text(
                                                  listedPupil.group,
                                                  style: context
                                                      .typography
                                                      .subtitle
                                                      .bold
                                                      .withColor(
                                                        style.colors.groupColor,
                                                      ),
                                                ),
                                                Text(
                                                  listedPupil.schoolGrade.name,
                                                  style: context
                                                      .typography
                                                      .subtitle
                                                      .bold
                                                      .withColor(
                                                        style
                                                            .colors
                                                            .schoolGradeColor,
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
                          Text(
                            'Keine Kinder ausgewählt',
                            style: context.typography.bodySmall.withColor(
                              style.colors.mutedForeground,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Gap(Style.spacing.lg),

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
                          Gap(Style.spacing.lg),
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
                          Gap(Style.spacing.lg),
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
                  Gap(Style.spacing.lg),

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
                        Gap(Style.spacing.lg),
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
                        Gap(Style.spacing.lg),
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
                  Gap(Style.spacing.xl),

                  if (!_isEditing)
                    Padding(
                      padding: EdgeInsets.only(bottom: Style.spacing.md),
                      child: Row(
                        children: [
                          MultiChoice(
                            value: watchedMultipleEntries,
                            onChanged: (bool v) => multipleEntries.value = v,
                          ),
                          const Gap(8),
                          Text(
                            'mehrere Einträge',
                            style: context.typography.body,
                          ),
                        ],
                      ),
                    ),
                  if (!_isEditing) const Gap(8),

                  Button(
                    variant: ButtonVariant.primary,
                    label: _isEditing ? 'SPEICHERN' : 'SENDEN',
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
                          di<NotificationManager>().showSnackBar(
                            NotificationType.error,
                            'Benutzer konnte nicht erstellt werden.',
                          );
                        }
                      }
                    },
                  ),
                  Gap(Style.spacing.md),
                  Button(
                    variant: ButtonVariant.secondary,
                    label: 'ABBRECHEN',
                    onPressed: () => Navigator.pop(context),
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
    final style = Style.of(context);
    return GestureDetector(
      onTap: _uploading ? null : _pickAndUploadImage,
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: style.colors.accent,
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: _uploading
                ? Center(child: Spinner(color: style.colors.background))
                : _buildImage(),
          ),
          if (!_uploading)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(Style.spacing.xs),
                decoration: BoxDecoration(
                  color: style.colors.interactive,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: style.colors.background,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final style = Style.of(context);
    final url = widget.currentImageUrl;
    if (url == null || url.isEmpty) {
      return Icon(Icons.person, size: 40, color: style.colors.background);
    }
    final resolvedUrl =
        '${di<EnvManager>().activeEnv!.serverUrl}serverpod_cloud_storage?method=file&path=$url';
    return Image.network(
      resolvedUrl,
      width: 80,
      height: 80,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          Icon(Icons.person, size: 40, color: style.colors.background),
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
      di<NotificationManager>().showSnackBar(
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
    final style = Style.of(context);
    return CardBox(
      variant: CardBoxVariant.bordered,
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.typography.subtitle.bold.withColor(
              style.colors.accent,
            ),
          ),
          Gap(Style.spacing.md),
          child,
        ],
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
        Text(label, style: context.typography.body.bold),
        const Gap(6),
        child,
      ],
    );
  }
}
