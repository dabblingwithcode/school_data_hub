import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';

class PupilMiniCard extends StatelessWidget {
  final PupilProxy pupil;
  const PupilMiniCard({required this.pupil, super.key});

  static const double _avatarSize = 60.0;
  static const double _fontSize = 20.0;
  static const double _badgeSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.cardInCardColor,
        border: Border.all(color: AppColors.cardInCardBorderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarImage(pupil: pupil, size: _avatarSize),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_buildNameRow(), const Gap(8), _buildBadgesRow()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameRow() {
    return Row(
      children: [
        Text(
          pupil.firstName,
          style: const TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Gap(6),
        Text(
          pupil.lastName,
          style: const TextStyle(fontSize: _fontSize, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildBadgesRow() {
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
            width: _badgeSize + 4,
            height: _badgeSize + 4,
            decoration: BoxDecoration(
              color: AppColors.afterSchoolCardeColor,
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
            width: _badgeSize + 4,
            height: _badgeSize + 4,
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
                size: _badgeSize + 4,
              ),
            ),
          ),
        ],
        // 5. Support level
        if (pupil.latestSupportLevel != null) ...[
          const Gap(6),
          Container(
            width: _badgeSize + 4,
            height: _badgeSize + 4,
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
                  width: _badgeSize + 4,
                  height: _badgeSize + 4,
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
          Builder(
            builder: (context) => InkWell(
              onTap: () => specialInformationDialog(
                context,
                'Besondere Information',
                pupil.specialInformation!,
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
