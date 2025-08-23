import 'package:flutter/material.dart';

class ConnectionStatus extends StatelessWidget {
  final bool isConnected;
  final bool isProcessing;
  final String statusMessage;

  const ConnectionStatus({
    Key? key,
    required this.isConnected,
    required this.isProcessing,
    required this.statusMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    String displayMessage;

    if (isProcessing) {
      statusColor = Colors.orange;
      statusIcon = Icons.sync;
      displayMessage =
          statusMessage.isNotEmpty ? statusMessage : 'Verarbeitung läuft...';
    } else if (isConnected) {
      statusColor = Colors.green;
      statusIcon = Icons.wifi;
      displayMessage = statusMessage.isNotEmpty ? statusMessage : 'Verbunden';
    } else {
      statusColor = Colors.red;
      statusIcon = Icons.wifi_off;
      displayMessage =
          statusMessage.isNotEmpty ? statusMessage : 'Nicht verbunden';
    }

    return Card(
      color: Colors.white, // statusColor.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(statusIcon, color: statusColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                displayMessage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: statusColor,
                ),
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
      ),
    );
  }
}
