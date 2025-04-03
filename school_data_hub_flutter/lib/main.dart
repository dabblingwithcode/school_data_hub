import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/dependency_injection.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/error_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
import 'package:watch_it/watch_it.dart';
import 'package:window_manager/window_manager.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // using package window_manager for windows window size
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
      statusBarBrightness: Brightness.light,
    ),
  );

  DiManager.registerBaseManagers();
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
    bool envIsReady = watchValue((EnvManager x) => x.envIsReady);

    // TODO: How can we watch the connectivity monitor instead of
    // adding a listener?
    // final isConnected =
    //     watchStream((x) => di<Client>().connectivityMonitor.);
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('de', 'DE'), // Set the default locale
        Locale('en', 'EN'),
        Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Schuldaten Hub',
      home:
          // TODO: How can we watch the connectivity monitor instead of
          // adding a listener?
          // !isConnected
          //     ? const NoConnectionPage()
          //     :
          envIsReady
              ? FutureBuilder(
                  future: di.allReady(timeout: const Duration(seconds: 30)),
                  //  locator.allReady(timeout: const Duration(seconds: 30)),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      debugPrint(
                          'Dependency Injection Error: ${snapshot.error}');
                      return ErrorPage(error: snapshot.error.toString());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (di<ServerpodSessionManager>().isSignedIn) {
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
