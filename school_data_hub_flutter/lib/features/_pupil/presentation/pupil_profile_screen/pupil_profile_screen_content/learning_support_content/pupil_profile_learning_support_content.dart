import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/learning_support_content/pupil_profile_learning_support_content_list.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_content_widgets.dart';

class PupilProfileLearningSupportContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileLearningSupportContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return PupilProfileContentCard(
      icon: Icons.support_rounded,
      iconColor: const Color.fromARGB(255, 241, 70, 27),
      title: 'Förderung',
      onTitleTap: () {
        context.push(RoutePaths.pupilLearningSupport);
      },
      child: PupilProfileLearningSupportContentList(pupil: pupil),
    );
  }
}
