// lib/log_viewer_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/logger/log_service.dart';
import 'package:school_data_hub_flutter/app_utils/logs_page/widgets/log_entry_card.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/bottom_nav_bar_no_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:signals_hooks/signals_hooks.dart';
import 'package:watch_it/watch_it.dart';

class LogViewerPage extends HookWidget {
  const LogViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logService = di<LogService>();
    final searchQuery = useSignalValue(logService.searchQuery);
    final logs = useSignalValue(logService.filteredLogs);
    final showFine = useSignalValue(logService.showFine);
    final showInfo = useSignalValue(logService.showInfo);
    final showWarning = useSignalValue(logService.showWarning);
    final showSevere = useSignalValue(logService.showSevere);
    final showShout = useSignalValue(logService.showShout);
    final searchController = useTextEditingController(text: searchQuery);

    useEffect(() {
      if (searchController.text != searchQuery) {
        searchController.value = TextEditingValue(
          text: searchQuery,
          selection: TextSelection.collapsed(offset: searchQuery.length),
        );
      }
      return null;
    }, [searchQuery, searchController]);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.bug_report_outlined,
        title: 'In-App Logs',
      ),
      bottomNavigationBar: const BottomNavBarNoFilterButton(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: CustomScrollView(
            slivers: [
              GenericSliverSearchAppBar(
                height: 90,
                title: _LogSearchField(
                  controller: searchController,
                  value: searchQuery,
                  onChanged: logService.updateSearchQuery,
                  onClear: () => logService.updateSearchQuery(''),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: _LogLevelSwitches(
                    showFine: showFine,
                    showInfo: showInfo,
                    showWarning: showWarning,
                    showSevere: showSevere,
                    showShout: showShout,
                    onToggle: logService.setLevelVisibility,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.dangerButtonColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: logs.isEmpty ? null : logService.clearLogs,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Protokolle löschen'),
                    ),
                  ),
                ),
              ),
              GenericSliverListWithEmptyListCheck<AppLog>(
                items: logs,
                itemBuilder: (context, log) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  child: LogEntryCard(log: log),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogSearchField extends StatelessWidget {
  const _LogSearchField({
    required this.controller,
    required this.value,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Protokolle durchsuchen',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: value.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.clear();
                    onClear();
                  },
                ),
          border: InputBorder.none,
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
            Text('Log-Level anzeigen', style: AppStyles.subtitle),
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
