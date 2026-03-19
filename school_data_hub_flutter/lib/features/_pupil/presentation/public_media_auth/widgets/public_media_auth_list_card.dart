import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';

class PublicMediaAuthListCard extends WatchingWidget {
  final PupilProxy pupil;
  const PublicMediaAuthListCard({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final publicMediaAuth = watchPropertyValue(
      (m) => m.publicMediaAuth,
      target: pupil,
    );

    return CardBox(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      onTap: () {
        di<BottomNavManager>().setPupilProfileNavPage(
          ProfileNavigationState.info.value,
        );
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (ctx) => PupilProfilePage(pupil: pupil),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarWithBadges(pupil: pupil, size: 80),
          const Gap(12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NameRow(pupil: pupil),
                const Gap(8),
                _PublicMediaAuthSummary(auth: publicMediaAuth),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _NameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName =
        watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName =
        watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: context.typography.subtitle.bold,
        ),
        const Gap(4),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: context.typography.subtitle,
        ),
      ],
    );
  }
}

class _PublicMediaAuthSummary extends StatelessWidget {
  final PublicMediaAuth auth;

  const _PublicMediaAuthSummary({required this.auth});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        _Chip(label: 'Gruppe Web', value: auth.groupPicturesOnWebsite),
        _Chip(label: 'Gruppe Presse', value: auth.groupPicturesInPress),
        _Chip(label: 'Porträt Web', value: auth.portraitPicturesOnWebsite),
        _Chip(label: 'Porträt Presse', value: auth.portraitPicturesInPress),
        _Chip(label: 'Name Web', value: auth.nameOnWebsite),
        _Chip(label: 'Name Presse', value: auth.nameInPress),
        _Chip(label: 'Video Web', value: auth.videoOnWebsite),
        _Chip(label: 'Video Presse', value: auth.videoInPress),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool value;

  const _Chip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: value
            ? style.colors.accent.withValues(alpha: 0.15)
            : style.colors.mutedForeground.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: value
              ? style.colors.accent.withValues(alpha: 0.3)
              : style.colors.mutedForeground.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        '$label: ${value ? 'ja' : 'nein'}',
        style: TextStyle(
          fontSize: 11,
          color: value ? style.colors.accent : style.colors.mutedForeground,
          fontWeight: value ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
