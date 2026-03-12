import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/snackbars.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

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
      select: (NotificationService x) => x.notification,
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
            informationDialog(context, 'Info', value.message);
            break;
          case NotificationTarget.snackBar:
            if (_canShowSnackBarInPhase(phase)) {
              _log.info('Showing snackBar for: "${value.message}"');
              showSnackBarOnRootOverlay(
                type: value.type,
                message: value.message,
              );
            } else {
              _log.warning(
                'Suppressed snackBar in phase $phase: "${value.message}"',
              );
            }
            break;
          case NotificationTarget.overlay:
          case NotificationTarget.idle:
            break;
        }
      },
    );

    final loadingNewInstance = watchValue(
      (NotificationService x) => x.loadingNewInstance,
    );
    final heavyLoading = watchValue((NotificationService x) => x.heavyLoading);
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
  return Stack(
    fit: StackFit.expand,
    children: [
      const ModalBarrier(
        dismissible: false,
        color: Color.fromARGB(108, 0, 0, 0),
      ),
      Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Bitte warten...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              CircularProgressIndicator(color: AppColors.interactiveColor),
            ],
          ),
        ),
      ),
    ],
  );
}

bool _canShowSnackBarInPhase(AppPhase phase) {
  return switch (phase) {
    AppPhase.unlogged => true,
    AppPhase.loading => false,
    AppPhase.loggedIn => true,
  };
}

Widget _buildInstanceLoadingOverlay(BuildContext context) {
  final locale = AppLocalizations.of(context)!;
  return Stack(
    fit: StackFit.expand,
    children: [
      ModalBarrier(dismissible: false, color: AppColors.backgroundColor),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Gap(15),
              if (di<EnvManager>().activeEnv != null)
                Text(
                  di<EnvManager>().activeEnv!.serverName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              const Gap(10),
              const Text(
                'Instanzdaten werden geladen!',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Gap(5),
              const Text(
                'Bitte warten...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              CircularProgressIndicator(color: AppColors.accentColor),
            ],
          ),
        ),
      ),
    ],
  );
}
