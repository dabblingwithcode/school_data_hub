import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/learning_support_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/learning_support_content/pupil_profile_learning_support_content_list.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';

class PupilProfileLearningSupportContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileLearningSupportContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pupilProfileBackgroundColor,
      ),
      child: Column(
        children: [
          PupilProfileContentSection(
            icon: Icons.support_rounded,
            title: 'Förderung',
            onTitleTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const LearningSupportListPage(),
                ),
              );
            },
            child: PupilProfileLearningSupportContentList(pupil: pupil),
          ),
        ],
      ),
    );
  }
}
