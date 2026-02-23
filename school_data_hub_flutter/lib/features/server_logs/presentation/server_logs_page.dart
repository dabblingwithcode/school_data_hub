import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';

import '../domain/server_logs_manager.dart';
import 'widgets/server_logs_filter_bottom_sheet.dart';
import 'widgets/session_log_card.dart';

class ServerLogsPage extends WatchingWidget {
  const ServerLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = di<ServerLogsManager>();
    callOnce((_) => manager.fetchCommand.run());

    final logs = watch(manager.sessionLogs).value;
    final isLoading = watch(manager.fetchCommand.isRunning).value;
    final isLoadingMore = watch(manager.loadMoreCommand.isRunning).value;
    final hasMore = watch(manager.hasMore).value;
    final filtersActive = watch(manager.filtersActive).value;

    registerHandler(
      select: (ServerLogsManager m) => m.fetchCommand.errors,
      handler: (context, error, _) {
        if (error == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Laden: ${error.error}'),
            backgroundColor: AppColors.dangerButtonColor,
          ),
        );
      },
    );

    registerHandler(
      select: (ServerLogsManager m) => m.deleteCommand.errors,
      handler: (context, error, _) {
        if (error == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Löschen: ${error.error}'),
            backgroundColor: AppColors.dangerButtonColor,
          ),
        );
      },
    );

    registerHandler(
      select: (ServerLogsManager m) => m.deleteAllCommand.errors,
      handler: (context, error, _) {
        if (error == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Löschen aller Einträge: ${error.error}'),
            backgroundColor: AppColors.dangerButtonColor,
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.dns_outlined,
        title: 'Server-Logs',
      ),
      bottomNavigationBar: _ServerLogsBottomNavBar(
        filtersActive: filtersActive,
        onShowFilters: () => showServerLogsFilterBottomSheet(context),
        onResetFilters: manager.resetFilters,
        onDeleteAll: () => _showDeleteAllDialog(context, manager),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: CustomScrollView(
            slivers: [
              if (isLoading && logs.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else ...[
                GenericSliverListWithEmptyListCheck<HubSessionLogInfo>(
                  items: logs,
                  itemBuilder: (context, info) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: SessionLogCard(
                      info: info,
                      onDelete: () => manager.deleteCommand.run(
                        info.sessionLogEntry.sessionId,
                      ),
                    ),
                  ),
                ),
                if (hasMore && logs.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Center(
                        child: isLoadingMore
                            ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              )
                            : FilledButton.icon(
                                onPressed: manager.loadMoreCommand.run,
                                icon: const Icon(Icons.expand_more),
                                label: const Text('Mehr laden'),
                              ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeleteAllDialog(BuildContext context, ServerLogsManager manager) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Alle Logs löschen'),
      content: const Text(
        'Möchten Sie wirklich ALLE Server-Logs löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            manager.deleteAllCommand.run();
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.dangerButtonColor,
          ),
          child: const Text('Alle löschen'),
        ),
      ],
    ),
  );
}

class _ServerLogsBottomNavBar extends StatelessWidget {
  const _ServerLogsBottomNavBar({
    required this.filtersActive,
    required this.onShowFilters,
    required this.onResetFilters,
    required this.onDeleteAll,
  });

  final bool filtersActive;
  final VoidCallback onShowFilters;
  final VoidCallback onResetFilters;
  final VoidCallback onDeleteAll;

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
              IconButton(
                tooltip: 'Alle löschen',
                icon: const Icon(Icons.delete_sweep, size: 30),
                onPressed: onDeleteAll,
                color: AppColors.dangerButtonColor,
              ),
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(Icons.arrow_back, size: 30),
                onPressed: () => Navigator.pop(context),
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
