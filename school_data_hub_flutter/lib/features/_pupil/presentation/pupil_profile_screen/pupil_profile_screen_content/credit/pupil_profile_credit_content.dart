import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/credit/credit_list_screen/widgets/credit_transaction_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/credit/credit_list_screen/widgets/dialogues/change_credit_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_content_widgets.dart';

class PupilProfileCreditContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileCreditContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final credit = watchPropertyValue((x) => x.credit, target: pupil);
    final creditTransactions = watchPropertyValue(
      (x) => x.creditTransactions,
      target: pupil,
    );
    return PupilProfileContentCard(
      icon: Icons.attach_money_rounded,
      iconColor: const Color.fromARGB(255, 231, 227, 24),
      title: 'Guthaben',
      onTitleTap: () {
        context.push(RoutePaths.pupilCredit);
      },
      headerTrailing: Row(
        children: [
          Text(
            credit.toString(),
            style: TextStyle(
              color: style.colors.groupColor,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(Style.spacing.xl),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Insgesamt verdient:',
                style: context.typography.title,
                textAlign: TextAlign.left,
              ),
              Gap(Style.spacing.xs),
              Text(
                pupil.creditEarned.toString(),
                style: context.typography.title.bold,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Style.spacing.md),
            child: Button(
              variant: ButtonVariant.primary,
              onPressed: () async {
                changeCreditDialog(context, pupil);
              },
              label: 'GUTHABEN ÄNDERN',
            ),
          ),

          Gap(Style.spacing.md),
          const PupilProfileContentSectionHeader(
            icon: Icons.history_rounded,
            title: 'Verlauf',
          ),

          Gap(Style.spacing.md),
          if (creditTransactions != null)
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: creditTransactions.length,
              itemBuilder: (BuildContext context, int index) {
                return CreditTransactionWidget(
                  transaction: creditTransactions[index],
                );
              },
            ),
        ],
      ),
    );
  }
}
