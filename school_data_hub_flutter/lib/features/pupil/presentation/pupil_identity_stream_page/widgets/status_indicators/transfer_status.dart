import 'package:flutter/material.dart';

class TransferStatus extends StatelessWidget {
  final bool isTransmitting;
  final int transferCount;

  const TransferStatus({
    Key? key,
    required this.isTransmitting,
    required this.transferCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isTransmitting && transferCount == 0) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (isTransmitting) ...[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text(
                    'Übertragung läuft...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (transferCount > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '$transferCount Übertragung${transferCount == 1 ? '' : 'en'} abgeschlossen',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
