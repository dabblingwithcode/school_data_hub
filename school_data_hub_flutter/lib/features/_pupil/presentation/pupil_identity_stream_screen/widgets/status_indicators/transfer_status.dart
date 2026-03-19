import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class TransferStatus extends StatelessWidget {
  final bool isTransmitting;
  final int transferCount;

  const TransferStatus({
    super.key,
    required this.isTransmitting,
    required this.transferCount,
  });

  @override
  Widget build(BuildContext context) {
    if (!isTransmitting && transferCount == 0) {
      return const SizedBox.shrink();
    }

    final style = Style.of(context);

    return CardBox(
      child: Column(
        children: [
          if (isTransmitting) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Text(
                  'Übertragung läuft...',
                  style: context.typography.subtitle,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          if (transferCount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: style.colors.success, size: 20),
                const SizedBox(width: 8),
                Text(
                  '$transferCount Übertragung${transferCount == 1 ? '' : 'en'} abgeschlossen',
                  style: context.typography.body.w500.withColor(style.colors.success),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
