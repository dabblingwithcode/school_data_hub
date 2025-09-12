import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

final _userManager = di<UserManager>();

/// A page for users to change their password.
///
/// Usage example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const UserChangePasswordPage(),
///   ),
/// );
/// ```
class UserChangePasswordPage extends WatchingWidget {
  const UserChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_reset, size: 25, color: Colors.white),
            Gap(10),
            Text('Passwort ändern', style: AppStyles.appBarTextStyle),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Gap(40),
                Row(
                  children: [
                    const Text(
                      'Aktuelles Passwort:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                    const Text(
                      'Neues Passwort:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                    const Text(
                      'Neues Passwort wiederholen:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () async {
                    // Validate that new passwords match
                    if (newPasswordController.text !=
                        repeatPasswordController.text) {
                      informationDialog(
                        context,
                        'Passwörter stimmen nicht überein',
                        'Die neuen Passwörter müssen identisch sein.',
                      );
                      return;
                    }

                    // Validate that old password is provided
                    if (oldPasswordController.text.isEmpty) {
                      informationDialog(
                        context,
                        'Aktuelles Passwort erforderlich',
                        'Bitte geben Sie Ihr aktuelles Passwort ein.',
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

                    // Validate that old and new passwords are different
                    if (oldPasswordController.text ==
                        newPasswordController.text) {
                      informationDialog(
                        context,
                        'Passwort identisch',
                        'Das neue Passwort muss sich vom aktuellen Passwort unterscheiden.',
                      );
                      return;
                    }

                    // Call the user manager to change password
                    await _userManager.changePassword(
                      oldPasswordController.text,
                      newPasswordController.text,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'PASSWORT ÄNDERN',
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
