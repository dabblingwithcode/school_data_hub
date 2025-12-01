import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:watch_it/watch_it.dart';

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
    // Helper to construct the deep link (shared logic)
    String getDeepLink() {
      final envManager = di<EnvManager>();
      var serverUrl = envManager.activeEnv?.serverUrl ?? 'unknown';

      // Remove protocol and trailing slash
      serverUrl = serverUrl.replaceAll(RegExp(r'^https?://'), '');
      if (serverUrl.endsWith('/')) {
        serverUrl = serverUrl.substring(0, serverUrl.length - 1);
      }

      return 'https://schooldata.hub/?url=$serverUrl&channelName=$channelName';
    }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  channelName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
                const Gap(10),
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.white),
                  tooltip: 'Link kopieren',
                  onPressed: () async {
                    final link = getDeepLink();
                    await Clipboard.setData(ClipboardData(text: link));
                    di<NotificationService>().showSnackBar(
                      NotificationType.success,
                      'Link in die Zwischenablage kopiert!',
                    );
                  },
                ),
              ],
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
