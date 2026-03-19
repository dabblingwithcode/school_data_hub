import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_data_hub_flutter/app_utils/logger/domain/log_record_formatter.dart';
import 'package:school_data_hub_flutter/app_utils/logger/domain/log_service.dart';
import 'package:school_data_hub_flutter/app_utils/logger/model/app_log.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/client/hub_state_indicators.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/router/app_router.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/error_screen.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/global_overlay_host/global_overlay_host.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_screen.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:terminate_restart/terminate_restart.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  GetIt.instance.debugEventsEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize media_kit backend for just_audio on Windows/Linux
  JustAudioMediaKit.ensureInitialized();
  // Initialize TerminateRestart to handle app termination
  TerminateRestart.instance.initialize();
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

  /// Global navigator key — used by snackbars.dart for root-level toast context
  /// and passed to GoRouter.
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Watch the color palette to trigger rebuilds on color changes
    watch(AppColors.paletteNotifier);

    // Update status bar color when palette changes
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle().copyWith(
        statusBarColor: AppColors.backgroundColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Watch auth state for HubStateIndicators visibility and DI gate
    final bool envIsReady = watchValue((EnvManager x) => x.envIsReady);
    final bool userIsAuthenticated = watchValue(
      (EnvManager x) => x.isAuthenticated,
    );

    // Create the router once — stable across rebuilds
    final appRouter = createOnce(
      () => AppRouter(navigatorKey: navigatorKey),
    );

    return Style(
      brightness: Brightness.light,
      child: MaterialApp.router(
        routerConfig: appRouter.router,
        builder: (context, child) {
          // Determine app phase for GlobalOverlayHost (used in log messages)
          final phase = userIsAuthenticated && envIsReady
              ? AppPhase.loggedIn
              : AppPhase.unlogged;

          // Gate authenticated routes behind DI readiness.
          // When the auth scope is first pushed, async singletons may still be
          // initializing. _DependencyGate shows LoadingScreen until di.allReady()
          // resolves, then passes through the router child.
          // When _DependencyGate is removed from the tree (logout → condition
          // becomes false), its State is disposed. On re-login a fresh State is
          // created with a new di.allReady() future for the new scope.
          Widget content = child!;
          if (userIsAuthenticated && envIsReady) {
            content = _DependencyGate(child: content);
          }

          return GlobalOverlayHost(
            phase: phase,
            child: Stack(
              children: [
                content,
                if (userIsAuthenticated && envIsReady)
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    right: 10,
                    height: kToolbarHeight,
                    child: const _HubStateIndicators(),
                  ),
              ],
            ),
          );
        },
        localizationsDelegates: const <LocalizationsDelegate<Object>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('de', 'DE'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Schuldaten Hub',
      ),
    );
  }
}

/// Gates rendering behind [di.allReady] so that auth-scope async singletons
/// are fully initialized before the main UI builds.
///
/// Uses a [StatefulWidget] so the future is created once per mount. When the
/// user logs out, this widget is removed from the tree (the `if` in the builder
/// is false). On re-login, a new instance is created with a fresh future.
class _DependencyGate extends StatefulWidget {
  const _DependencyGate({required this.child});
  final Widget child;

  @override
  State<_DependencyGate> createState() => _DependencyGateState();
}

class _DependencyGateState extends State<_DependencyGate> {
  static final _log = Logger('DependencyGate');
  late final Future<void> _ready = di.allReady(
    timeout: const Duration(seconds: 30),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _ready,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          _log.shout(
            'Dependency Injection Error: ${snapshot.error}',
            snapshot.stackTrace,
          );
          return ErrorScreen(error: snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.child;
        }
        return const LoadingScreen();
      },
    );
  }
}

/// Shows the hub connection/API indicators once [HubStreamService] is ready.
///
/// Why a StatefulWidget with a `late final` future?
///
/// [HubStreamService] is registered as a `registerSingletonAsync` in the auth
/// scope, so it may still be initialising when [MyApp] first renders the
/// overlay (auth becomes true → MyApp rebuilds → builder runs, all before
/// `di.allReady()` resolves). A plain `di.isReadySync` check fixes the crash
/// but never re-renders once the service becomes ready, so the indicators
/// never appear.
///
/// Using a [StatefulWidget] stores the [di.isReady] future exactly once in
/// [State]. [FutureBuilder] on that stable future renders nothing while the
/// service initialises, then triggers its own rebuild the moment init
/// completes — without depending on any external rebuild of [MyApp].
///
/// The indicators can't live in [GlobalOverlayHost] because that widget sits
/// below pushed routes in the navigator stack and would be obscured on any
/// page navigation.
class _HubStateIndicators extends StatefulWidget {
  const _HubStateIndicators();

  @override
  State<_HubStateIndicators> createState() => _HubStateIndicatorsState();
}

class _HubStateIndicatorsState extends State<_HubStateIndicators> {
  late final Future<void> _ready = _safeIsReady();

  /// Guards against [HubStreamService] not being registered yet (e.g. during
  /// an environment switch where auth scope was dropped).
  Future<void> _safeIsReady() async {
    if (!di.isRegistered<HubStreamService>()) return;
    await di.isReady<HubStreamService>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _ready,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        if (!di.isRegistered<HubStreamService>()) {
          return const SizedBox.shrink();
        }
        return const HubStateIndicator();
      },
    );
  }
}
