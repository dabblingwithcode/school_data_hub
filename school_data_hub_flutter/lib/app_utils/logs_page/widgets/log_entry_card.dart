import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/logger/log_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class LogEntryCard extends StatelessWidget {
  const LogEntryCard({super.key, required this.log});

  final AppLog log;

  @override
  Widget build(BuildContext context) {
    final levelColor = _levelColor(log.level);
    final timestamp = log.time
        .toLocal()
        .toIso8601String()
        .split('T')
        .last
        .substring(0, 8);

    return Card(
      color: AppColors.cardInCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: levelColor, width: 2),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: levelColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Text(
                      log.level.name,
                      style: AppStyles.textLabel.copyWith(
                        color: levelColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    log.loggerName,
                    style: AppStyles.subtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  timestamp,
                  style: AppStyles.subtitle.copyWith(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              log.message,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Color _levelColor(Level level) {
    if (level == Level.SEVERE) return AppColors.dangerButtonColor;
    if (level == Level.WARNING) return AppColors.warningButtonColor;
    if (level == Level.INFO) return Colors.green.shade700;
    if (level == Level.SHOUT) return Colors.red.shade900;
    return Colors.blueGrey;
  }

  IconData _levelIcon(Level level) {
    if (level == Level.SEVERE || level == Level.SHOUT) {
      return Icons.error_outline;
    }
    if (level == Level.WARNING) {
      return Icons.warning_amber_rounded;
    }
    if (level == Level.INFO) {
      return Icons.info_outline;
    }
    return Icons.bubble_chart_outlined;
  }
}
