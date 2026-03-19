import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';

/// Merges the three auth/env/connection listenables into a single
/// [ChangeNotifier] for use as [GoRouter.refreshListenable].
///
/// When any of the three sources change, this notifier fires, causing
/// the router to re-evaluate its redirect guard.
///
/// Only references core-scope managers (always available).
class RouterNotifier extends ChangeNotifier {
  late final Listenable _merged;

  RouterNotifier() {
    _merged = Listenable.merge([
      di<EnvManager>().isAuthenticated,
      di<EnvManager>().envIsReady,
      di<ServerpodConnectivityMonitor>().isConnected,
    ]);
    _merged.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _merged.removeListener(notifyListeners);
    super.dispose();
  }
}
