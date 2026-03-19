import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/env/utils/env_utils.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/pupil_set_avatar.dart'
    show CropAvatarView;
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/change_password/change_password_screen.dart';

class SettingsAccountSection extends WatchingWidget {
  const SettingsAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    di.allReady();

    final user = watchPropertyValue((HubSessionManager x) => x.user)!;
    final info = user.userInfo!;
    final username = info.userName!;
    final fullName = info.fullName ?? '';
    final email = info.email ?? '';
    final imageUrl = info.imageUrl;
    final flags = user.userFlags;
    final isAdmin = di<HubSessionManager>().isAdmin;
    final int userCredit = di<HubSessionManager>().userCredit ?? 0;
    final role = user.role.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Konto',
            style: context.typography.title,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Style.spacing.md,
            vertical: Style.spacing.xs,
          ),
          child: CardBox(
            padding: EdgeInsets.all(Style.spacing.sm),
            child: Column(
              children: [
                _UserProfileHeader(
                  username: username,
                  fullName: fullName,
                  imageUrl: imageUrl,
                ),
                if (email.isNotEmpty)
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text('E-Mail'),
                    subtitle: Text(email),
                  ),
                ListTile(
                  leading: const Icon(Icons.badge_outlined),
                  title: const Text('Rolle'),
                  subtitle: Text(role),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: const Text('Stunden'),
                  subtitle: Text('${user.timeUnits}'),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time_filled),
                  title: const Text('Entlastungsstunden'),
                  subtitle: Text('${user.reliefTimeUnits}'),
                ),
                ListTile(
                  leading: const Icon(Icons.attach_money_rounded),
                  title: const Text('Guthaben'),
                  subtitle: Text(
                    userCredit.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.flag_rounded),
                  title: const Text('Nutzungsbedingungen'),
                  trailing: Icon(
                    flags.confirmedTermsOfUse
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: flags.confirmedTermsOfUse
                        ? style.colors.success
                        : style.colors.mutedForeground,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.flag_rounded),
                  title: const Text('Datenschutz'),
                  trailing: Icon(
                    flags.confirmedPrivacyPolicy
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: flags.confirmedPrivacyPolicy
                        ? style.colors.success
                        : style.colors.mutedForeground,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.flag_rounded),
                  title: const Text('Passwort geändert'),
                  trailing: Icon(
                    flags.changedPassword
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: flags.changedPassword
                        ? style.colors.success
                        : style.colors.mutedForeground,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.flag_rounded),
                  title: const Text('Erste Schritte'),
                  trailing: Icon(
                    flags.madeFirstSteps
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: flags.madeFirstSteps
                        ? style.colors.success
                        : style.colors.mutedForeground,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.build_rounded),
                  title: Text(
                    'Tester: ${flags.isTester ? "Ja" : "Nein"}  |  Admin: ${isAdmin ? "Ja" : "Nein"}',
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (ctx) => const UserChangePasswordScreen(),
                      ),
                    );
                  },
                  leading: const Icon(Icons.password_rounded),
                  title: const Text('Passwort ändern'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                _UserDevicesSection(userInfoId: info.id!),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UserDevicesSection extends WatchingWidget {
  final int userInfoId;
  const _UserDevicesSection({required this.userInfoId});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final userManager = di<UserManager>();
    final usersWithDevices = watchValue((UserManager x) => x.usersWithDevices);
    final devices = usersWithDevices
        .where((uwd) => uwd.user.userInfoId == userInfoId)
        .expand((uwd) => uwd.userDevices)
        .toList();

    final currentDeviceIdSnapshot = createOnceAsync(
      () async => (await EnvUtils.getDeviceNameAndId()).deviceId,
      initialValue: null,
    );
    final currentDeviceId = currentDeviceIdSnapshot.data;

    if (devices.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Style.spacing.lg,
            vertical: Style.spacing.sm,
          ),
          child: Text(
            'Geräte / Sitzungen',
            style: context.typography.bodySmall.bold.withColor(
              style.colors.accent,
            ),
          ),
        ),
        ...devices.map((d) {
          final isCurrentDevice =
              currentDeviceId != null && d.deviceId == currentDeviceId;
          return ListTile(
            onLongPress: isCurrentDevice
                ? null
                : () async {
                    final confirm = await confirmationDialog(
                      context: context,
                      title: 'Gerät löschen',
                      message:
                          'Gerät und zugehörigen Auth-Key wirklich löschen?',
                    );
                    if (confirm == true) {
                      await userManager.deleteDevice(d);
                    }
                  },
            leading: Icon(
              isCurrentDevice
                  ? Icons.smartphone
                  : d.isActive
                  ? Icons.devices
                  : Icons.devices_other,
              color: isCurrentDevice
                  ? AppColors.interactiveColor
                  : d.isActive
                  ? style.colors.success
                  : style.colors.mutedForeground,
            ),
            title: Text(
              d.deviceName.isNotEmpty ? d.deviceName : d.deviceId,
              style: context.typography.bodySmall.w600,
            ),
            subtitle: Text(
              isCurrentDevice
                  ? 'Dieses Gerät · ${d.isActive ? "Aktiv" : "Inaktiv"}'
                  : 'Zuletzt: ${d.lastLogin.formatDateForUser()} · ${d.isActive ? "Aktiv" : "Inaktiv"}',
              style: context.typography.caption.withColor(
                style.colors.mutedForeground,
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _UserProfileHeader extends StatefulWidget {
  final String username;
  final String fullName;
  final String? imageUrl;

  const _UserProfileHeader({
    required this.username,
    required this.fullName,
    this.imageUrl,
  });

  @override
  State<_UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<_UserProfileHeader> {
  bool _uploading = false;

  String? _resolveImageUrl() {
    final url = widget.imageUrl;
    if (url == null || url.isEmpty) return null;
    return '${di<EnvManager>().activeEnv!.serverUrl}serverpod_cloud_storage?method=file&path=$url';
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

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final resolvedUrl = _resolveImageUrl();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Style.spacing.sm,
        horizontal: Style.spacing.lg,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _uploading ? null : _pickAndUploadImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: style.colors.accent,
                  backgroundImage: resolvedUrl != null
                      ? NetworkImage(resolvedUrl)
                      : null,
                  onBackgroundImageError: resolvedUrl != null
                      ? (_, __) {}
                      : null,
                  child: _uploading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: style.colors.background,
                            strokeWidth: 2,
                          ),
                        )
                      : resolvedUrl == null
                      ? Icon(
                          Icons.person,
                          size: 30,
                          color: style.colors.background,
                        )
                      : null,
                ),
                if (!_uploading)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(Style.spacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.interactiveColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 12,
                        color: style.colors.background,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: Style.spacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: context.typography.title,
                ),
                if (widget.fullName.isNotEmpty)
                  Text(
                    widget.fullName,
                    style: context.typography.body.withColor(
                      style.colors.mutedForeground,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
