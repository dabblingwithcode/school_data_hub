import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class PupilLanguageCard extends StatelessWidget {
  final PupilProxy passedPupil;
  const PupilLanguageCard({required this.passedPupil, super.key});

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = passedPupil;

    return Card(
      color: Colors.white,
      child: Row(
        children: [
          AvatarWithBadges(pupil: pupil, size: 60),
          Expanded(
            child: InkWell(
              onTap: () {
                di<BottomNavManager>().setPupilProfileNavPage(
                  ProfileNavigationState.language.value,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Familiensprache: ${pupil.language}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
