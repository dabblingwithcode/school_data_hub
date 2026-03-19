import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter_it/flutter_it.dart';

class FamilyLanguageLessonsCard extends WatchingWidget {
  final PupilProxy pupil;
  const FamilyLanguageLessonsCard(this.pupil, {super.key});
  @override
  Widget build(BuildContext context) {
    final mainMenuBottomNavManager = di<BottomNavManager>();
    final filterStateManager = di<FiltersStateManager>();
    return CardBox(
      padding: const EdgeInsets.all(4.0),
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
                const Gap(16),
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
                                  child: GestureDetector(
                                    onTap: () {
                                      filterStateManager.resetFilters();
                                      mainMenuBottomNavManager
                                          .setPupilProfileNavPage(1);
                                      context.push(
                                        RoutePaths.pupilProfilePath(pupil.internalId),
                                        extra: pupil,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          pupil.firstName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style:
                                              context.typography.subtitle.bold,
                                        ),
                                        const Gap(4),
                                        Text(
                                          pupil.lastName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: context.typography.subtitle,
                                        ),
                                        const Gap(4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Herkunftssprache:'),
                              const Gap(12),
                              Text(
                                pupil.language.isNotEmpty
                                    ? pupil.language
                                    : 'keine Angabe',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 3,
                                style: context.typography.subtitle.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Angemeldet am:'),
                    const Gap(12),
                    Text(
                      pupil.familyLanguageLessonsSince != null
                          ? pupil.familyLanguageLessonsSince!
                                .formatDateForUser()
                          : 'keine Angabe',
                      style: context.typography.subtitle.bold,
                    ),
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
