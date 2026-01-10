import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoCard extends WatchingWidget {
  final PupilProxy pupil;
  const SpecialInfoCard(this.pupil, {super.key});
  @override
  Widget build(BuildContext context) {
    final parts = pupil.specialInformation?.split('|') ?? [];
    final info = parts.isNotEmpty
        ? parts[0]
        : (pupil.specialInformation ?? 'keine Infos');
    final createdBy = parts.length > 1 ? parts[1] : null;
    final createdAt = parts.length > 2 ? parts[2] : null;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarWithBadges(pupil: pupil, size: 80),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: InkWell(
                                    onTap: () {
                                      di<FiltersStateManager>().resetFilters();
                                      di<BottomNavManager>()
                                          .setPupilProfileNavPage(0);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              PupilProfilePage(pupil: pupil),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          pupil.firstName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(
                                          pupil.lastName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Gap(5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          const Row(
                            children: [
                              Text('Besondere Informationen:'),
                              Gap(5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 3,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (createdBy != null && createdAt != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Text(
                        '$createdBy, $createdAt',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.withValues(alpha: 0.7),
                        ),
                      ),
                      const Gap(15),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
