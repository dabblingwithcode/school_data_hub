import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/widgets/after_school_care_details.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';

class PupilOgsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilOgsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pupilProfileBackgroundColor,
      ),
      child: Column(
        children: [
          PupilProfileContentSection(
            icon: Icons.access_time,
            title: 'OGS-Informationen',
            child: AfterSchoolCareDetails(pupil: pupil),
          ),
        ],
      ),
    );
  }
}
