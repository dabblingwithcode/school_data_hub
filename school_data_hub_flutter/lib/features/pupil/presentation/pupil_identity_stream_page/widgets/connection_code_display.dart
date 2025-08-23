import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class ConnectionCodeDisplay extends StatelessWidget {
  final String channelName;
  final String? description;

  const ConnectionCodeDisplay({
    Key? key,
    required this.channelName,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Verbindungscode',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Gap(8),
            if (channelName.isNotEmpty)
              RepaintBoundary(
                child: QrImageView(
                  size: 200,
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.white,
                  data: channelName,
                  version: QrVersions.auto,
                ),
              ),
            Text(
              channelName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            const Gap(16),
            Text(
              description ?? 'Teile diesen Code mit dem Empfänger',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
