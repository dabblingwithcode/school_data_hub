import 'package:flutter/material.dart';

enum ReceiverStatus { requested, confirmed, transferring, completed, rejected }

class ReceiverCard extends StatelessWidget {
  final String receiverName;
  final ReceiverStatus status;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final bool isAnyTransferInProgress;

  const ReceiverCard({
    Key? key,
    required this.receiverName,
    required this.status,
    this.onConfirm,
    this.onReject,
    required this.isAnyTransferInProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    receiverName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusIcon(),
              ],
            ),
            const SizedBox(height: 8),
            Text(_buildStatusText()),
            if (status == ReceiverStatus.requested) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: isAnyTransferInProgress ? null : onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Bestätigen',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isAnyTransferInProgress ? null : onReject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Ablehnen',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (status) {
      case ReceiverStatus.requested:
        return const Icon(Icons.help_outline, color: Colors.orange);
      case ReceiverStatus.confirmed:
        return const Icon(Icons.check_circle, color: Colors.green);
      case ReceiverStatus.transferring:
        return const CircularProgressIndicator();
      case ReceiverStatus.completed:
        return const Icon(Icons.done_all, color: Colors.blue);
      case ReceiverStatus.rejected:
        return const Icon(Icons.block, color: Colors.red);
    }
  }

  String _buildStatusText() {
    switch (status) {
      case ReceiverStatus.requested:
        return 'Wartet auf Bestätigung';
      case ReceiverStatus.confirmed:
        return 'Bestätigt - Übertragung vorbereitet';
      case ReceiverStatus.transferring:
        return 'Übertragung läuft...';
      case ReceiverStatus.completed:
        return 'Übertragung abgeschlossen';
      case ReceiverStatus.rejected:
        return 'Abgelehnt';
    }
  }
}
