import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/snackbars.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:school_data_hub_flutter/main.dart' show MyApp;

final _log = Logger('GlobalOverlayHost');

/// App phase used to choose notification presentation
enum AppPhase { unlogged, loading, loggedIn }

/// Single global host for notification (and future loading) overlays.
/// Phase controls presentation
class GlobalOverlayHost extends WatchingWidget {
  const GlobalOverlayHost({
    super.key,
    required this.phase,
    required this.child,
  });

  final AppPhase phase;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    registerHandler(
      select: (NotificationManager x) => x.notification,
      handler: (context, value, cancel) {
        if (value.target == NotificationTarget.idle) return;
        _log.info(
          'Notification handler fired: '
          'target=${value.target}, type=${value.type}, '
          'message="${value.message}", phase=$phase',
        );
        if (value.message.isEmpty) return;
        switch (value.target) {
          case NotificationTarget.informationDialog:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Use the router's navigator context — GlobalOverlayHost sits
              // above the Navigator so its own context has no Navigator ancestor.
              final navContext = MyApp.navigatorKey.currentContext;
              if (navContext != null && navContext.mounted) {
                informationDialog(navContext, 'Info', value.message);
              }
            });
            break;
          case NotificationTarget.snackBar:
            _log.info('Showing snackBar for: "${value.message}"');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackBarOnRootOverlay(
                type: value.type,
                message: value.message,
              );
            });
            break;
          case NotificationTarget.overlay:
          case NotificationTarget.idle:
            break;
        }
      },
    );

    final loadingNewInstance = watchValue(
      (NotificationManager x) => x.loadingNewInstance,
    );
    final heavyLoading = watchValue((NotificationManager x) => x.heavyLoading);
    final showInstanceOverlay = loadingNewInstance;
    final showHeavyOverlay = heavyLoading && !loadingNewInstance;

    return Stack(
      children: [
        child,
        if (showInstanceOverlay)
          Positioned.fill(child: _buildInstanceLoadingOverlay(context)),
        if (showHeavyOverlay)
          Positioned.fill(child: _buildHeavyLoadingOverlay(context)),
      ],
    );
  }
}

Widget _buildHeavyLoadingOverlay(BuildContext context) {
  final style = Style.of(context);
  return Stack(
    fit: StackFit.expand,
    children: [
      ModalBarrier(
        dismissible: false,
        color: style.colors.foreground.withValues(alpha: 0.42),
      ),
      Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bitte warten...',
                style: context.typography.title.withColor(
                  style.colors.background,
                ),
              ),
              const SizedBox(height: 16),
              CircularProgressIndicator(color: style.colors.interactive),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildInstanceLoadingOverlay(BuildContext context) {
  final locale = AppLocalizations.of(context)!;
  final style = Style.of(context);
  return Stack(
    fit: StackFit.expand,
    children: [
      ModalBarrier(dismissible: false, color: style.colors.accent),
      Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 300,
                width: 300,
                child: Image(image: AssetImage('assets/foreground.png')),
              ),
              Text(
                locale.schoolDataHub,
                style: context.typography.title.withColor(
                  style.colors.background,
                ).copyWith(fontSize: 30),
              ),
              const Gap(15),
              if (di<EnvManager>().activeEnv != null)
                Text(
                  di<EnvManager>().activeEnv!.serverName,
                  style: context.typography.title.withColor(
                    style.colors.background,
                  ).copyWith(fontSize: 22),
                ),
              const Gap(10),
              Text(
                'Instanzdaten werden geladen!',
                style: context.typography.title.withColor(
                  style.colors.background,
                ),
              ),
              const Gap(5),
              Text(
                'Bitte warten...',
                style: context.typography.title.withColor(
                  style.colors.background,
                ),
              ),
              const SizedBox(height: 16),
              CircularProgressIndicator(color: style.colors.button.primary),
            ],
          ),
        ),
      ),
    ],
  );
}
