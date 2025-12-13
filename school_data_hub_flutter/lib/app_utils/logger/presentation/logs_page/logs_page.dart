// lib/log_viewer_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:signals_hooks/signals_hooks.dart';
import 'package:watch_it/watch_it.dart';

import '../../domain/log_service.dart';
import '../../model/app_log.dart';
import 'widgets/log_entry_card.dart';
import 'widgets/logs_filter_bottom_sheet.dart';

class LogsPage extends HookWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logService = di<LogService>();
    final searchQuery = useSignalValue(logService.searchQuery);
    final logs = useSignalValue(logService.filteredLogs);
    final filtersActive = useSignalValue(logService.filtersActive);
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
      bottomNavigationBar: _LogsBottomNavBar(
        filtersActive: filtersActive,
        onShowFilters: () => showLogsFilterBottomSheet(context),
        onResetFilters: logService.resetFilters,
      ),
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
                    vertical: 1,
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

class _LogsBottomNavBar extends StatelessWidget {
  const _LogsBottomNavBar({
    required this.filtersActive,
    required this.onShowFilters,
    required this.onResetFilters,
  });

  final bool filtersActive;
  final VoidCallback onShowFilters;
  final VoidCallback onResetFilters;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      padding: const EdgeInsets.all(10),
      color: AppColors.backgroundColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              InkWell(
                onTap: onShowFilters,
                onLongPress: onResetFilters,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.filter_list,
                    color: filtersActive ? Colors.deepOrange : Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
