import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';

class NotificationBanner extends StatefulWidget {
  final List<NotificationData> notifications;
  final VoidCallback? onDismiss;

  const NotificationBanner({
    super.key,
    required this.notifications,
    this.onDismiss,
  });

  @override
  State<NotificationBanner> createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<NotificationBanner>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  Timer? _fadeTimer;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    _startAnimation();
    _startFadeTimer();
  }

  @override
  void didUpdateWidget(NotificationBanner oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the notifications changed, restart the fade timer
    if (oldWidget.notifications.length != widget.notifications.length ||
        (widget.notifications.isNotEmpty &&
            oldWidget.notifications.isNotEmpty &&
            oldWidget.notifications.last.message !=
                widget.notifications.last.message)) {
      _restartFadeTimer();
    }
  }

  void _startAnimation() {
    _fadeController.forward();
    _slideController.forward();
  }

  void _startFadeTimer() {
    _fadeTimer?.cancel();
    _fadeTimer = Timer(const Duration(milliseconds: 1000), () {
      _fadeOut();
    });
  }

  void _restartFadeTimer() {
    _fadeTimer?.cancel();
    _startFadeTimer();
  }

  void _fadeOut() {
    _fadeController.reverse();
    _slideController.reverse().then((_) {
      widget.onDismiss?.call();
    });
  }

  @override
  void dispose() {
    _fadeTimer?.cancel();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  // Use neutral colors for the banner
  Color _getBackgroundColor() {
    return Colors.grey[800]!;
  }

  IconData _getIcon() {
    if (widget.notifications.isEmpty) return Icons.notifications;

    // Use the most recent notification type for the icon
    final latestType = widget.notifications.last.type;
    switch (latestType) {
      case NotificationType.error:
        return Icons.error_outline;
      case NotificationType.warning:
        return Icons.warning_amber_outlined;
      case NotificationType.info:
        return Icons.info_outline;
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.dialog:
        return Icons.chat_bubble_outline;
    }
  }

  String _getEmoji() {
    if (widget.notifications.isEmpty) return '📢';

    // Use the most recent notification type for the emoji
    final latestType = widget.notifications.last.type;
    switch (latestType) {
      case NotificationType.error:
        return '❌';
      case NotificationType.warning:
        return '⚠️';
      case NotificationType.info:
        return 'ℹ️';
      case NotificationType.success:
        return '✅';
      case NotificationType.dialog:
        return '💬';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notifications.isEmpty) {
      return const SizedBox.shrink();
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //  Icon(_getIcon(), color: Colors.white, size: 24),
                      // const SizedBox(width: 8),
                      // Text(_getEmoji(), style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Show current notification
                              Text(
                                widget.notifications.last.message,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Show notification history if any
                              if (widget.notifications.length > 1) ...[
                                const SizedBox(height: 8),
                                ...widget.notifications
                                    .take(widget.notifications.length - 1)
                                    .map(
                                      (notification) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            // Show type indicator for history items
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: _getTypeColor(
                                                  notification.type,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                notification.message,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _fadeOut,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return Colors.red;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
      case NotificationType.success:
        return Colors.green;
      case NotificationType.dialog:
        return Colors.purple;
    }
  }
}
