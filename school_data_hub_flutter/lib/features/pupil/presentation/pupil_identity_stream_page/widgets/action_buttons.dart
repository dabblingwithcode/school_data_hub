import 'package:flutter/material.dart';

class StreamActionButtons extends StatelessWidget {
  final bool isConnected;
  final bool hasActiveTransfers;
  final bool isProcessing;
  final VoidCallback? onStartStream;
  final VoidCallback? onStopStream;

  const StreamActionButtons({
    Key? key,
    required this.isConnected,
    required this.hasActiveTransfers,
    required this.isProcessing,
    this.onStartStream,
    this.onStopStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (!isConnected)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    null, // Disabled since connection starts automatically
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      isProcessing
                          ? 'Stream startet...'
                          : 'Verbindung wird aufgebaut...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          if (isConnected)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: hasActiveTransfers ? null : onStopStream,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      hasActiveTransfers ? Colors.grey : Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  hasActiveTransfers
                      ? 'Transfer läuft - bitte warten'
                      : 'Stream beenden',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          if (hasActiveTransfers) ...[
            const SizedBox(height: 8),
            const Text(
              'Stream kann erst beendet werden, wenn alle Übertragungen abgeschlossen sind.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
