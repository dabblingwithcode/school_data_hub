import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_flutter/app_utils/logger/logrecord_formatter.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/error_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/no_connection_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
import 'package:watch_it/watch_it.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set the global logging level
  Logger.root.level = Level.ALL;

  // Add your custom colored console listener
  Logger.root.onRecord.listen((record) {
    final colorFormatter = ColorFormatter();
    log(colorFormatter.format(record));
  });
  // using package window_manager to set a default windows window size
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      // TODO: revert this for production
      // size: Size(1200, 800),
      size: Size(400, 800),
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
      statusBarBrightness: Brightness.light,
    ),
  );

  DiManager.registerCoreManagers();
  await di.allReady();

  runApp(const MyApp());
  // TODO: INFO - This is a hack to avoid calls to firebase from the mobile_scanner package every 15 minutes
  // like described here: https://github.com/juliansteenbakker/mobile_scanner/issues/553
  if (Platform.isAndroid) {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.parent.path;
    final file =
        File('$path/databases/com.google.android.datatransport.events');
    await file.writeAsString('Fake');
  }
}

class MyApp extends WatchingWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger('MyApp');
    final bool envIsReady = watchValue((EnvManager x) => x.envIsReady);
    final bool userIsAuthenticated =
        watchValue((EnvManager x) => x.isAuthenticated);
    final bool isConnected =
        watchValue((ServerpodConnectivityMonitor x) => x.isConnected);

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
                      log.shout('Dependency Injection Error: ${snapshot.error}',
                          snapshot.stackTrace);
                      return ErrorPage(error: snapshot.error.toString());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (userIsAuthenticated) {
                        return MainMenuBottomNavigation();
                      } else {
                        return const Login();
                      }
                    } else {
                      return const LoadingPage();
                    }
                  },
                )
              : const EntryPoint(),
    );
  }
}
