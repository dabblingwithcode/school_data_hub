// lib/log_viewer_page.dart
import 'package:flutter/material.dart';
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
import 'package:watch_it/watch_it.dart';

class LogViewerPage extends WatchingWidget {
  const LogViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logService = watchIt<LogService>();
    final logs = watchPropertyValue(
      (LogService service) => service.filteredLogs,
    );
    final searchQuery = watchPropertyValue(
      (LogService service) => service.searchQuery,
    );
    final showInfo = watchPropertyValue(
      (LogService service) => service.showInfo,
    );
    final showWarning = watchPropertyValue(
      (LogService service) => service.showWarning,
    );
    final showSevere = watchPropertyValue(
      (LogService service) => service.showSevere,
    );
    final showShout = watchPropertyValue(
      (LogService service) => service.showShout,
    );

    final searchController = createOnce(
      () => TextEditingController(text: logService.searchQuery),
    );

    if (searchController.text != searchQuery) {
      searchController.value = TextEditingValue(
        text: searchQuery,
        selection: TextSelection.collapsed(offset: searchQuery.length),
      );
    }

    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.bug_report_outlined,
        title: 'In-App Logs',
      ),
      bottomNavigationBar: const BottomNavBarNoFilterButton(),
      body: CustomScrollView(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _LogLevelSwitches(
                showInfo: showInfo,
                showWarning: showWarning,
                showSevere: showSevere,
                showShout: showShout,
                onToggle: logService.setLevelVisibility,
              ),
            ),
          ),
          GenericSliverListWithEmptyListCheck<AppLog>(
            items: logs,
            itemBuilder: (context, log) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: LogEntryCard(log: log),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
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
    required this.showInfo,
    required this.showWarning,
    required this.showSevere,
    required this.showShout,
    required this.onToggle,
  });

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
                _LevelSwitch(
                  label: 'Info',
                  value: showInfo,
                  level: Level.INFO,
                  onToggle: onToggle,
                ),
                _LevelSwitch(
                  label: 'Warnung',
                  value: showWarning,
                  level: Level.WARNING,
                  onToggle: onToggle,
                ),
                _LevelSwitch(
                  label: 'Fehler',
                  value: showSevere,
                  level: Level.SEVERE,
                  onToggle: onToggle,
                ),
                _LevelSwitch(
                  label: 'Kritisch',
                  value: showShout,
                  level: Level.SHOUT,
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

class _LevelSwitch extends StatelessWidget {
  const _LevelSwitch({
    required this.label,
    required this.value,
    required this.level,
    required this.onToggle,
  });

  final String label;
  final bool value;
  final Level level;
  final void Function(Level level, bool value) onToggle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardInCardBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppStyles.textLabel.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Switch.adaptive(
              value: value,
              activeTrackColor: AppColors.accentColor,
              onChanged: (newValue) => onToggle(level, newValue),
            ),
          ],
        ),
      ),
    );
  }
}
