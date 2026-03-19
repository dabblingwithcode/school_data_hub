import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ConnectionStatus extends StatelessWidget {
  final bool isConnected;
  final bool isProcessing;
  final String statusMessage;

  const ConnectionStatus({
    super.key,
    required this.isConnected,
    required this.isProcessing,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    Color statusColor;
    IconData statusIcon;
    String displayMessage;

    if (isProcessing) {
      statusColor = style.colors.warning;
      statusIcon = Icons.sync;
      displayMessage =
          statusMessage.isNotEmpty ? statusMessage : 'Verarbeitung läuft...';
    } else if (isConnected) {
      statusColor = style.colors.success;
      statusIcon = Icons.wifi;
      displayMessage = statusMessage.isNotEmpty ? statusMessage : 'Verbunden';
    } else {
      statusColor = style.colors.error;
      statusIcon = Icons.wifi_off;
      displayMessage =
          statusMessage.isNotEmpty ? statusMessage : 'Nicht verbunden';
    }

    return CardBox(
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              displayMessage,
              style: context.typography.subtitle.withColor(statusColor),
            ),
          ),
          if (isProcessing)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ),
        ],
      ),
    );
  }
}
