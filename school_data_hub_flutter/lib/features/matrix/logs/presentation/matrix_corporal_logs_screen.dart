import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/toast.dart';

import '../data/matrix_corporal_log_entry.dart';
import '../domain/matrix_corporal_logs_manager.dart';
import 'widgets/matrix_corporal_log_card.dart';
import 'widgets/matrix_corporal_logs_filter_bottom_sheet.dart';

class MatrixCorporalLogsScreen extends WatchingWidget {
  const MatrixCorporalLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final manager = di<MatrixCorporalLogsManager>();
    callOnce((_) {
      manager.fetchCommand.run();
      manager.getConfigCommand.run();
    });

    final logs = watch(manager.logs).value;
    final isLoading = watch(manager.fetchCommand.isRunning).value;
    final isLoadingMore = watch(manager.loadMoreCommand.isRunning).value;
    final hasMore = watch(manager.hasMore).value;
    final filtersActive = watch(manager.filtersActive).value;

    registerHandler(
      select: (MatrixCorporalLogsManager m) => m.fetchCommand.errors,
      handler: (context, error, _) {
        if (error == null) return;
        Toast.show(
          context: context,
          message: 'Fehler beim Laden: ${error.error}',
          type: ToastType.error,
        );
      },
    );

    registerHandler(
      select: (MatrixCorporalLogsManager m) => m.deleteCommand.errors,
      handler: (context, error, _) {
        if (error == null) return;
        Toast.show(
          context: context,
          message: 'Fehler beim Löschen: ${error.error}',
          type: ToastType.error,
        );
      },
    );

    registerHandler(
      select: (MatrixCorporalLogsManager m) => m.deleteAllCommand.errors,
      handler: (context, error, _) {
        if (error == null) return;
        Toast.show(
          context: context,
          message: 'Fehler beim Löschen aller Einträge: ${error.error}',
          type: ToastType.error,
        );
      },
    );

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.article_outlined,
        title: 'Matrix-Corporal-Logs',
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          IconButton(
            tooltip: 'Filter',
            icon: Icon(
              Icons.filter_list,
              color: filtersActive
                  ? style.colors.warning
                  : style.colors.accentForeground,
              size: 30,
            ),
            onPressed: () => showMatrixCorporalLogsFilterBottomSheet(context),
            onLongPress: manager.resetFilters,
          ),
          IconButton(
            tooltip: 'Alle löschen',
            icon: const Icon(Icons.delete_sweep, size: 30),
            onPressed: () => _showDeleteAllDialog(context, manager),
            color: style.colors.error,
          ),
        ],
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
                GenericSliverListWithEmptyListCheck<MatrixCorporalLogEntry>(
                  itemsListenable: manager.logs,
                  itemBuilder: (context, entry) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: MatrixCorporalLogCard(
                      entry: entry,
                      onDelete: () => manager.deleteCommand.run(entry.id),
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

void _showDeleteAllDialog(
  BuildContext context,
  MatrixCorporalLogsManager manager,
) {
  final style = Style.of(context);
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Alle Logs löschen'),
      content: const Text(
        'Möchten Sie wirklich ALLE Matrix-Corporal-Logs löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
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
            foregroundColor: style.colors.error,
          ),
          child: const Text('Alle löschen'),
        ),
      ],
    ),
  );
}
