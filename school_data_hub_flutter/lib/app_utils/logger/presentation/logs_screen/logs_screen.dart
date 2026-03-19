// lib/log_viewer_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';

import '../../domain/log_service.dart';
import '../../model/app_log.dart';
import 'widgets/log_entry_card.dart';
import 'widgets/logs_filter_bottom_sheet.dart';

class LogsScreen extends WatchingWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
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
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.bug_report_outlined,
        title: 'In-App Logs',
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            tooltip: 'Filter',
            icon: Icon(
              Icons.filter_list,
              color: filtersActive
                  ? style.colors.warning
                  : style.colors.background,
              size: 30,
            ),
            onPressed: () => showLogsFilterBottomSheet(context),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: Style.spacing.lg,
                    vertical: Style.spacing.xs,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Button.small(
                      variant: ButtonVariant.destructive,
                      onPressed: logs.isEmpty ? null : logService.clearLogs,
                      icon: const Icon(Icons.delete_outline),
                      label: 'Protokolle löschen',
                    ),
                  ),
                ),
              ),
              GenericSliverListWithEmptyListCheck<AppLog>(
                itemsListenable: logService.filteredLogs,
                itemBuilder: (context, log) => LogEntryCard(log: log),
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
    final style = Style.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Style.spacing.md,
        vertical: Style.spacing.sm,
      ),
      decoration: BoxDecoration(
        color: style.colors.canvas,
        borderRadius: BorderRadius.circular(Style.radii.large),
        boxShadow: [
          BoxShadow(
            color: style.colors.foreground.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
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
              : GestureDetector(
                  onTap: () {
                    controller.clear();
                    onClear();
                  },
                  child: const Icon(Icons.close),
                ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
