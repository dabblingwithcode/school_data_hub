import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

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
    return Column(
      children: [
        if (!isConnected)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null, // Disabled since connection starts automatically
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isProcessing
                        ? 'Stream startet...'
                        : 'Verbindung wird aufgebaut...',
                    style: const TextStyle(color: Colors.white),
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
                backgroundColor: hasActiveTransfers
                    ? Colors.grey
                    : AppColors.cancelButtonColor,
                minimumSize: const Size.fromHeight(55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                hasActiveTransfers
                    ? 'Transfer läuft - bitte warten'
                    : 'STREAM BEENDEN',
                style: const TextStyle(color: Colors.white, fontSize: 17.0),
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
    );
  }
}
