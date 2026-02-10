import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
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
    final TextEditingController imageUrlController = createOnce(
      () => TextEditingController(text: user?.userInfo?.imageUrl ?? ''),
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
                    _SectionCard(
                      title: 'Kontoinformationen',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ReadOnlyRow(
                            'User-ID',
                            '${user.id ?? user.userInfoId}',
                          ),
                          _ReadOnlyRow('UserInfo-ID', '${user.userInfoId}'),
                          if (user.userInfo?.created != null)
                            _ReadOnlyRow(
                              'Erstellt',
                              user.userInfo!.created.formatDateForUser(),
                            ),
                          if (user.pupilsAuth != null)
                            _ReadOnlyRow(
                              'Autorisierte Schüler',
                              '${user.pupilsAuth!.length}',
                            ),
                        ],
                      ),
                    ),
                    const Gap(16),
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
                            _AvatarPreview(
                              imageUrlController: imageUrlController,
                            ),
                            const Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _LabeledField(
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
                                  const Gap(16),
                                  _LabeledField(
                                    label: 'Profilbild-URL',
                                    child: TextField(
                                      controller: imageUrlController,
                                      decoration: AppStyles.textFieldDecoration(
                                        labelText: 'URL des Profilbilds',
                                      ),
                                      minLines: 1,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
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
                          imageUrl: imageUrlController.text.trim().isEmpty
                              ? null
                              : imageUrlController.text.trim(),
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
                      await userManager.createUser(
                        userName: userNameController.text,
                        fullName: fullNameController.text,
                        matrixUserId: matrixIdController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        role: watchedSetAsAdmin ? Role.admin : watchedRole,
                        timeUnits: int.tryParse(timeUnitsController.text) ?? 0,
                        reliefTimeUnits:
                            int.tryParse(reliefTimeUnitsController.text) ?? 0,
                        credit: int.tryParse(creditController.text) ?? 0,
                        isTester: setAsTester.value,
                        scopeNames: watchedScopeNames.isNotEmpty
                            ? watchedScopeNames
                            : (watchedSetAsAdmin ? ['admin'] : ['standard']),
                      );
                      if (context.mounted) Navigator.pop(context);
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

class _AvatarPreview extends StatelessWidget {
  final TextEditingController imageUrlController;

  const _AvatarPreview({required this.imageUrlController});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: imageUrlController,
      builder: (context, _) {
        final url = imageUrlController.text.trim();
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: url.isEmpty
              ? const Icon(Icons.person, size: 40, color: Colors.white)
              : Image.network(
                  url,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, size: 40, color: Colors.white),
                ),
        );
      },
    );
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

class _ReadOnlyRow extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: SelectableText(value, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
