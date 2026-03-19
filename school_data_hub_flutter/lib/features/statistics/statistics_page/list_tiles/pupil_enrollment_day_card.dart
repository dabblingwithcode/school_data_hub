import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:flutter_it/flutter_it.dart';

class PupilEnrollmentDateCard extends StatelessWidget {
  final PupilProxy passedPupil;
  const PupilEnrollmentDateCard({required this.passedPupil, super.key});

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = passedPupil;

    return CardBox(
      child: Row(
        children: [
          AvatarWithBadges(pupil: pupil, size: 60),
          Expanded(
            child: InkWell(
              onTap: () {
                di<BottomNavManager>().setPupilProfileNavPage(
                  ProfileNavigationState.info.value,
                );
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (ctx) => PupilProfilePage(pupil: pupil),
                  ),
                );
              },
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
                    Text(
                      'Aufnahmedatum: ${pupil.pupilSince.toLocal().formatDateForUser()}',
                      style: context.typography.body.bold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
