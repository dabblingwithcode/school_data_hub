import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';

class RejectedRequestsWidget extends StatelessWidget {
  final Set<String> rejectedUsers;
  final VoidCallback? onClearRejected;

  const RejectedRequestsWidget({
    super.key,
    required this.rejectedUsers,
    this.onClearRejected,
  });

  @override
  Widget build(BuildContext context) {
    if (rejectedUsers.isEmpty) {
      return const SizedBox.shrink();
    }

    final style = Style.of(context);

    return CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.block, color: style.colors.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Abgelehnte Anfragen (${rejectedUsers.length})',
                  style: context.typography.subtitle.bold,
                ),
              ),
              if (onClearRejected != null)
                TappableIcon(
                  icon: Icon(Icons.clear_all, color: style.colors.mutedForeground),
                  onPressed: onClearRejected,
                  tooltip: 'Alle abgelehnten Anfragen löschen',
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...rejectedUsers
              .take(5) // Show only last 5 entries to avoid overflow
              .map(
                (userName) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cancel,
                        size: 16,
                        color: style.colors.error,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          userName,
                          style: context.typography.body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          if (rejectedUsers.length > 5) ...[
            const SizedBox(height: 8),
            Text(
              'und ${rejectedUsers.length - 5} weitere...',
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
