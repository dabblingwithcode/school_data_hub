import 'package:school_data_hub_flutter/core/auth_session_manager.dart';
import 'package:school_data_hub_flutter/core/env_manager.dart';
import 'package:school_data_hub_flutter/core/services/notification_service.dart';
import 'package:watch_it/watch_it.dart';

void registerBaseManagers() {
  di.registerSingletonAsync<EnvManager>(() async {
    final envManager = EnvManager();
    await envManager.init();
    return envManager;
  });
  di.registerSingletonWithDependencies(() {
    return AuthSessionManager(
      serverUrl: di<EnvManager>().env!.serverUrl,
    );
  }, dependsOn: [EnvManager]);
  di.registerSingleton<NotificationService>(NotificationService());
}
