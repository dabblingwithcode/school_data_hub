import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tag.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';

class UserListCard extends WatchingWidget {
  final UserWithDevices userWithDevices;

  const UserListCard(this.userWithDevices, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());
    final u = userWithDevices.user;
    final info = u.userInfo;
    final devices = userWithDevices.userDevices;

    return CardBox(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Header row: avatar, primary info, credit expand trigger
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _UserAvatar(info: info),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Style.spacing.sm,
                    right: Style.spacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(
                            RoutePaths.adminUsersNew,
                            extra: userWithDevices,
                          );
                        },
                        child: Text(
                          info?.userName ?? 'Unbekannt',
                          style: context.typography.subtitle.bold.withColor(
                            style.colors.foreground,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (info?.fullName != null && info!.fullName!.isNotEmpty)
                        Text(
                          info.fullName!,
                          style: context.typography.body.withColor(
                            style.colors.mutedForeground,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      const Gap(6),
                      _CompactInfoChips(user: u),
                      Gap(Style.spacing.md),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => tileController.toggle(),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Style.spacing.md,
                    right: Style.spacing.md,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Guthaben',
                        style: context.typography.caption.withColor(
                          style.colors.mutedForeground,
                        ),
                      ),
                      Text(
                        u.credit.toString(),
                        style: context.typography.heading.withColor(
                          style.colors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ExpansionBody(
            title: null,
            tileController: tileController,
            widgetList: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Style.spacing.md,
                  vertical: Style.spacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle('Benutzerinfo'),
                    if (info != null) ...[
                      _InfoRow('Kürzel', info.userName ?? '–'),
                      _InfoRow('Name', info.fullName ?? '–'),
                      _InfoRow('E-Mail', info.email ?? '–'),
                      _InfoRow('Erstellt', info.created.formatDateForUser()),
                      const Gap(10),
                    ],
                    const _SectionTitle('Rolle & Zeiten'),
                    _InfoRow('Rolle', u.role.name),
                    _InfoRow('User-ID', '${u.id ?? u.userInfoId}'),
                    _InfoRow('Stunden', '${u.timeUnits}'),
                    _InfoRow('Entlastung', '${u.reliefTimeUnits}'),
                    _InfoRow('Guthaben', '${u.credit}'),
                    _InfoRow('Tester', u.userFlags.isTester ? 'Ja' : 'Nein'),
                    if (u.matrixUserId != null && u.matrixUserId!.isNotEmpty)
                      _InfoRow('Matrix-ID', u.matrixUserId!),
                    if (u.pupilsAuth != null)
                      _InfoRow(
                        'Autorisierte Schüler',
                        '${u.pupilsAuth!.length}',
                      ),
                    const Gap(12),
                    const _SectionTitle('Geräte / Sitzungen'),
                    const Gap(6),
                    if (devices.isEmpty)
                      Text(
                        'Keine Geräte',
                        style: context.typography.bodySmall.withColor(
                          style.colors.mutedForeground,
                        ),
                      )
                    else
                      ...devices.map((d) => _DeviceTile(device: d)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final UserInfo? info;

  const _UserAvatar({this.info});

  String? _resolveImageUrl() {
    final url = info?.imageUrl;
    if (url == null || url.isEmpty) return null;

    return '${di<EnvManager>().activeEnv!.serverUrl}serverpod_cloud_storage?method=file&path=$url';
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final imageUrl = _resolveImageUrl();
    return Padding(
      padding: EdgeInsets.all(Style.spacing.md),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: style.colors.border,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
        onBackgroundImageError: imageUrl != null ? (_, __) {} : null,
        child: imageUrl == null
            ? Icon(Icons.person, size: 20, color: style.colors.background)
            : null,
      ),
    );
  }
}

class _CompactInfoChips extends StatelessWidget {
  final User user;

  const _CompactInfoChips({required this.user});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Wrap(
      spacing: Style.spacing.sm,
      runSpacing: Style.spacing.xs,
      children: [
        Tag(label: 'Rolle: ${user.role.name}', color: style.colors.accent),
        if ((user.userInfo?.email ?? '').isNotEmpty)
          Tag(
            label: 'E-Mail: ${user.userInfo?.email ?? ''}',
            color: style.colors.accent,
          ),
        if (user.matrixUserId != null && user.matrixUserId!.isNotEmpty)
          Tag(
            label: 'Matrix: ${user.matrixUserId!}',
            color: style.colors.accent,
          ),
        Tag(label: 'Stunden: ${user.timeUnits}', color: style.colors.accent),
        Tag(
          label: 'Entlastung: ${user.reliefTimeUnits}',
          color: style.colors.accent,
        ),
        if (user.pupilsAuth != null && user.pupilsAuth!.isNotEmpty)
          Tag(
            label: 'Aut. Kinder: ${user.pupilsAuth!.length}',
            color: style.colors.accent,
          ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(title, style: context.typography.body.bold),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: Style.spacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: context.typography.bodySmall.withColor(
                style.colors.mutedForeground,
              ),
            ),
          ),
          Expanded(child: Text(value, style: context.typography.bodySmall)),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final UserDevice device;

  const _DeviceTile({required this.device});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final displayName = device.deviceName.isNotEmpty
        ? device.deviceName
        : device.deviceId;
    return Padding(
      padding: EdgeInsets.only(bottom: Style.spacing.sm),
      child: Row(
        children: [
          Icon(
            device.isActive ? Icons.devices : Icons.devices_other,
            size: 20,
            color: device.isActive
                ? style.colors.success
                : style.colors.mutedForeground,
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName, style: context.typography.bodySmall.w600),
                Text(
                  'Zuletzt: ${device.lastLogin.formatDateForUser()} · '
                  '${device.isActive ? "Aktiv" : "Inaktiv"}',
                  style: context.typography.caption.withColor(
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
