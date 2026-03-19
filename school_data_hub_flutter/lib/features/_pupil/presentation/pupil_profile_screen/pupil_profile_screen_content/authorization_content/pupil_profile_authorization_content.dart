import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_screen/authorizations_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen_content/authorization_content/pupil_profile_authorization_content_list.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_content_widgets.dart';

class PupilProfileAuthorizationContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileAuthorizationContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return PupilProfileContentCard(
      icon: Icons.fact_check_rounded,
      iconColor: const Color.fromARGB(255, 109, 109, 109),
      title: 'Einwilligungen',
      onTitleTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (ctx) => const AuthorizationsListScreen(),
          ),
        );
      },
      child: PupilProfileAuthorizationContentList(pupil: pupil),
    );
  }
}
