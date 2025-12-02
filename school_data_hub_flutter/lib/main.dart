import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_flutter/app_utils/logger/logrecord_formatter.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/router/app_router.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set the global logging level
  Logger.root.level = Level.ALL;

  // Add your custom colored console listener
  Logger.root.onRecord.listen((record) {
    final colorFormatter = const ColorFormatter();
    log(colorFormatter.format(record));
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

  await InitManager.registerCoreManagers();

  await di.allReady();

  di.registerSingleton<AppRouter>(AppRouter());

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
    final router = di<AppRouter>().router;

    return MaterialApp.router(
      routerConfig: router,
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
    );
  }
}
