import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_transactions.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class CreditListCard extends WatchingWidget {
  final PupilProxy pupil;
  const CreditListCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(
      () => CustomExpansionTileController(),
      dispose: (tileController) => tileController.dispose(),
    );

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AvatarWithBadges(pupil: pupil, size: 80),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                di<BottomNavManager>().setPupilProfileNavPage(
                                  2,
                                );
                                Navigator.of(context).push<void>(
                                  MaterialPageRoute<void>(
                                    builder: (ctx) =>
                                        PupilProfilePage(pupil: pupil),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    pupil.firstName,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Gap(5),
                                  Text(
                                    pupil.lastName,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Gap(5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    _CreditEarnedRow(pupil: pupil),
                  ],
                ),
              ),
              const Gap(20),
              _CreditDisplay(pupil: pupil, tileController: tileController),
              const Gap(20),
            ],
          ),
          CustomExpansionTileContent(
            title: null,
            tileController: tileController,
            widgetList: [CreditTransactions(pupil: pupil)],
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.creditEarned] changes.
class _CreditEarnedRow extends WatchingWidget {
  final PupilProxy pupil;

  const _CreditEarnedRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final creditEarned = watchPropertyValue(
      (m) => m.creditEarned,
      target: pupil,
    );
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Text('bisjetzt verdient:'),
                const Gap(10),
                Text(
                  creditEarned.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Rebuilds only when [pupil.credit] changes.
class _CreditDisplay extends WatchingWidget {
  final PupilProxy pupil;
  final CustomExpansionTileController tileController;

  const _CreditDisplay({required this.pupil, required this.tileController});

  @override
  Widget build(BuildContext context) {
    final credit = watchPropertyValue((m) => m.credit, target: pupil);
    return InkWell(
      onTap: () => tileController.toggle(),
      child: Column(
        children: [
          const Gap(20),
          const Text('Credit'),
          Center(
            child: Text(
              credit.toString(),
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
