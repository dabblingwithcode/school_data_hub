import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_page/authorizations_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/authorization_content/pupil_profile_authorization_content_list.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';

class PupilProfileAuthorizationContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileAuthorizationContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pupilProfileBackgroundColor,
      ),
      child: Column(
        children: [
          PupilProfileContentSection(
            icon: Icons.fact_check_rounded,
            title: 'Einwilligungen',
            onTitleTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AuthorizationsListPage(),
                ),
              );
            },
            child: PupilProfileAuthorizationContentList(pupil: pupil),
          ),
        ],
      ),
    );
  }
}
