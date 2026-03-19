import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/logger/model/app_log.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class LogEntryCard extends StatelessWidget {
  const LogEntryCard({super.key, required this.log});

  final AppLog log;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final levelColor = _levelColor(style, log.level);
    final timestamp = log.time
        .toLocal()
        .toIso8601String()
        .split('T')
        .last
        .substring(0, 8);

    return CardBox(
      padding: EdgeInsets.symmetric(
        horizontal: Style.spacing.lg,
        vertical: Style.spacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: levelColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Style.radii.small),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Style.spacing.md,
                    vertical: Style.spacing.xs,
                  ),
                  child: Text(
                    log.level.name,
                    style: context.typography.caption.copyWith(
                      color: levelColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Style.spacing.md),
              Expanded(
                child: Text(
                  log.loggerName,
                  style: context.typography.subtitle.withColor(levelColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                timestamp,
                style: context.typography.subtitle
                    .withColor(style.colors.mutedForeground),
              ),
            ],
          ),
          SizedBox(height: Style.spacing.md),
          Text(
            log.message,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: style.colors.foreground,
            ),
          ),
          SizedBox(height: Style.spacing.md),
        ],
      ),
    );
  }

  Color _levelColor(Style style, Level level) {
    final colors = style.colors;
    if (level == Level.SEVERE) return colors.error;
    if (level == Level.WARNING) return colors.warning;
    if (level == Level.FINE) return colors.success;
    if (level == Level.INFO) return colors.info;
    if (level == Level.SHOUT) return colors.error;
    return colors.mutedForeground;
  }
}
