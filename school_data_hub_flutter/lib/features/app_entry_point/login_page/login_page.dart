import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/snackbars.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/widgets/environments_dropdown.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/theme/app_colors.dart';
import 'package:school_data_hub_flutter/theme/styles.dart';
import 'package:watch_it/watch_it.dart';

class LoginPage extends WatchingWidget {
  final LoginController controller;
  const LoginPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // TODO: check if we nees another entry point for notifications here
    // There is already one in MainMenuBottomNavigation
    registerHandler(
      select: (NotificationService x) => x.notification,
      handler: (context, value, cancel) =>
          snackbar(context, value.type, value.message),
    );
    final bool isAuthenticated =
        watch(di<ServerpodSessionManager>()).isSignedIn;
    final bool envReady = watchValue((EnvManager x) => x.envIsReady);
    final locale = AppLocalizations.of(context)!;
    log('# LoginPage: isAuthenticated: $isAuthenticated, envReady: $envReady');
    final bool keyboardOn = MediaQuery.of(context).viewInsets.vertical > 0.0;
    //FocusScopeNode currentFocus = FocusScope.of(context);

    return (envReady && isAuthenticated)
        ? MainMenuBottomNavigation()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              color: AppColors.backgroundColor,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: keyboardOn
                              ? const EdgeInsets.only(top: 70)
                              : Platform.isWindows
                                  ? const EdgeInsets.only(top: 0)
                                  : const EdgeInsets.only(top: 0)),
                      keyboardOn
                          ? const SizedBox.shrink()
                          : const SizedBox(
                              height: 250,
                              width: 250,
                              child: Image(
                                image:
                                    AssetImage('assets/foreground_windows.png'),
                              ),
                            ),
                      const Gap(20),
                      Text(
                        locale.schoolDataHub,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const Gap(10),
                      if (controller.envs.isNotEmpty)
                        controller.envs.length > 1
                            ? EnvironmentsDropdown(
                                selectedEnv: controller.selectedEnv,
                                changeEnv: controller.changeEnv,
                              )
                            : Text(
                                controller.envs.keys.first,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                      keyboardOn
                          ? const SizedBox(
                              height: 15,
                            )
                          : const SizedBox(
                              height: 15,
                            ),
                      if (envReady) ...<Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8),
                            child: TextField(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.usernameController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: locale.userName,
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromRGBO(74, 76, 161, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 8),
                            child: TextField(
                              textDirection: null,
                              controller: controller.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: locale.password,
                                labelStyle: const TextStyle(
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            //margin: const EdgeInsets.only(bottom: 16),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: AppStyles.actionButtonStyle,
                              onPressed: () async {
                                // di<EnvManager>().deleteEnv();
                                await controller.loginWithTextCredentials();
                              },
                              onLongPress: () async {
                                await di<Client>().admin.createUser(
                                    userName: 'userName',
                                    email: controller.usernameController.text,
                                    password:
                                        controller.passwordController.text);
                              },
                              child: Text(
                                locale.logInButtonText,
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            //margin: const EdgeInsets.only(bottom: 16),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: AppStyles.actionButtonStyle,
                              onPressed: () async {
                                await confirmationDialog(
                                    context: context,
                                    title: locale.deleteKeyPrompt,
                                    message: locale
                                        .areYouSureYouWantToDeleteSchoolKey);
                                controller.deleteEnv();
                              },
                              child: Text(
                                locale.deleteKeyButtonText,
                                style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (envReady == false) ...<Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Platform.isWindows
                                ? Text(
                                    locale.importSchoolDataToContinue,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : Text(
                                    locale.scanSchoolIdToContinue,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                        const Gap(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            //margin: const EdgeInsets.only(bottom: 16),
                            child: ElevatedButton(
                                style: AppStyles.actionButtonStyle,
                                onPressed: () async {
                                  controller.generateSchoolKeys(context);
                                },
                                child: const Text('SCHULSCHLÜSSEL ERSTELLEN',
                                    textAlign: TextAlign.center,
                                    style: AppStyles.buttonTextStyle)),
                          ),
                        ),
                      ],
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          //margin: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                              style: AppStyles.actionButtonStyle,
                              onPressed: () async {
                                Platform.isWindows
                                    ? controller.importEnvFromTxt()
                                    : controller.scanEnv(context);
                              },
                              child: Platform.isWindows
                                  ? const Text('SCHULSCHLÜSSEL IMPORTIEREN',
                                      style: AppStyles.buttonTextStyle)
                                  : Text(
                                      locale.scanButton,
                                      style: AppStyles.buttonTextStyle,
                                    )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
