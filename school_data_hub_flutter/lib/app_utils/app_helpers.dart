import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/core/env/utils/env_utils.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/widgets/new_environment_keys_dialog.dart';

class AppHelpers {
  static void generateSchoolKeys(BuildContext context) async {
    final schoolKeysData = await showNewEnvKeysDialog(context);
    if (schoolKeysData == null) {
      return;
    }
    await EnvUtils.generateNewEnvKeys(
        serverName: schoolKeysData.serverName,
        serverUrl: schoolKeysData.serverUrl,
        hubRunMode: schoolKeysData.hubRunMode);
  }
}
