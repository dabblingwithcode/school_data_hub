import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_flutter/app_utils/logger/domain/log_record_formatter.dart';
import 'package:school_data_hub_flutter/app_utils/logger/domain/log_service.dart';
import 'package:school_data_hub_flutter/app_utils/logger/model/app_log.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/error_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/no_connection_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:signals/signals_flutter.dart';
import 'package:watch_it/watch_it.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // Disable Signals debug logging
  SignalsObserver.instance = null; // AppSignalsObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // Set the global logging level
  Logger.root.level = Level.ALL;
  di.registerSingleton<LogService>(LogService());

  final logService = di<LogService>();
  // Add your custom colored console listener
  Logger.root.onRecord.listen((record) {
    //  if (record.loggerName == 'Signals') return;
    final colorFormatter = const ColorFormatter();
    log(colorFormatter.format(record));
    final appLog = AppLog(record.level, record.message, record.loggerName);
    logService.addLog(appLog);
  });
  // using package window_manager to set a default windows window size
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1200, 800),

      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  // set status bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle().copyWith(
      statusBarColor: AppColors.backgroundColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  InitManager.registerCoreManagers();
  await di.allReady();

  runApp(const MyApp());
  //- Hack: - This is a to avoid calls to firebase from the mobile_scanner package every 15 minutes
  // like described here: https://github.com/juliansteenbakker/mobile_scanner/issues/553
  if (Platform.isAndroid) {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.parent.path;
    final file = File(
      '$path/databases/com.google.android.datatransport.events',
    );
    await file.writeAsString('Fake');
  }
}

class MyApp extends WatchingWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger('MyApp');

    // Watch the color palette signal to trigger rebuilds on color changes
    AppColors.paletteSignal.watch(context);

    // Update status bar color when palette changes
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle().copyWith(
        statusBarColor: AppColors.backgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final bool envIsReady = di<EnvManager>().envIsReady.watch(context);
    final bool userIsAuthenticated = di<EnvManager>().isAuthenticated.watch(
      context,
    );
    final bool isConnected = di<ServerpodConnectivityMonitor>().isConnected
        .watch(context);

    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de', 'DE'), // Set the default locale
        // Locale('en', 'EN'),
        //Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Schuldaten Hub',
      home: !isConnected
          ? const NoConnectionPage()
          : envIsReady
          ? FutureBuilder(
              future: di.allReady(timeout: const Duration(seconds: 30)),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log.shout(
                    'Dependency Injection Error: ${snapshot.error}',
                    snapshot.stackTrace,
                  );
                  return ErrorPage(error: snapshot.error.toString());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (userIsAuthenticated) {
                    return const MainMenuBottomNavigation();
                  } else {
                    return const Login();
                  }
                } else {
                  return const LoadingPage();
                }
              },
            )
          : di<EnvManager>().activeEnv != null
          ? const LoadingPage()
          : const EntryPoint(),
    );
  }
}
