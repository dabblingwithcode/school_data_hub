import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class PupilLanguageCard extends StatelessWidget {
  final PupilProxy passedPupil;
  const PupilLanguageCard({required this.passedPupil, super.key});

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = passedPupil;

    return CardBox(
      padding: EdgeInsets.zero,
      onTap: () {
        di<BottomNavManager>().setPupilProfileNavPage(
          ProfileNavigationState.language.value,
        );
        context.push(
          RoutePaths.pupilProfilePath(pupil.internalId),
          extra: pupil,
        );
      },
      child: Row(
        children: [
          AvatarWithBadges(pupil: pupil, size: 60),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pupil.firstName} ${pupil.lastName}',
                    style: context.typography.subtitle.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      const Text('Familiensprache:'),
                      const Gap(4),
                      Text(pupil.language, style: context.typography.body.bold),
                    ],
                  ),
                  const Gap(4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
