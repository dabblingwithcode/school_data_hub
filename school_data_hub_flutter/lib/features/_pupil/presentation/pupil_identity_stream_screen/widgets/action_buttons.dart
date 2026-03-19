import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class StreamActionButtons extends StatelessWidget {
  final bool isConnected;
  final bool hasActiveTransfers;
  final bool isProcessing;
  final VoidCallback? onStartStream;
  final VoidCallback? onStopStream;

  const StreamActionButtons({
    super.key,
    required this.isConnected,
    required this.hasActiveTransfers,
    required this.isProcessing,
    this.onStartStream,
    this.onStopStream,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return Column(
      children: [
        if (!isConnected)
          SizedBox(
            width: double.infinity,
            child: Button(
              onPressed: null, // Disabled since connection starts automatically
              loading: true,
              label: isProcessing
                  ? 'Stream startet...'
                  : 'Verbindung wird aufgebaut...',
            ),
          ),
        if (isConnected)
          Button(
            onPressed: hasActiveTransfers ? null : onStopStream,
            variant: ButtonVariant.destructive,
            label: hasActiveTransfers
                ? 'Transfer läuft - bitte warten'
                : 'STREAM BEENDEN',
          ),
        if (hasActiveTransfers) ...[
          const SizedBox(height: 8),
          Text(
            'Stream kann erst beendet werden, wenn alle Übertragungen abgeschlossen sind.',
            style: context.typography.bodySmall.withColor(style.colors.mutedForeground),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
