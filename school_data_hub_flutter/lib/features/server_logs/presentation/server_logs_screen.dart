import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/confirmation_popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/toast.dart';
import 'package:school_data_hub_flutter/features/server_logs/domain/server_logs_manager.dart';
import 'package:school_data_hub_flutter/features/server_logs/presentation/widgets/server_logs_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/server_logs/presentation/widgets/session_log_card.dart';

class ServerLogsScreen extends WatchingWidget {
  const ServerLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
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
        Toast.show(
          context: context,
          message: 'Fehler beim Laden: ${error.error}',
          type: ToastType.error,
        );
      },
    );

    registerHandler(
      select: (ServerLogsManager m) => m.deleteCommand.errors,
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
      select: (ServerLogsManager m) => m.deleteAllCommand.errors,
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
        iconData: Icons.dns_outlined,
        title: 'Server-Logs',
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
            onPressed: () => showServerLogsFilterBottomSheet(context),
          ),
          TappableIcon(
            tooltip: 'Alle löschen',
            icon: Icon(Icons.delete_sweep, size: 30, color: style.colors.error),
            onPressed: () => _showDeleteAllPopup(context, manager),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.only(bottom: Style.spacing.md)),
              if (isLoading && logs.isEmpty)
                SliverFillRemaining(
                  child: Center(child: Spinner(color: style.colors.foreground)),
                )
              else ...[
                ContentSliverList<HubSessionLogInfo>(
                  itemsListenable: manager.sessionLogs,
                  itemBuilder: (context, info) => SessionLogCard(
                    info: info,
                    onDelete: () => manager.deleteCommand.run(
                      info.sessionLogEntry.sessionId,
                    ),
                  ),
                ),
                if (hasMore && logs.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Style.spacing.lg,
                        vertical: Style.spacing.md,
                      ),
                      child: Center(
                        child: isLoadingMore
                            ? Padding(
                                padding: EdgeInsets.all(Style.spacing.lg),
                                child: Spinner(color: style.colors.foreground),
                              )
                            : Button.small(
                                onPressed: manager.loadMoreCommand.run,
                                icon: const Icon(Icons.expand_more),
                                label: 'Mehr laden',
                                variant: ButtonVariant.secondary,
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

void _showDeleteAllPopup(BuildContext context, ServerLogsManager manager) {
  ConfirmationPopup.show(
    context: context,
    icon: const Icon(Icons.delete_sweep),
    title: 'Alle Logs löschen',
    description:
        'Möchten Sie wirklich ALLE Server-Logs löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
    confirmLabel: 'Alle löschen',
    cancelLabel: 'Abbrechen',
    destructive: true,
    onConfirm: () => manager.deleteAllCommand.run(),
  );
}
