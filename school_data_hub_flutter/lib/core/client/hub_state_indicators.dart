import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';

/// Combined indicator showing API activity and connection state
/// in a single pill-shaped container.
class HubStateIndicator extends WatchingWidget {
  const HubStateIndicator({super.key});

  static Color _colorForState(HubConnectionState state) {
    switch (state) {
      case HubConnectionState.connected:
        return Colors.green;
      case HubConnectionState.connecting:
        return Colors.orange;
      case HubConnectionState.waitingRetry:
        return Colors.yellow;
      case HubConnectionState.disconnected:
        return Colors.red;
      case HubConnectionState.background:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = watchValue((HubStreamService x) => x.connectionState);
    final isRunning = watchValue((NotificationManager x) => x.isRunning);
    final streamActive = watchValue((HubStreamService x) => x.streamActivity);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...((isRunning || streamActive)
                ? [
                    Icon(
                      streamActive
                          ? Icons.sync_rounded
                          : Icons.swap_vert_rounded,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                  ]
                : [const Gap(20)]),
            Icon(
              Icons.private_connectivity_rounded,
              size: 18,
              color: _colorForState(state),
            ),
          ],
        ),
      ),
    );
  }
}
