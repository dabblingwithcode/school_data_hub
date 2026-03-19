import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class TransferHistoryWidget extends StatelessWidget {
  final List<String> transferHistory;
  final int transferCounter;

  const TransferHistoryWidget({
    super.key,
    required this.transferHistory,
    required this.transferCounter,
  });

  @override
  Widget build(BuildContext context) {
    if (transferHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    final style = Style.of(context);

    return CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: style.colors.info),
              const SizedBox(width: 8),
              Text(
                'Übertragungsverlauf ($transferCounter)',
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...transferHistory
              .take(5) // Show only last 5 entries to avoid overflow
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: style.colors.success,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry,
                          style: context.typography.body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          if (transferHistory.length > 5) ...[
            const SizedBox(height: 8),
            Text(
              'und ${transferHistory.length - 5} weitere...',
              style: context.typography.bodySmall.withColor(style.colors.mutedForeground).copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
