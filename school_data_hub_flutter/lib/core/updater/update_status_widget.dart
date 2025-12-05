import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/updater/shorebird_update_manager.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:watch_it/watch_it.dart';

/// Widget that displays update status and provides update controls
class UpdateStatusWidget extends WatchingWidget {
  const UpdateStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final updateManager = di<ShorebirdUpdateManager>();
    final status = watchPropertyValue((ShorebirdUpdateManager x) => x.status);
    final updateAvailable = watchPropertyValue(
      (ShorebirdUpdateManager x) => x.updateAvailable,
    );
    final currentTrack = watchPropertyValue(
      (ShorebirdUpdateManager x) => x.currentTrack,
    );
    final currentPatch = watchPropertyValue(
      (ShorebirdUpdateManager x) => x.currentPatch,
    );
    final lastChecked = watchPropertyValue(
      (ShorebirdUpdateManager x) => x.lastChecked,
    );

    if (!updateManager.isAvailable) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange),
              SizedBox(width: 8),
              Text('Updates not available in this build'),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _getStatusIcon(status),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    updateManager.getStatusDescription(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (status == UpdateManagerStatus.checking ||
                    status == UpdateManagerStatus.downloading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),

            if (currentPatch != null) ...[
              const SizedBox(height: 8),
              Text(
                'Current patch: ${currentPatch.number}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            if (lastChecked != null) ...[
              const SizedBox(height: 4),
              Text(
                'Last checked: ${_formatDateTime(lastChecked)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],

            const SizedBox(height: 12),

            // Track selection
            Row(
              children: [
                const Text('Track: '),
                DropdownButton<UpdateTrack>(
                  value: currentTrack,
                  onChanged: (track) {
                    if (track != null) {
                      updateManager.setUpdateTrack(track);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: UpdateTrack.stable,
                      child: Text('stable'),
                    ),
                    DropdownMenuItem(
                      value: UpdateTrack.beta,
                      child: Text('beta'),
                    ),
                    DropdownMenuItem(
                      value: UpdateTrack.staging,
                      child: Text('staging'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Action buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: status == UpdateManagerStatus.checking
                      ? null
                      : () => updateManager.checkForUpdates(),
                  child: const Text('Check for Updates'),
                ),

                const SizedBox(width: 8),

                if (updateAvailable &&
                    status != UpdateManagerStatus.downloading)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentColor,
                    ),
                    onPressed: () => updateManager.downloadUpdate(),
                    child: const Text('Download Update'),
                  ),

                if (status == UpdateManagerStatus.restartRequired)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () => _showRestartDialog(context),
                    child: const Text('Restart Required'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon(UpdateManagerStatus status) {
    switch (status) {
      case UpdateManagerStatus.idle:
        return const Icon(Icons.check_circle_outline, color: Colors.grey);
      case UpdateManagerStatus.checking:
        return const Icon(Icons.refresh, color: Colors.blue);
      case UpdateManagerStatus.downloading:
        return const Icon(Icons.download, color: Colors.blue);
      case UpdateManagerStatus.updateAvailable:
        return const Icon(Icons.system_update, color: Colors.green);
      case UpdateManagerStatus.upToDate:
        return const Icon(Icons.check_circle, color: Colors.green);
      case UpdateManagerStatus.restartRequired:
        return const Icon(Icons.restart_alt, color: Colors.orange);
      case UpdateManagerStatus.error:
        return const Icon(Icons.error, color: Colors.red);
      case UpdateManagerStatus.unavailable:
        return const Icon(Icons.info, color: Colors.grey);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _showRestartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restart Required'),
        content: const Text(
          'An update has been downloaded and is ready to be applied. '
          'Please restart the app to apply the update.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // You could add app restart logic here if needed
              // For now, user needs to manually restart
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
