import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

import '../../data/matrix_corporal_log_entry.dart';

class MatrixCorporalLogCard extends StatelessWidget {
  const MatrixCorporalLogCard({super.key, required this.entry, this.onDelete});

  final MatrixCorporalLogEntry entry;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final borderColor = _colorForLevel(entry.level, style);

    void copyToClipboard() {
      final text = '${entry.time}\n${entry.level}\n${entry.message}';
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('In Zwischenablage kopiert'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    void handleLongPress() {
      if (onDelete == null) return;
      final style = Style.of(context);
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Eintrag löschen'),
          content: const Text(
            'Möchten Sie diesen Log-Eintrag wirklich löschen?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete?.call();
              },
              style: TextButton.styleFrom(
                foregroundColor: style.colors.error,
              ),
              child: const Text('Löschen'),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onLongPress: onDelete != null ? handleLongPress : null,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: style.colors.cardInCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 2),
        ),
        elevation: 1,
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
          shape: const Border(),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _LevelBadge(level: entry.level),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.message,
                      style: context.typography.subtitle.bold,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: style.colors.mutedForeground,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    entry.time.formatDateAndTimeForUser(),
                    style: context.typography.bodySmall.withColor(
                      style.colors.mutedForeground,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: copyToClipboard,
                    tooltip: 'Kopieren',
                  ),
                ],
              ),
            ],
          ),
          children: [
            if (entry.fields.isNotEmpty) _FieldsSection(fields: entry.fields),
          ],
        ),
      ),
    );
  }

  static Color _colorForLevel(String level, Style style) {
    switch (level.toLowerCase()) {
      case 'error':
      case 'fatal':
      case 'panic':
        return style.colors.error;
      case 'warning':
        return style.colors.warning;
      case 'info':
        return style.colors.info;
      case 'debug':
      case 'trace':
        return style.colors.mutedForeground;
      default:
        return style.colors.success;
    }
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level});

  final String level;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final color = MatrixCorporalLogCard._colorForLevel(level, style);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          level.toUpperCase(),
          style: context.typography.bodySmall.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _FieldsSection extends StatelessWidget {
  const _FieldsSection({required this.fields});

  final Map<String, dynamic> fields;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.data_object, size: 16, color: style.colors.mutedForeground),
            const SizedBox(width: 6),
            Text('Fields', style: context.typography.bodySmall),
          ],
        ),
        const Gap(4),
        ...fields.entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    e.key,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: style.colors.foreground,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    e.value?.toString() ?? '',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: style.colors.foreground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
