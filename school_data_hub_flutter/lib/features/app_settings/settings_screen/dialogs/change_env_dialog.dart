import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/env/models/env.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';

final _envManager = di<EnvManager>();

Future<bool?> changeEnvironmentDialog({required BuildContext context}) async {
  final log = Logger('ChangeEnvDialog');
  final style = Style.of(context);
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      final List<Env> envs = _envManager.envs.values.toList();
      return AlertDialog(
        title: Text(
          'Instanz auswählen',
          style: context.typography.title,
        ),
        content: SizedBox(
          height: 200,
          width: 300,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: Style.spacing.xs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      child: Text(
                        envs[index].serverName,
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.interactiveColor,
                        ),
                      ),
                      onPressed: () async {
                        if (envs[index].serverName ==
                            _envManager.activeEnv?.serverName) {
                          return;
                        }

                        final confirmation = await confirmationDialog(
                          context: context,
                          title: 'Instanz wechseln',
                          message: 'Möchten Sie wirklich die Instanz wechseln?',
                        );
                        if (confirmation != true) return;
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          _envManager.activateDifferentEnv(
                            envName: envs[index].serverName,
                          );
                        }
                      },
                      onLongPress: () async {
                        final confirmation = await confirmationDialog(
                          context: context,
                          title: 'Instanz löschen',
                          message: 'Möchten Sie wirklich die Instanz löschen?',
                        );
                        if (confirmation != true) return;
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        if (envs[index].serverName ==
                            _envManager.activeEnv?.serverName) {
                          await _envManager.deleteEnv();
                        } else {
                          await _envManager.deleteNotActivatedEnv(envs[index]);
                        }
                      },
                    ),
                    const Gap(10),
                    _envManager.activeEnv?.serverName == envs[index].serverName
                        ? Icon(
                            Icons.check,
                            color: style.colors.success,
                            weight: 20,
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            },
            itemCount: envs.length,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(Style.spacing.xs),
            child: Button(
              variant: ButtonVariant.primary,
              onPressed: () async {
                Navigator.of(context).pop();
                log.info(
                  '[DI] User wants to add a new environment frpm the dialog: dropping logged in user scope first',
                );
                InitManager.dropOnLoggedInUserScope();
                log.warning(
                  '[DI] User signed out, setting env not ready from the dialog',
                );
                _envManager.deactivateEnv();
              },
              label: 'NEUE INSTANZ',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Style.spacing.xs),
            child: Button(
              variant: ButtonVariant.destructive,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              label: 'ABBRECHEN',
            ),
          ),
        ],
      );
    },
  );
}
