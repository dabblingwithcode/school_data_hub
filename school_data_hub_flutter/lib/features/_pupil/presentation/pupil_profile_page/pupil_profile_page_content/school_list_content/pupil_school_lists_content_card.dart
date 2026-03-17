import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page_content/school_list_content/widgets/pupil_school_lists_content_list.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_content_widgets.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_lists_page/school_lists_page.dart';

class PupilProfileSchoolListsContentCard extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileSchoolListsContentCard({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return PupilProfileContentCard(
      icon: Icons.rule,
      iconColor: const Color.fromARGB(255, 0, 67, 108),
      title: 'Listen',
      onTitleTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (ctx) => const SchoolListsPage()),
        );
      },
      child: PupilSchoolListContentList(pupil: pupil),
    );
  }
}
