import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

import '../../data/matrix_corporal_log_entry.dart';

class MatrixCorporalLogCard extends StatelessWidget {
  const MatrixCorporalLogCard({super.key, required this.entry, this.onDelete});

  final MatrixCorporalLogEntry entry;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final borderColor = _colorForLevel(entry.level);

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
      showDialog(
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
                foregroundColor: AppColors.dangerButtonColor,
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
        color: AppColors.cardInCardColor,
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
                      style: AppStyles.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    entry.time.formatDateAndTimeForUser(),
                    style: AppStyles.textLabel.copyWith(color: Colors.black54),
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

  static Color _colorForLevel(String level) {
    switch (level.toLowerCase()) {
      case 'error':
      case 'fatal':
      case 'panic':
        return AppColors.dangerButtonColor;
      case 'warning':
        return AppColors.warningButtonColor;
      case 'info':
        return Colors.blue.shade700;
      case 'debug':
      case 'trace':
        return Colors.grey.shade700;
      default:
        return Colors.green.shade700;
    }
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level});

  final String level;

  @override
  Widget build(BuildContext context) {
    final color = MatrixCorporalLogCard._colorForLevel(level);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          level.toUpperCase(),
          style: AppStyles.textLabel.copyWith(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.data_object, size: 16, color: Colors.black54),
            SizedBox(width: 6),
            Text('Fields', style: AppStyles.textLabel),
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
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    e.value?.toString() ?? '',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.black87,
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
