import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/logger/domain/log_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:signals_hooks/signals_hooks.dart';
import 'package:watch_it/watch_it.dart';

Future<void> showLogsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (_) => const LogsFilterBottomSheet(),
  );
}

class LogsFilterBottomSheet extends HookWidget {
  const LogsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final logService = di<LogService>();
    final showFine = useSignalValue(logService.showFine);
    final showInfo = useSignalValue(logService.showInfo);
    final showWarning = useSignalValue(logService.showWarning);
    final showSevere = useSignalValue(logService.showSevere);
    final showShout = useSignalValue(logService.showShout);
    final loggerNames = useSignalValue(logService.loggerNamesSorted);
    final selectedLoggers = useSignalValue(logService.selectedLoggerFilters);
    final filtersActive = useSignalValue(logService.filtersActive);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Filter', style: AppStyles.subtitle),
                  const Spacer(),
                  if (filtersActive)
                    TextButton.icon(
                      onPressed: logService.resetFilters,
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Zurücksetzen'),
                    ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    tooltip: 'Schließen',
                  ),
                ],
              ),
              const Gap(8),
              _LogLevelSwitches(
                showFine: showFine,
                showInfo: showInfo,
                showWarning: showWarning,
                showSevere: showSevere,
                showShout: showShout,
                onToggle: logService.setLevelVisibility,
              ),
              const Gap(12),
              _LoggerFilterSection(
                loggerNames: loggerNames,
                selectedLoggers: selectedLoggers,
                onToggle: logService.toggleLoggerFilter,
                onClear: logService.clearLoggerFilters,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogLevelSwitches extends StatelessWidget {
  const _LogLevelSwitches({
    required this.showFine,
    required this.showInfo,
    required this.showWarning,
    required this.showSevere,
    required this.showShout,
    required this.onToggle,
  });

  final bool showFine;
  final bool showInfo;
  final bool showWarning;
  final bool showSevere;
  final bool showShout;
  final void Function(Level level, bool value) onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Log-Level anzeigen', style: AppStyles.subtitle),
            const Gap(12),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _LevelFilterChip(
                  label: 'Fein',
                  level: Level.FINE,
                  isSelected: showFine,
                  onToggle: onToggle,
                ),
                _LevelFilterChip(
                  label: 'Info',
                  level: Level.INFO,
                  isSelected: showInfo,
                  onToggle: onToggle,
                ),
                _LevelFilterChip(
                  label: 'Warnung',
                  level: Level.WARNING,
                  isSelected: showWarning,
                  onToggle: onToggle,
                ),
                _LevelFilterChip(
                  label: 'Fehler',
                  level: Level.SEVERE,
                  isSelected: showSevere,
                  onToggle: onToggle,
                ),
                _LevelFilterChip(
                  label: 'Kritisch',
                  level: Level.SHOUT,
                  isSelected: showShout,
                  onToggle: onToggle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelFilterChip extends StatelessWidget {
  const _LevelFilterChip({
    required this.label,
    required this.level,
    required this.isSelected,
    required this.onToggle,
  });

  final String label;
  final Level level;
  final bool isSelected;
  final void Function(Level level, bool value) onToggle;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: AppStyles.textLabel.copyWith(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
      avatar: Icon(
        _levelIcon(level),
        size: 18,
        color: isSelected ? Colors.white : AppColors.cardInCardBorderColor,
      ),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (selected) => onToggle(level, selected),
      backgroundColor: Colors.white,
      selectedColor: AppColors.accentColor,
      side: BorderSide(color: AppColors.cardInCardBorderColor),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }

  IconData _levelIcon(Level level) {
    if (level == Level.SEVERE || level == Level.SHOUT) {
      return Icons.error_outline;
    }
    if (level == Level.WARNING) {
      return Icons.warning_amber_rounded;
    }
    return Icons.info_outline;
  }
}

class _LoggerFilterSection extends StatelessWidget {
  const _LoggerFilterSection({
    required this.loggerNames,
    required this.selectedLoggers,
    required this.onToggle,
    required this.onClear,
  });

  final List<String> loggerNames;
  final Set<String> selectedLoggers;
  final void Function(String loggerName, bool enabled) onToggle;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedLoggers.isNotEmpty;
    return Card(
      color: AppColors.pupilProfileCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Logger-Quellen', style: AppStyles.subtitle),
                const Spacer(),
                if (hasSelection)
                  TextButton(
                    onPressed: onClear,
                    child: const Text('Alle anzeigen'),
                  ),
              ],
            ),
            const Gap(12),
            if (loggerNames.isEmpty)
              Text(
                'Noch keine Logger-Namen vorhanden',
                style: AppStyles.textLabel,
              )
            else
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  _LoggerChip(
                    label: 'Alle',
                    isSelected: !hasSelection,
                    onSelected: (_) => onClear(),
                  ),
                  ...loggerNames.map(
                    (name) => _LoggerChip(
                      label: name,
                      isSelected: selectedLoggers.contains(name),
                      onSelected: (selected) => onToggle(name, selected),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _LoggerChip extends StatelessWidget {
  const _LoggerChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: AppStyles.textLabel.copyWith(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
      selected: isSelected,
      showCheckmark: false,
      onSelected: onSelected,
      backgroundColor: Colors.white,
      selectedColor: AppColors.accentColor,
      side: BorderSide(color: AppColors.cardInCardBorderColor),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }
}
