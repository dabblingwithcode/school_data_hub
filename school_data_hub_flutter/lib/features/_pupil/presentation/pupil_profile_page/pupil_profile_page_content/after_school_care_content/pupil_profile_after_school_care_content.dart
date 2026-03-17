import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/widgets/after_school_care_details.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_content_widgets.dart';

class PupilProfileAfterSchoolCareContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileAfterSchoolCareContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return PupilProfileContentCard(
      icon: Icons.access_time,
      iconColor: const Color.fromARGB(255, 41, 56, 218),
      title: 'OGS-Informationen',
      child: AfterSchoolCareDetails(pupil: pupil),
    );
  }
}
