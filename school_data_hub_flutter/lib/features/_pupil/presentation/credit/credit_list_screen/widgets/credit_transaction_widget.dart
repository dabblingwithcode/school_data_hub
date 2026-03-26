import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class CreditTransactionWidget extends StatelessWidget {
  final CreditTransaction transaction;
  const CreditTransactionWidget({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final bool isPositive = transaction.amount >= 0;
    final Color amountColor = isPositive
        ? style.colors.success
        : style.colors.error;

    return Padding(
      padding: EdgeInsets.only(bottom: Style.spacing.sm),
      child: CardBox(
        variant: CardBoxVariant.filledSecondary,
        padding: EdgeInsets.symmetric(
          horizontal: Style.spacing.lg,
          vertical: Style.spacing.md,
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
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                color: amountColor,
                size: 20,
              ),
            ),
            Gap(Style.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy').format(transaction.dateTime),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(2),
                  Text(
                    transaction.sender,
                    style: context.typography.bodySmall.withColor(
                      style.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${isPositive ? '+' : ''}${transaction.amount}',
              style: context.typography.title.bold.withColor(amountColor),
            ),
          ],
        ),
      ),
    );
  }
}
