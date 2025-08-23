import 'package:flutter/material.dart';

class RejectedRequestsWidget extends StatelessWidget {
  final Set<String> rejectedUsers;
  final VoidCallback? onClearRejected;

  const RejectedRequestsWidget({
    Key? key,
    required this.rejectedUsers,
    this.onClearRejected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rejectedUsers.isEmpty) {
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
                const Icon(Icons.block, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Abgelehnte Anfragen (${rejectedUsers.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onClearRejected != null)
                  IconButton(
                    icon: const Icon(Icons.clear_all, color: Colors.grey),
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
                        const Icon(
                          Icons.cancel,
                          size: 16,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            userName,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            if (rejectedUsers.length > 5) ...[
              const SizedBox(height: 8),
              Text(
                'und ${rejectedUsers.length - 5} weitere...',
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
