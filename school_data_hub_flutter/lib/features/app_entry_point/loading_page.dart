import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/logger/presentation/logs_page/logs_page.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

final _envManager = di<EnvManager>();

class LoadingPage extends WatchingStatefulWidget {
  const LoadingPage({super.key});

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  // String actualNotificationMessage = "";
  // String lastNotificationMessage = "";
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    // final NotificationData snackBarData = watchValue(
    //   (NotificationService x) => x.notification,
    // );
    // String newValue = snackBarData.message;

    // if (newValue != actualNotificationMessage) {
    //   lastNotificationMessage = actualNotificationMessage;
    //   actualNotificationMessage = newValue;
    // }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: AppColors.backgroundColor),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double maxContentWidth = constraints.maxWidth >= 600
                  ? 600
                  : constraints.maxWidth;
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => LogsPage()),
                              );
                            },
                            child: const Image(
                              image: AssetImage('assets/foreground.png'),
                            ),
                          ),
                        ),
                        Text(
                          locale.schoolDataHub,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const Gap(15),
                        if (_envManager.activeEnv != null)
                          Text(
                            _envManager.activeEnv!.serverName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        const Gap(40),
                        const Text(
                          'Lade Daten...',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: Text(
                        //     lastNotificationMessage,
                        //     textAlign: TextAlign.center,
                        //     style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        // const Gap(5),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: Text(
                        //     actualNotificationMessage,
                        //     textAlign: TextAlign.center,
                        //     style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        const Gap(30),
                        const CircularProgressIndicator(color: Colors.white),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
