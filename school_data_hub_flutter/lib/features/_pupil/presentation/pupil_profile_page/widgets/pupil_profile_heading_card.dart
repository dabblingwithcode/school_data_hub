import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';

class PupilProfileHeadingCard extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileHeadingCard({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 2, right: 2),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarImage(pupil: pupil, size: 80),
          const Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _PupilNameRow(pupil: pupil),
              const Gap(8),
              _BadgesRow(pupil: pupil),
            ],
          ),
        ],
      ),
    );
  }
}

class _PupilNameRow extends WatchingWidget {
  final PupilProxy pupil;
  const _PupilNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Gap(6),
        Text(
          lastName,
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
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
              color: AppColors.ogsColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'OGS',
                style: TextStyle(
                  color: Colors.white,
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
                  ? Colors.green
                  : Colors.grey,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.language_rounded,
                color: Colors.white,
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
              color: AppColors.accentColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'FE\n${pupil.latestSupportLevel!.level}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
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
                    color: AppColors.groupColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      need.replaceAll('ESE', 'ES'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
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
          InkWell(
            onTap: () => specialInformationDialog(
              context,
              'Besondere Information',
              pupil.specialInformation!,
            ),
            child: Container(
              width: _badgeSize,
              height: _badgeSize,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_rounded,
                size: _badgeSize,
                color: Color.fromARGB(255, 6, 92, 163),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
