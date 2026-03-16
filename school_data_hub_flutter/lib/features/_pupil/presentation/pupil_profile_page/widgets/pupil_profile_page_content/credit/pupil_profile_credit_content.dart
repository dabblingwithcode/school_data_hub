import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/credit_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/dialogues/change_credit_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/widgets/pupil_profile_content_widgets.dart';

class PupilProfileCreditContent extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileCreditContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final credit = watchPropertyValue((x) => x.credit, target: pupil);
    final creditTransactions = watchPropertyValue(
      (x) => x.creditTransactions,
      target: pupil,
    );
    return PupilProfileContentCard(
      icon: Icons.attach_money_rounded,
      title: 'Guthaben',
      onTitleTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (ctx) => const CreditListPage()),
        );
      },
      headerTrailing: Row(
        children: [
          Text(
            credit.toString(),
            style: TextStyle(
              color: AppColors.groupColor,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(20),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: ElevatedButton(
                style: AppStyles.successButtonStyle,
                onPressed: () async {
                  changeCreditDialog(context, pupil);
                },
                child: const Text(
                  "GUTHABEN ÄNDERN",
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Insgesamt verdient:',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
              const Gap(5),
              Text(
                pupil.creditEarned.toString(),
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(10),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  'Verlauf',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          if (creditTransactions != null)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: creditTransactions.length,
              itemBuilder: (BuildContext context, int index) {
                final List<CreditTransaction> pupilCreditHistoryLogs =
                    List.from(pupil.creditTransactions!);
                final CreditTransaction tx = pupilCreditHistoryLogs[index];
                final bool isPositive = tx.amount >= 0;
                final Color amountColor = isPositive
                    ? Colors.green.shade700
                    : Colors.red;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.cardInCardColor),
                  ),
                  color: AppColors.cardInCardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: amountColor.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isPositive
                                ? Icons.arrow_downward_rounded
                                : Icons.arrow_upward_rounded,
                            color: amountColor,
                            size: 20,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd.MM.yyyy').format(tx.dateTime),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Gap(2),
                              Text(
                                tx.sender,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${isPositive ? '+' : ''}${tx.amount}',
                          style: TextStyle(
                            color: amountColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
