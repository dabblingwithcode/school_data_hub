import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/school_list_content/widgets/pupil_school_lists_content_list.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_page/school_lists_page.dart';

class PupilSchoolListsContentCard extends StatelessWidget {
  final PupilProxy pupil;
  const PupilSchoolListsContentCard({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pupilProfileBackgroundColor,
      ),
      child: Column(
        children: [
          PupilProfileContentSection(
            icon: Icons.rule,
            title: 'Listen',
            onTitleTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const SchoolListsPage()),
              );
            },
            child: PupilSchoolListContentList(pupil: pupil),
          ),
        ],
      ),
    );
  }
}
