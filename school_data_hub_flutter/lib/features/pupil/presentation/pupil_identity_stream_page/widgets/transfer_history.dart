import 'package:flutter/material.dart';

class TransferHistoryWidget extends StatelessWidget {
  final List<String> transferHistory;
  final int transferCounter;

  const TransferHistoryWidget({
    Key? key,
    required this.transferHistory,
    required this.transferCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transferHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Übertragungsverlauf ($transferCounter)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                        const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            if (transferHistory.length > 5) ...[
              const SizedBox(height: 8),
              Text(
                'und ${transferHistory.length - 5} weitere...',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
