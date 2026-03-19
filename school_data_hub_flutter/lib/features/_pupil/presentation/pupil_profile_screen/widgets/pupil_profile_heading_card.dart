import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';

class PupilProfileHeadingCard extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileHeadingCard({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final double expandedHeight = settings?.maxExtent ?? 140;
        final double collapsedHeight = settings?.minExtent ?? 70;
        final double currentHeight = settings?.currentExtent ?? expandedHeight;
        final double t =
            ((currentHeight - collapsedHeight) /
                    (expandedHeight - collapsedHeight))
                .clamp(0.0, 1.0);

        final double avatarSize = 40 + (40 * t); // 40 collapsed, 80 expanded
        final double fontSize = 16 + (4 * t); // 16 collapsed, 20 expanded

        final style = Style.of(context);
        return Container(
          padding: EdgeInsets.all(Style.spacing.md),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: style.colors.accent,
            borderRadius: BorderRadius.circular(Style.radii.medium),
          ),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(Style.spacing.xs),
                AvatarImage(pupil: pupil, size: avatarSize),
                Gap(Style.spacing.md),
                Expanded(
                  child: ClipRect(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _PupilNameRow(pupil: pupil, fontSize: fontSize, t: t),
                        if (t > 0.3) ...[
                          const Gap(8),
                          Opacity(
                            opacity: ((t - 0.3) / 0.7).clamp(0.0, 1.0),
                            child: _BadgesRow(pupil: pupil),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PupilNameRow extends WatchingWidget {
  final PupilProxy pupil;
  final double fontSize;
  final double t;
  const _PupilNameRow({
    required this.pupil,
    required this.fontSize,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    final style = Style.of(context);
    return Row(
      children: [
        Text(
          firstName,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: style.colors.background,
          ),
        ),
        const Gap(6),
        Text(
          lastName,
          style: TextStyle(fontSize: fontSize, color: style.colors.background),
        ),
        Opacity(
          opacity: ((0.3 - t) / 0.3).clamp(0.0, 1.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(8),
              GroupBadgeContainer(pupil: pupil, badgeSize: 24),
              const Gap(4),
              SchoolGradeBadgeContainer(pupil: pupil, badgeSize: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _BadgesRow extends WatchingWidget {
  static const double _badgeSize = 30.0;

  final PupilProxy pupil;
  const _BadgesRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final style = Style.of(context);
    return Row(
      children: [
        // 1. Learning group
        GroupBadgeContainer(pupil: pupil, badgeSize: _badgeSize),
        const Gap(6),
        // 2. School grade
        SchoolGradeBadgeContainer(pupil: pupil, badgeSize: _badgeSize),
        // 3. After school care
        if (pupil.afterSchoolCare != null) ...[
          const Gap(6),
          Container(
            width: _badgeSize,
            height: _badgeSize,
            decoration: BoxDecoration(
              color: style.colors.ogsColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'OGS',
                style: TextStyle(
                  color: style.colors.background,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        // 4. Migration support
        if (pupil.migrationSupportEnds != null) ...[
          const Gap(6),
          Container(
            width: _badgeSize,
            height: _badgeSize,
            decoration: BoxDecoration(
              color:
                  PupilProxyHelper.hasLanguageSupport(
                    pupil.migrationSupportEnds,
                  )
                  ? style.colors.success
                  : style.colors.mutedForeground,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.language_rounded,
                color: style.colors.background,
                size: 18,
              ),
            ),
          ),
        ],
        // 5. Support level
        if (pupil.latestSupportLevel != null) ...[
          const Gap(6),
          Container(
            width: _badgeSize,
            height: _badgeSize,
            decoration: BoxDecoration(
              color: style.colors.warning,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'FE\n${pupil.latestSupportLevel!.level}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: style.colors.background,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ),
          ),
        ],
        // 6. Special needs (one badge per entry)
        if (pupil.specialNeeds != null && pupil.specialNeeds!.isNotEmpty)
          ...pupil.specialNeeds!.map(
            (need) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(6),
                Container(
                  width: _badgeSize,
                  height: _badgeSize,
                  decoration: BoxDecoration(
                    color: style.colors.groupColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      need.replaceAll('ESE', 'ES'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: style.colors.background,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        // 7. Special information
        if (pupil.specialInformation != null) ...[
          const Gap(6),
          GestureDetector(
            onTap: () => specialInformationDialog(
              context,
              'Besondere Information',
              pupil.specialInformation!,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: style.colors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_rounded,
                size: _badgeSize + 4,
                color: Color.fromARGB(255, 6, 92, 163),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
