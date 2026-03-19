import 'package:flutter/widgets.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Reusable row layout: [Avatar | Name + content | trailing].
///
/// Used inside Card widgets across features. Does NOT include the Card itself —
/// wrap it yourself so you can control Card color, elevation, margin, and
/// optional expandable body below.
class PupilCardRow extends StatelessWidget {
  final PupilProxy pupil;

  /// Widgets shown below the name row (feature-specific metadata).
  final List<Widget> contentRows;

  /// Widget(s) on the right side (dropdowns, badges, images).
  final Widget? trailing;

  /// Called when the name is tapped. Typically navigates to pupil profile.
  final VoidCallback? onNameTap;

  /// Called when the name is long-pressed.
  final VoidCallback? onNameLongPress;

  /// Avatar size. Default 80.
  final double avatarSize;

  const PupilCardRow({
    required this.pupil,
    this.contentRows = const [],
    this.trailing,
    this.onNameTap,
    this.onNameLongPress,
    this.avatarSize = 80,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarWithBadges(pupil: pupil, size: avatarSize),
        const Gap(5),
        Expanded(
          child: GestureDetector(
            onTap: onNameTap,
            onLongPress: onNameLongPress,
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(12),
                _PupilNameRow(pupil: pupil),
                ...contentRows,
                const Gap(5),
              ],
            ),
          ),
        ),
        if (trailing != null) ...[
          trailing!,
          const Gap(5),
        ],
      ],
    );
  }
}

/// First name (bold) + last name (normal), watching only name changes.
class _PupilNameRow extends WatchingWidget {
  final PupilProxy pupil;
  const _PupilNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue(
      (PupilProxy p) => p.firstName,
      target: pupil,
    );
    final lastName = watchPropertyValue(
      (PupilProxy p) => p.lastName,
      target: pupil,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(
            firstName,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: context.typography.subtitle.bold,
          ),
          const Gap(5),
          Text(
            lastName,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: context.typography.subtitle,
          ),
        ],
      ),
    );
  }
}
