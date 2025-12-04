import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/user/presentation/reset_password/widgets/user_selection_dropdown.dart';
import 'package:watch_it/watch_it.dart';

/// A page for admins to reset a user's password.
///
/// Usage example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const ResetUserPasswordPage(),
///   ),
/// );
/// ```
class ResetUserPasswordPage extends WatchingWidget {
  const ResetUserPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _userManager = di<UserManager>();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 25, color: Colors.white),
            Gap(10),
            Text(
              'Benutzer-Passwort zurücksetzen',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Gap(20),
                const Text(
                  'Benutzer auswählen:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                const Text(
                  'Neues Passwort:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                const Text(
                  'Neues Passwort wiederholen:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () async {
                    // Validate user selection
                    if (watchedSelectedUser == null) {
                      informationDialog(
                        context,
                        'Benutzer auswählen',
                        'Bitte wählen Sie einen Benutzer aus.',
                      );
                      return;
                    }

                    // Validate password matching
                    if (newPasswordController.text !=
                        repeatPasswordController.text) {
                      informationDialog(
                        context,
                        'Passwörter stimmen nicht überein',
                        'Die neuen Passwörter müssen identisch sein.',
                      );
                      return;
                    }

                    // Validate that new password is provided
                    if (newPasswordController.text.isEmpty) {
                      informationDialog(
                        context,
                        'Neues Passwort erforderlich',
                        'Bitte geben Sie ein neues Passwort ein.',
                      );
                      return;
                    }

                    // Validate minimum password length
                    if (newPasswordController.text.length < 6) {
                      informationDialog(
                        context,
                        'Passwort zu kurz',
                        'Das Passwort muss mindestens 6 Zeichen lang sein.',
                      );
                      return;
                    }

                    // Get user email for the reset
                    final userEmail = watchedSelectedUser.userInfo?.email;
                    if (userEmail == null || userEmail.isEmpty) {
                      informationDialog(
                        context,
                        'Benutzer-E-Mail fehlt',
                        'Der ausgewählte Benutzer hat keine E-Mail-Adresse.',
                      );
                      return;
                    }

                    // Call the user manager to reset password
                    await _userManager.resetPassword(
                      userEmail,
                      newPasswordController.text,
                    );

                    if (context.mounted) {
                      // Clear form
                      selectedUser.value = null;
                      newPasswordController.clear();
                      repeatPasswordController.clear();

                      // Show success message and navigate back
                      informationDialog(
                        context,
                        'Passwort zurückgesetzt',
                        'Das Passwort wurde erfolgreich für ${watchedSelectedUser.userInfo?.fullName ?? 'den Benutzer'} zurückgesetzt.',
                      );
                    }
                  },
                  child: const Text(
                    'PASSWORT ZURÜCKSETZEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
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
