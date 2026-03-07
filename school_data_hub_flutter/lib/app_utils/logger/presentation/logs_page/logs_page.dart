// lib/log_viewer_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';

import '../../domain/log_service.dart';
import '../../model/app_log.dart';
import 'widgets/log_entry_card.dart';
import 'widgets/logs_filter_bottom_sheet.dart';

class LogsPage extends WatchingWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logService = di<LogService>();
    final searchQuery = watch(logService.searchQuery).value;
    final logs = watch(logService.filteredLogs).value;
    final filtersActive = watch(logService.filtersActive).value;
    final searchController = createOnce(
      () => TextEditingController(text: searchQuery),
    );

    // Sync controller text when searchQuery changes externally
    registerHandler(
      target: logService.searchQuery,
      handler: (BuildContext context, String query, void Function() cancel) {
        if (searchController.text != query) {
          searchController.value = TextEditingValue(
            text: query,
            selection: TextSelection.collapsed(offset: query.length),
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.bug_report_outlined,
        title: 'In-App Logs',
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Filter',
            icon: Icon(
              Icons.filter_list,
              color: filtersActive ? Colors.deepOrange : Colors.white,
              size: 30,
            ),
            onPressed: () => showLogsFilterBottomSheet(context),
            onLongPress: logService.resetFilters,
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: CustomScrollView(
            slivers: [
              GenericSliverAppBarWithSearchWidget(
                height: 90,
                searchWidgetWithStatsRow: _LogSearchField(
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
                itemsListenable: logService.filteredLogs,
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
