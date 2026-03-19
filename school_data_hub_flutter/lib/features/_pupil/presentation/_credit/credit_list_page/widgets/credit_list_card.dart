import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_transactions.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class CreditListCard extends WatchingWidget {
  final PupilProxy pupil;
  const CreditListCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(
      () => ExpansionController(),
      dispose: (tileController) => tileController.dispose(),
    );

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
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
                    Gap(Style.spacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
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
                                    style: context.typography.title.withColor(
                                      Style.of(context).colors.foreground,
                                    ).bold,
                                  ),
                                  Gap(Style.spacing.xs),
                                  Text(
                                    pupil.lastName,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                    style: context.typography.title.withColor(
                                      Style.of(context).colors.foreground,
                                    ),
                                  ),
                                  Gap(Style.spacing.xs),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(Style.spacing.xs),
                    _CreditEarnedRow(pupil: pupil),
                  ],
                ),
              ),
              Gap(Style.spacing.xl),
              _CreditDisplay(pupil: pupil, tileController: tileController),
              Gap(Style.spacing.xl),
            ],
          ),
          ExpansionBody(
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
                Gap(Style.spacing.md),
                Text(
                  creditEarned.toString(),
                  style: context.typography.title,
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
  final ExpansionController tileController;

  const _CreditDisplay({required this.pupil, required this.tileController});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final credit = watchPropertyValue((m) => m.credit, target: pupil);
    return GestureDetector(
      onTap: () => tileController.toggle(),
      child: Column(
        children: [
          Gap(Style.spacing.xl),
          const Text('Credit'),
          Center(
            child: Text(
              credit.toString(),
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: style.colors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
