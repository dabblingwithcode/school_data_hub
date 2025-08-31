import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/notification_banner.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/learn_resources_menu_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/pupil_lists_menu_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/scan_tools_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/school_lists_page.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_page/settings_page.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

final _bottomNavmanager = di<BottomNavManager>();
final _envManager = di<EnvManager>();

class MainMenuBottomNavigation extends WatchingWidget {
  MainMenuBottomNavigation({super.key});

  final List pages = [
    const PupilListsMenuPage(),
    const SchoolListsMenuPage(),
    const LearnResourcesMenuPage(),
    const ScanToolsPage(),
    const SettingsPage(),
  ];

  final List<NotificationData> _notifications = [];
  OverlayEntry? _notificationOverlayEntry;

  void showHeavyLoadingOverlay(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder:
          (context) => const Stack(
            fit: StackFit.expand,
            children: [
              ModalBarrier(
                dismissible: false,
                color: Color.fromARGB(
                  108,
                  0,
                  0,
                  0,
                ), // Colors.black.withOpacity(0.3)
              ), // Background color
              Material(
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Bitte warten...', // Your text here
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 20, // Text size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      CircularProgressIndicator(
                        color: AppColors.interactiveColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void hideLoadingOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void showNotificationBanner(
    BuildContext context,
    NotificationData notificationData,
  ) {
    // Add new notification to the list
    _notifications.add(notificationData);

    // If banner already exists, update it; otherwise create new one
    if (_notificationOverlayEntry != null) {
      // Update existing banner
      _notificationOverlayEntry!.markNeedsBuild();
    } else {
      // Create new banner
      _notificationOverlayEntry = OverlayEntry(
        builder:
            (context) => Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NotificationBanner(
                notifications: List.from(_notifications),
                onDismiss: hideNotificationBanner,
              ),
            ),
      );

      Overlay.of(context).insert(_notificationOverlayEntry!);
    }
  }

  void hideNotificationBanner() {
    _notificationOverlayEntry?.remove();
    _notificationOverlayEntry = null;
    // Clear all notifications when banner is dismissed
    _notifications.clear();
  }

  void clearNotificationHistory() {
    _notifications.clear();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final tab = watchValue((BottomNavManager x) => x.bottomNavState);
    final pageViewController = createOnce(
      () => PageController(initialPage: tab),
    );

    // with these handlers we control the overlays of the notification service
    // this is the main entry point for the notification service
    registerHandler(
      select: (NotificationService x) => x.notification,
      handler: (context, value, cancel) {
        if (value.message.isNotEmpty) {
          if (value.type == NotificationType.dialog) {
            informationDialog(context, 'Info', value.message);
          } else {
            showNotificationBanner(context, value);
          }
        }
      },
    );

    registerHandler(
      select: (NotificationService x) => x.loadingNewInstance,
      handler: (context, value, cancel) {
        value ? showInstanceLoadingOverlay(context) : hideLoadingOverlay();
      },
    );

    registerHandler(
      select: (NotificationService x) => x.heavyLoading,
      handler: (context, value, cancel) {
        value ? showHeavyLoadingOverlay(context) : hideLoadingOverlay();
      },
    );
    registerHandler(
      select: (BottomNavManager x) => x.bottomNavState,
      handler: (context, value, cancel) {
        pageViewController.jumpToPage(value);
      },
    );
    callOnce((context) async {
      final envDataIncomplete =
          di<EnvManager>().isAnyImportantEnvDataNotPopulatedInServer();
      if (envDataIncomplete) {
        final serverDataStatus = _envManager.populatedEnvServerData;
        final List<String> missingFields = [];
        if (!serverDataStatus.schoolSemester) {
          missingFields.add('Schulhalbjahr');
        }
        if (!serverDataStatus.schooldays) {
          missingFields.add('Schultage');
        }
        if (!serverDataStatus.competences) {
          missingFields.add('Kompetenzen');
        }
        if (!serverDataStatus.supportCategories) {
          missingFields.add('Förderkategorien');
        }
        final String missingData = missingFields.join('\n');

        // delayed because of race condition
        unawaited(
          Future<void>.delayed(const Duration(milliseconds: 500), () {
            di<NotificationService>().showInformationDialog(
              'Es fehlen noch diese Daten im Server:\n\n$missingData',
            );
          }),
        );
      }
    });
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      body: PageView(
        controller: pageViewController,
        children: const <Widget>[
          PupilListsMenuPage(),
          SchoolListsMenuPage(),
          LearnResourcesMenuPage(),
          ScanToolsPage(),
          SettingsPage(),
        ],
        onPageChanged: (index) => _bottomNavmanager.setBottomNavPage(index),
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomNavigationBar(
          iconSize: 28,
          onTap: (index) {
            _bottomNavmanager.setBottomNavPage(index);
            pageViewController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
            //BottomNavManager().setBottomNavPage(index);
          },
          showSelectedLabels: true,
          currentIndex: tab,
          selectedItemColor: AppColors.accentColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_box_rounded),
              label: locale.pupilLists,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: locale.schoolLists,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.lightbulb),
              label: locale.learningLists,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.build_rounded),
              label: locale.scanTools,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: locale.settings,
            ),
          ],

          //onTap:
        ),
      ),
    );
  }
}

OverlayEntry? overlayEntry;

void showInstanceLoadingOverlay(BuildContext context) {
  final locale = AppLocalizations.of(context)!;
  overlayEntry = OverlayEntry(
    builder:
        (context) => Stack(
          fit: StackFit.expand,
          children: [
            const ModalBarrier(
              dismissible: false,
              color: AppColors.backgroundColor, // Colors.black.withOpacity(0.3)
            ), // Background color
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
                      'Bitte warten...', // Your text here
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 20,
                        fontWeight: FontWeight.bold, // Text size
                      ),
                    ),
                    const SizedBox(height: 16),
                    const CircularProgressIndicator(
                      color: AppColors.accentColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
  );

  Overlay.of(context).insert(overlayEntry!);
}
