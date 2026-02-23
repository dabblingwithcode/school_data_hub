import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class SessionLogCard extends StatelessWidget {
  const SessionLogCard({
    super.key,
    required this.info,
    this.onDelete,
  });

  final HubSessionLogInfo info;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final entry = info.sessionLogEntry;
    final hasError = entry.error != null;
    final isSlow = entry.slow == true;
    final isOpen = entry.isOpen == true;
    final borderColor = _borderColor(
      hasError: hasError,
      isSlow: isSlow,
      isOpen: isOpen,
    );

    final endpointLabel = entry.endpoint != null
        ? '${entry.endpoint}.${entry.method ?? '?'}'
        : '–';
    final timestamp = entry.time
        .toLocal()
        .toIso8601String()
        .replaceFirst('T', '  ')
        .substring(0, 21);
    final durationMs = entry.duration != null
        ? '${entry.duration!.toStringAsFixed(0)} ms'
        : 'offen';

    void copyToClipboard() {
      Clipboard.setData(
        ClipboardData(text: info.sessionLogEntry.error ?? 'kein Inhalt'),
      );
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
          content: const Text('Möchten Sie diesen Log-Eintrag wirklich löschen?'),
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
                  _StatusBadge(
                    hasError: hasError,
                    isSlow: isSlow,
                    isOpen: isOpen,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      endpointLabel,
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
                  Icon(Icons.access_time, size: 14, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    timestamp,
                    style: AppStyles.textLabel.copyWith(color: Colors.black54),
                  ),
                  const Spacer(),
                  Icon(Icons.timer_outlined, size: 14, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    durationMs,
                    style: AppStyles.textLabel.copyWith(color: Colors.black54),
                  ),
                  if (entry.numQueries != null) ...[
                    const SizedBox(width: 12),
                    Icon(Icons.storage_outlined, size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      '${entry.numQueries} Q',
                      style: AppStyles.textLabel.copyWith(color: Colors.black54),
                    ),
                    const Gap(20),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: copyToClipboard,
                      tooltip: 'Kopieren',
                    ),
                  ],
                ],
              ),
              if (hasError) ...[
                const SizedBox(height: 6),
                _ExpandableErrorText(error: entry.error!),
              ],
            ],
          ),
          children: [
            if (info.logs.isNotEmpty) _LogEntriesSection(logs: info.logs),
            if (info.queries.isNotEmpty)
              _QueryEntriesSection(queries: info.queries),
            if (entry.stackTrace != null)
              _StackTraceSection(stackTrace: entry.stackTrace!),
          ],
        ),
      ),
    );
  }

  Color _borderColor({
    required bool hasError,
    required bool isSlow,
    required bool isOpen,
  }) {
    if (hasError) return AppColors.dangerButtonColor;
    if (isSlow) return AppColors.warningButtonColor;
    if (isOpen) return Colors.blue.shade700;
    return Colors.green.shade700;
  }
}

class _ExpandableErrorText extends StatelessWidget {
  const _ExpandableErrorText({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return _ExpandableMonoText(text: error, color: Colors.red);
  }
}

class _ExpandableMonoText extends StatefulWidget {
  const _ExpandableMonoText({required this.text, this.color = Colors.black87});

  final String text;
  final Color color;

  @override
  State<_ExpandableMonoText> createState() => _ExpandableMonoTextState();
}

class _ExpandableMonoTextState extends State<_ExpandableMonoText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Text(
              widget.text,
              maxLines: _expanded ? null : 2,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: widget.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.hasError,
    required this.isSlow,
    required this.isOpen,
  });

  final bool hasError;
  final bool isSlow;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    final (label, color) = _labelAndColor();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          label,
          style: AppStyles.textLabel.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  (String, Color) _labelAndColor() {
    if (hasError) return ('FEHLER', AppColors.dangerButtonColor);
    if (isSlow) return ('LANGSAM', AppColors.warningButtonColor);
    if (isOpen) return ('OFFEN', Colors.blue.shade700);
    return ('OK', Colors.green.shade700);
  }
}

class _LogEntriesSection extends StatelessWidget {
  const _LogEntriesSection({required this.logs});

  final List<HubLogEntry> logs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          icon: Icons.article_outlined,
          label: 'Log-Einträge',
        ),
        const SizedBox(height: 4),
        ...logs.map(
          (log) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LogLevelDot(level: log.logLevel),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    log.message,
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

class _LogLevelDot extends StatelessWidget {
  const _LogLevelDot({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    // Serverpod LogLevel: 0=debug, 1=verbose, 2=info, 3=warning, 4=error, 5=fatal
    final color = switch (level) {
      >= 4 => Colors.red,
      3 => Colors.orange,
      2 => Colors.blue,
      _ => Colors.grey,
    };
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: CircleAvatar(radius: 4, backgroundColor: color),
    );
  }
}

class _QueryEntriesSection extends StatelessWidget {
  const _QueryEntriesSection({required this.queries});

  final List<HubQueryLogEntry> queries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const _SectionHeader(icon: Icons.storage_outlined, label: 'Queries'),
        const SizedBox(height: 4),
        ...queries.map(
          (q) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (q.slow)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          size: 14,
                          color: Colors.orange,
                        ),
                      ),
                    Text(
                      '${q.duration.toStringAsFixed(1)} ms',
                      style: AppStyles.textLabel.copyWith(
                        color: q.slow ? Colors.orange : Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    if (q.numRows != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '${q.numRows} Zeilen',
                        style: AppStyles.textLabel.copyWith(
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
                _ExpandableMonoText(text: q.query),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StackTraceSection extends StatelessWidget {
  const _StackTraceSection({required this.stackTrace});

  final String stackTrace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const _SectionHeader(icon: Icons.layers_outlined, label: 'Stack Trace'),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            stackTrace,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppStyles.textLabel.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
