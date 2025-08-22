import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/features/user/presentation/widgets/roles_dropdown.dart';
import 'package:watch_it/watch_it.dart';

class CreateUserPage extends WatchingWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController userNameController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController passwordController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController repeatPasswordController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController contactController = createOnce(
      () => TextEditingController(),
    );
    final setAsAdmin = createOnce(() => ValueNotifier<bool>(false));
    final role = createOnce(() => ValueNotifier<Role>(Role.notAssigned));
    void changeRole(Role? newRole) {
      role.value = newRole!;
    }

    final TextEditingController timeUnitsController = createOnce(
      () => TextEditingController(),
    );
    final TextEditingController creditController = createOnce(
      () => TextEditingController(),
    );
    // final TextEditingController tutoringController =
    //     createOnce(() => TextEditingController());

    final watchedSetAsAdmin = watch(setAsAdmin).value;
    final watchedRole = watch(role).value;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_box_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text('Neues Team-Konto', style: AppStyles.appBarTextStyle),
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
                Row(
                  children: [
                    const Text(
                      'Name:',
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
                        controller: fullNameController,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Name',
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Add this
                  children: <Widget>[
                    const Text(
                      'Kürzel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    SizedBox(
                      width: 70,
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        controller: userNameController,
                        inputFormatters: [LengthLimitingTextInputFormatter(3)],
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Kürzel',
                        ),
                      ),
                    ),
                    const Gap(15),
                    const Text(
                      'Ist Admin:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: watchedSetAsAdmin,
                      onChanged: (bool? newValue) {
                        setAsAdmin.value = newValue ?? false;
                      },
                    ),
                    const Gap(5),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    const Text(
                      'Passwort:',
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
                        controller: passwordController,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Passwort',
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    const Text(
                      'Passwort wiederholen:',
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
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Passwort wiederholen',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RolesDropdown(
                      selectedRole: watchedRole,
                      changeRole: changeRole,
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    const Text(
                      'Kontakt:',
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
                        controller: contactController,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Kontakt',
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    const Text(
                      'Guthaben:',
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
                        controller: creditController,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Guthaben',
                        ),
                      ),
                    ),
                    const Gap(15),
                    const Text(
                      'Stunden:',
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
                        controller: timeUnitsController,
                        decoration: AppStyles.textFieldDecoration(
                          labelText: 'Stunden',
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
                    if (passwordController.text !=
                        repeatPasswordController.text) {
                      informationDialog(
                        context,
                        'Passwörter stimmen nicht überein',
                        'Bitte Passwort überprüfen',
                      );
                      return;
                    }
                    // TODO: refactor this and put it in a manager
                    await di<Client>().admin.createUser(
                      userName: userNameController.text,
                      fullName: fullNameController.text,
                      email: contactController.text,
                      password: passwordController.text,
                      role: role.value,
                      timeUnits: int.tryParse(timeUnitsController.text)!,
                      scopeNames: [],
                    );
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('SENDEN', style: AppStyles.buttonTextStyle),
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
