import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorization_pupils_page/widgets/pupil_authorizations_content_list.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_page/authorizations_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilAuthorizationsContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilAuthorizationsContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: AppPaddings.pupilProfileCardPadding,
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Icon(
              Icons.fact_check_rounded,
              color: AppColors.backgroundColor,
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const AuthorizationsListPage(),
                ));
              },
              child: const Text('Einwilligungen',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  )),
            )
          ]),
          const Gap(15),
          PupilAuthorizationsContentList(pupil: pupil),
        ]),
      ),
    );
  }
}
