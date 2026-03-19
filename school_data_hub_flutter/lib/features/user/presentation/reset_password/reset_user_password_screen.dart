import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/reset_password/widgets/user_selection_dropdown.dart';
import 'package:flutter_it/flutter_it.dart';

/// A screen for admins to reset a user's password.
class ResetUserPasswordScreen extends WatchingWidget {
  const ResetUserPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final userManager = di<UserManager>();
    final selectedUser = createOnce(() => ValueNotifier<User?>(null));
    final TextEditingController newPasswordController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController repeatPasswordController = createOnce(
      () => TextEditingController(),
    );

    final watchedSelectedUser = watch(selectedUser).value;
    final List<User> allUsers = watchValue((UserManager x) => x.users);

    return Scaffold(
      backgroundColor: style.colors.background,
      appBar: const AppHeader(
        iconData: Icons.admin_panel_settings,
        title: 'Benutzer-Passwort zurücksetzen',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Gap(20),
                Text(
                  'Benutzer auswählen:',
                  style: context.typography.title,
                ),
                const Gap(10),
                UserSelectionDropdown(
                  selectedUser: watchedSelectedUser,
                  users: allUsers,
                  onUserChanged: (User? newValue) {
                    selectedUser.value = newValue;
                  },
                ),
                const Gap(30),
                Text(
                  'Neues Passwort:',
                  style: context.typography.title,
                ),
                const Gap(10),
                TextField(
                  minLines: 1,
                  maxLines: 1,
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Neues Passwort',
                  ),
                ),
                const Gap(20),
                Text(
                  'Neues Passwort wiederholen:',
                  style: context.typography.title,
                ),
                const Gap(10),
                TextField(
                  minLines: 1,
                  maxLines: 1,
                  controller: repeatPasswordController,
                  obscureText: true,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Neues Passwort wiederholen',
                  ),
                ),
                const Spacer(),
                const Gap(15),
                Button(
                  variant: ButtonVariant.primary,
                  label: 'PASSWORT ZURÜCKSETZEN',
                  onPressed: () async {
                    if (watchedSelectedUser == null) {
                      informationDialog(
                        context,
                        'Benutzer auswählen',
                        'Bitte wählen Sie einen Benutzer aus.',
                      );
                      return;
                    }

                    if (newPasswordController.text !=
                        repeatPasswordController.text) {
                      informationDialog(
                        context,
                        'Passwörter stimmen nicht überein',
                        'Die neuen Passwörter müssen identisch sein.',
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

                    if (newPasswordController.text.length < 6) {
                      informationDialog(
                        context,
                        'Passwort zu kurz',
                        'Das Passwort muss mindestens 6 Zeichen lang sein.',
                      );
                      return;
                    }

                    final userEmail = watchedSelectedUser.userInfo?.email;
                    if (userEmail == null || userEmail.isEmpty) {
                      informationDialog(
                        context,
                        'Benutzer-E-Mail fehlt',
                        'Der ausgewählte Benutzer hat keine E-Mail-Adresse.',
                      );
                      return;
                    }

                    await userManager.resetPassword(
                      userEmail,
                      newPasswordController.text,
                    );

                    if (context.mounted) {
                      selectedUser.value = null;
                      newPasswordController.clear();
                      repeatPasswordController.clear();

                      informationDialog(
                        context,
                        'Passwort zurückgesetzt',
                        'Das Passwort wurde erfolgreich für ${watchedSelectedUser.userInfo?.fullName ?? 'den Benutzer'} zurückgesetzt.',
                      );
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
