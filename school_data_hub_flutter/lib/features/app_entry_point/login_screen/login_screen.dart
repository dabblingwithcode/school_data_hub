import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_screen/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_screen/widgets/environments_dropdown.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller;
  const LoginScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final style = Style.of(context);
    final bool keyboardOn = MediaQuery.of(context).viewInsets.vertical > 0.0;

    // No auth check needed — go_router redirect handles auth→home transition.
    return Scaffold(
            backgroundColor: style.colors.canvas,
            resizeToAvoidBottomInset: true,
            body: Container(
              color: style.colors.accent,
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
                            : const EdgeInsets.only(top: 0),
                      ),
                      keyboardOn
                          ? const SizedBox.shrink()
                          : const SizedBox(
                              height: 250,
                              width: 250,
                              child: Image(
                                image: AssetImage('assets/foreground.png'),
                              ),
                            ),
                      const Gap(20),
                      Text(
                        locale.schoolDataHub,
                        style: context.typography.title
                            .withColor(style.colors.background)
                            .copyWith(fontSize: 30),
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
                                style: context.typography.body
                                    .withColor(style.colors.background)
                                    .bold,
                              ),
                      keyboardOn
                          ? const SizedBox(height: 15)
                          : const SizedBox(height: 15),
                      ...<Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Style.spacing.xl,
                              vertical: Style.spacing.sm,
                            ),
                            child: TextField(
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              controller: controller.usernameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: Style.spacing.lg,
                                  vertical: Style.spacing.xs,
                                ),
                                filled: true,
                                fillColor: style.colors.background,
                                labelText: locale.userName,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: style.colors.interactive,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Style.spacing.xl,
                              vertical: Style.spacing.sm,
                            ),
                            child: TextField(
                              textDirection: null,
                              controller: controller.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: Style.spacing.lg,
                                  vertical: Style.spacing.xs,
                                ),
                                filled: true,
                                fillColor: style.colors.background,
                                labelText: locale.password,
                                labelStyle: TextStyle(
                                  color: style.colors.accent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.all(Style.spacing.md),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Style.spacing.md,
                            ),
                            child: Button(
                              label: locale.logInButtonText,
                              onPressed: () async {
                                await controller.loginWithTextCredentials();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Style.spacing.md),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Style.spacing.md,
                            ),
                            child: Button(
                              label: locale.deleteKeyButtonText,
                              onPressed: () async {
                                await confirmationDialog(
                                  context: context,
                                  title: locale.deleteKeyPrompt,
                                  message:
                                      locale.areYouSureYouWantToDeleteSchoolKey,
                                );
                                controller.deleteEnv();
                              },
                            ),
                          ),
                        ),
                      ],
                      const Gap(10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Style.spacing.md,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Style.spacing.md,
                          ),
                          child: Button(
                            label: Platform.isWindows
                                ? 'SCHULSCHLÜSSEL IMPORTIEREN'
                                : locale.scanButton,
                            onPressed: () async {
                              Platform.isWindows
                                  ? controller.importEnvFromTxt()
                                  : controller.scanEnv(context);
                            },
                          ),
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
