import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/services/hub_stream_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

/// Small circle indicator whose color reflects [HubConnectionState].
/// Use inside a [Positioned] in the app bar (e.g. top-right).
class HubConnectionStateIndicator extends WatchingWidget {
  static const double _radius = 5;

  const HubConnectionStateIndicator({super.key});

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
    return Container(
      width: _radius * 2,
      height: _radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _colorForState(state),
      ),
    );
  }
}

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData iconData;
  final String title;

  const GenericAppBar({super.key, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(iconData, size: 25, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(title, style: AppStyles.appBarTextStyle),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: HubConnectionStateIndicator(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
