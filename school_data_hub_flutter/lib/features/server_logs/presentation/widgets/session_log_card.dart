import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/confirmation_popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tag.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/toast.dart';

class SessionLogCard extends StatelessWidget {
  const SessionLogCard({super.key, required this.info, this.onDelete});

  final HubSessionLogInfo info;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final entry = info.sessionLogEntry;
    final hasError = entry.error != null;
    final isSlow = entry.slow == true;
    final isOpen = entry.isOpen == true;
    // final borderColor = _borderColor(
    //   style: style,
    //   hasError: hasError,
    //   isSlow: isSlow,
    //   isOpen: isOpen,
    // );

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
        ClipboardData(
          text:
              '''
Error: ${info.sessionLogEntry.error}
Endpoint: ${info.sessionLogEntry.endpoint}
Method: ${info.sessionLogEntry.method}
Num Queries: ${info.sessionLogEntry.numQueries}
Duration: ${info.sessionLogEntry.duration} ms
Time: ${info.sessionLogEntry.time}
Authenticated User ID: ${info.sessionLogEntry.authenticatedUserId}
Is Open: ${info.sessionLogEntry.isOpen}
Stack Trace:
${info.sessionLogEntry.stackTrace ?? 'none set'}
              ''',
        ),
      );
      Toast.show(
        context: context,
        message: 'In Zwischenablage kopiert',
        type: ToastType.info,
      );
    }

    void handleLongPress() {
      if (onDelete == null) return;

      ConfirmationPopup.show(
        context: context,
        icon: const Icon(Icons.delete_outline),
        title: 'Eintrag löschen',
        description: 'Möchten Sie diesen Log-Eintrag wirklich löschen?',
        confirmLabel: 'Löschen',
        cancelLabel: 'Abbrechen',
        destructive: true,
        onConfirm: () => onDelete?.call(),
      );
    }

    return GestureDetector(
      onLongPress: onDelete != null ? handleLongPress : null,
      child: CardBox(
        padding: EdgeInsets.zero,
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: Style.spacing.xs,
          ),
          childrenPadding: EdgeInsets.fromLTRB(14, 0, 14, Style.spacing.md),
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
                    timestamp,
                    style: context.typography.bodySmall.withColor(
                      style.colors.mutedForeground,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.timer_outlined,
                    size: 14,
                    color: style.colors.mutedForeground,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    durationMs,
                    style: context.typography.bodySmall.withColor(
                      style.colors.mutedForeground,
                    ),
                  ),
                  if (entry.numQueries != null) ...[
                    const SizedBox(width: 12),
                    Icon(
                      Icons.storage_outlined,
                      size: 14,
                      color: style.colors.mutedForeground,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${entry.numQueries} Q',
                      style: context.typography.bodySmall.withColor(
                        style.colors.mutedForeground,
                      ),
                    ),
                    const Gap(20),
                    TappableIcon(
                      icon: const Icon(Icons.copy, size: 20),
                      size: 30,
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

  // Color _borderColor({
  //   required Style style,
  //   required bool hasError,
  //   required bool isSlow,
  //   required bool isOpen,
  // }) {
  //   if (hasError) return style.colors.error;
  //   if (isSlow) return style.colors.warning;
  //   if (isOpen) return style.colors.info;
  //   return style.colors.success;
  // }
}

class _ExpandableErrorText extends StatelessWidget {
  const _ExpandableErrorText({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return _ExpandableMonoText(text: error, color: style.colors.error);
  }
}

class _ExpandableMonoText extends StatefulWidget {
  const _ExpandableMonoText({required this.text, this.color});

  final String text;
  final Color? color;

  @override
  State<_ExpandableMonoText> createState() => _ExpandableMonoTextState();
}

class _ExpandableMonoTextState extends State<_ExpandableMonoText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
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
                color: widget.color ?? style.colors.foreground,
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
    final style = Style.of(context);
    final (label, color) = _labelAndColor(style);
    return Tag(label: label, color: color);
  }

  (String, Color) _labelAndColor(Style style) {
    if (hasError) return ('FEHLER', style.colors.error);
    if (isSlow) return ('LANGSAM', style.colors.warning);
    if (isOpen) return ('OFFEN', style.colors.info);
    return ('OK', style.colors.success);
  }
}

class _LogEntriesSection extends StatelessWidget {
  const _LogEntriesSection({required this.logs});

  final List<HubLogEntry> logs;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          icon: Icons.article_outlined,
          label: 'Log-Einträge',
        ),
        SizedBox(height: Style.spacing.xs),
        ...logs.map(
          (log) => Padding(
            padding: EdgeInsets.only(bottom: Style.spacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LogLevelDot(level: log.logLevel),
                SizedBox(width: Style.spacing.sm),
                Expanded(
                  child: Text(
                    log.message,
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

class _LogLevelDot extends StatelessWidget {
  const _LogLevelDot({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    // Serverpod LogLevel: 0=debug, 1=verbose, 2=info, 3=warning, 4=error, 5=fatal
    final color = switch (level) {
      >= 4 => style.colors.error,
      3 => style.colors.warning,
      2 => style.colors.info,
      _ => style.colors.mutedForeground,
    };
    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.xs),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _QueryEntriesSection extends StatelessWidget {
  const _QueryEntriesSection({required this.queries});

  final List<HubQueryLogEntry> queries;

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Style.spacing.sm),
        const _SectionHeader(icon: Icons.storage_outlined, label: 'Queries'),
        SizedBox(height: Style.spacing.xs),
        ...queries.map(
          (q) => Padding(
            padding: EdgeInsets.only(bottom: Style.spacing.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (q.slow)
                      Padding(
                        padding: EdgeInsets.only(right: Style.spacing.xs),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          size: 14,
                          color: style.colors.warning,
                        ),
                      ),
                    Text(
                      '${q.duration.toStringAsFixed(1)} ms',
                      style: context.typography.caption.bold.withColor(
                        q.slow
                            ? style.colors.warning
                            : style.colors.mutedForeground,
                      ),
                    ),
                    if (q.numRows != null) ...[
                      SizedBox(width: Style.spacing.sm),
                      Text(
                        '${q.numRows} Zeilen',
                        style: context.typography.caption.withColor(
                          style.colors.mutedForeground,
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
    final style = Style.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Style.spacing.sm),
        const _SectionHeader(icon: Icons.layers_outlined, label: 'Stack Trace'),
        SizedBox(height: Style.spacing.xs),
        CardBox(
          padding: EdgeInsets.all(Style.spacing.sm),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              stackTrace,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: style.colors.foreground,
              ),
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
    final style = Style.of(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: style.colors.mutedForeground),
        const SizedBox(width: 6),
        Text(
          label,
          style: context.typography.bodySmall.bold.withColor(
            style.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
