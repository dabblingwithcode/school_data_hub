import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';

/// A screen for users to change their password.
class UserChangePasswordScreen extends WatchingWidget {
  const UserChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final userManager = di<UserManager>();
    final TextEditingController oldPasswordController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController newPasswordController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController repeatPasswordController = createOnce(
      () => TextEditingController(),
    );

    return Scaffold(
      backgroundColor: style.colors.background,
      appBar: const AppHeader(
        iconData: Icons.lock_reset,
        title: 'Passwort ändern',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Gap(40),
                Row(
                  children: [
                    Text(
                      'Aktuelles Passwort:',
                      style: context.typography.subtitle.bold,
                    ),
                    const Gap(5),
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        controller: oldPasswordController,
                        obscureText: true,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Aktuelles Passwort',
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    Text(
                      'Neues Passwort:',
                      style: context.typography.subtitle.bold,
                    ),
                    const Gap(5),
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Neues Passwort',
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    Text(
                      'Neues Passwort wiederholen:',
                      style: context.typography.subtitle.bold,
                    ),
                    const Gap(5),
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        controller: repeatPasswordController,
                        obscureText: true,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Neues Passwort wiederholen',
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Gap(15),
                Button(
                  variant: ButtonVariant.primary,
                  label: 'PASSWORT ÄNDERN',
                  onPressed: () async {
                    if (newPasswordController.text !=
                        repeatPasswordController.text) {
                      informationDialog(
                        context,
                        'Passwörter stimmen nicht überein',
                        'Die neuen Passwörter müssen identisch sein.',
                      );
                      return;
                    }

                    if (oldPasswordController.text.isEmpty) {
                      informationDialog(
                        context,
                        'Aktuelles Passwort erforderlich',
                        'Bitte geben Sie Ihr aktuelles Passwort ein.',
                      );
                      return;
                    }

                    if (newPasswordController.text.isEmpty) {
                      informationDialog(
                        context,
                        'Neues Passwort erforderlich',
                        'Bitte geben Sie ein neues Passwort ein.',
                      );
                      return;
                    }

                    if (oldPasswordController.text ==
                        newPasswordController.text) {
                      informationDialog(
                        context,
                        'Passwort identisch',
                        'Das neue Passwort muss sich vom aktuellen Passwort unterscheiden.',
                      );
                      return;
                    }

                    await userManager.changePassword(
                      oldPasswordController.text,
                      newPasswordController.text,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
                const Gap(15),
                Button(
                  variant: ButtonVariant.secondary,
                  label: 'ABBRECHEN',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
