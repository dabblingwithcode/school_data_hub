import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/generic_async_action_button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/credit/credit_list_screen/widgets/credit_transaction_widget.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/credit/credit_list_screen/widgets/dialogues/change_credit_dialog.dart';

class CreditTransactions extends WatchingWidget {
  final PupilProxy pupil;
  const CreditTransactions({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final creditTransactions = watchPropertyValue(
      (m) => m.creditTransactions,
      target: pupil,
    );
    return Column(
      children: [
        GenericAsyncActionButton(
          onPressed: () async {
            await changeCreditDialog(context, pupil);
          },
          title: "GUTHABEN ÄNDERN",
          buttonType: ButtonType.accept,
        ),
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
        Gap(Style.spacing.md),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: Style.spacing.xl),
              child: Text(
                'Verlauf',
                style: context.typography.title.withColor(
                  style.colors.foreground,
                ),
              ),
            ),
          ],
        ),
        Gap(Style.spacing.md),
        if (creditTransactions == null)
          Padding(
            padding: EdgeInsets.only(left: Style.spacing.xl),
            child: Text(
              'Keine Transaktionen gefunden',
              style: context.typography.title.withColor(
                style.colors.foreground,
              ),
            ),
          )
        else ...[
          for (final tx in List<CreditTransaction>.from(
            creditTransactions,
          )..sort((a, b) => b.dateTime.compareTo(a.dateTime)))
            CreditTransactionWidget(transaction: tx),
        ],
      ],
    );
  }
}
