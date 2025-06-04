import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/_credit/credit_list_page/credit_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/_credit/credit_list_page/widgets/dialogues/change_credit_dialog.dart';

class PupilProfileCreditContent extends StatelessWidget {
  final PupilProxy pupil;
  const PupilProfileCreditContent({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: AppPaddings.pupilProfileCardPadding,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(
              Icons.attach_money_rounded,
              color: AppColors.accentColor,
              size: 24,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const CreditListPage(),
                ));
              },
              child: const Text('Guthaben',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  )),
            ),
            const Spacer(),
            Text(
              pupil.credit.toString(),
              style: const TextStyle(
                  color: AppColors.groupColor,
                  fontSize: 60,
                  fontWeight: FontWeight.bold),
            ),
            const Gap(20),
          ]),
          //const Gap(15),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              //margin: const EdgeInsets.only(bottom: 16),
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
              Text(pupil.creditEarned.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold)),
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
          if (pupil.creditTransactions != null)
            ListView.builder(
              padding: const EdgeInsets.only(left: 20, bottom: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pupil.creditTransactions?.length,
              itemBuilder: (BuildContext context, int index) {
                final List<CreditTransaction> pupilCreditHistoryLogs =
                    List.from(pupil.creditTransactions!);
                // order by date latest first
                // pupilCreditHistoryLogs
                //     .sort((a, b) => b.createdAt.compareTo(a.createdAt));
                CreditTransaction creditHistoryLog =
                    pupilCreditHistoryLogs[index];

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      //- TO-DO: change missed class function
                      //- like _changeMissedClassHermannpupilPage
                    },
                    onLongPress: () async {},
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd.MM.yyyy')
                                .format(creditHistoryLog.dateTime)
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Gap(10),
                          const Text('Betrag:'),
                          const Gap(10),
                          Text(
                            creditHistoryLog.amount.toString(),
                            style: TextStyle(
                              color: creditHistoryLog.amount < 0
                                  ? Colors.red
                                  : AppColors.groupColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Gap(10),
                          const Text('von:'),
                          const Gap(10),
                          Text(
                            creditHistoryLog.sender,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ]),
      ),
    );
  }
}
