import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/core/env/models/env.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:watch_it/watch_it.dart';

Future<bool?> changeEnvironmentDialog({
  required BuildContext context,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      final List<Env> envs = di<EnvManager>().envs.values.toList();
      return AlertDialog(
        title: const Text('Instanz auswählen',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          height: 200,
          width: 300,
          child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: Text(
                          envs[index].name,
                          style: const TextStyle(
                              fontSize: 20, color: AppColors.interactiveColor),
                        ),
                        onPressed: () async {
                          if (envs[index].name ==
                              di<EnvManager>().activeEnv?.name) {
                            return;
                          }

                          final confirmation = await confirmationDialog(
                              context: context,
                              title: 'Instanz wechseln',
                              message:
                                  'Möchten Sie wirklich die Instanz wechseln?');
                          if (confirmation != true) return;
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            di<EnvManager>()
                                .activateEnv(envName: envs[index].name);
                          }
                        },
                      ),
                      const Gap(10),
                      di<EnvManager>().activeEnv?.name == envs[index].name
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                              weight: 20,
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              },
              itemCount: envs.length),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: AppStyles.successButtonStyle,
              onPressed: () {
                Navigator.of(context).pop();

                // di<SessionManager>().setSessionNotAuthenticated();
                di<EnvManager>().setEnvNotReady();
              }, // Add onPressed
              child: const Text(
                "NEUE INSTANZ",
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: AppStyles.cancelButtonStyle,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "ABBRECHEN",
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ),
        ],
      );
    },
  );
}
