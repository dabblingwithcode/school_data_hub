import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/create_user_page.dart';

class UserListCard extends WatchingWidget {
  final UserWithDevices userWithDevices;

  const UserListCard(this.userWithDevices, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());
    final u = userWithDevices.user;
    final info = u.userInfo;
    final devices = userWithDevices.userDevices;

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
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
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (ctx) => CreateOrEditUserPage(
                                userWithDevices: userWithDevices,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          info?.userName ?? 'Unbekannt',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (info?.fullName != null && info!.fullName!.isNotEmpty)
                        Text(
                          info.fullName!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      const Gap(6),
                      _CompactInfoChips(user: u),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => tileController.toggle(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: Column(
                    children: [
                      Text(
                        'Guthaben',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        u.credit.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CustomExpansionTileContent(
            title: null,
            tileController: tileController,
            widgetList: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle('Benutzerinfo'),
                    if (info != null) ...[
                      _InfoRow('Kürzel', info.userName ?? '–'),
                      _InfoRow('Name', info.fullName ?? '–'),
                      _InfoRow('E-Mail', info.email ?? '–'),
                      _InfoRow('Erstellt', info.created.formatDateForUser()),
                      const Gap(10),
                    ],
                    _SectionTitle('Rolle & Zeiten'),
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
                    _SectionTitle('Geräte / Sitzungen'),
                    const Gap(6),
                    if (devices.isEmpty)
                      Text(
                        'Keine Geräte',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
  final dynamic info;

  const _UserAvatar({this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: (info?.imageUrl?.isNotEmpty ?? false)
            ? Image.network(
                info!.imageUrl!,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, size: 36, color: Colors.white),
              )
            : const Icon(Icons.person, size: 36, color: Colors.white),
      ),
    );
  }
}

class _CompactInfoChips extends StatelessWidget {
  final User user;

  const _CompactInfoChips({required this.user});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        _Chip(label: 'Rolle', value: user.role.name),
        if ((user.userInfo?.email ?? '').isNotEmpty)
          _Chip(label: 'E-Mail', value: user.userInfo?.email ?? ''),
        if (user.matrixUserId != null && user.matrixUserId!.isNotEmpty)
          _Chip(label: 'Matrix', value: user.matrixUserId!),
        _Chip(label: 'Stunden', value: '${user.timeUnits}'),
        _Chip(label: 'Entlastung', value: '${user.reliefTimeUnits}'),
        if (user.pupilsAuth != null && user.pupilsAuth!.isNotEmpty)
          _Chip(label: 'Aut. Kinder', value: '${user.pupilsAuth!.length}'),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String value;

  const _Chip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 11, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
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
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
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
    final displayName = device.deviceName.isNotEmpty
        ? device.deviceName
        : device.deviceId;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            device.isActive ? Icons.devices : Icons.devices_other,
            size: 20,
            color: device.isActive ? Colors.green : Colors.grey,
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Zuletzt: ${device.lastLogin.formatDateForUser()} · '
                  '${device.isActive ? "Aktiv" : "Inaktiv"}',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
