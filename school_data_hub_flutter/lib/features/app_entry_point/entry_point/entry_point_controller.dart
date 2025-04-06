import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/env/utils/env_utils.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_page.dart';
import 'package:watch_it/watch_it.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  EntryPointController createState() => EntryPointController();
}

class EntryPointController extends State<EntryPoint> {
  scanEnv(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    final String? scanResponse =
        await qrScanner(context: context, overlayText: locale.scanSchoolId);
    if (scanResponse != null) {
      di<EnvManager>().importNewEnv(scanResponse);

      return;
    } else {
      di<NotificationService>()
          .showSnackBar(NotificationType.warning, 'Keine Daten gescannt');
      return;
    }
  }

  Future<void> importEnvFromTxt() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      di<EnvManager>().importNewEnv(rawTextResult);

      return;
    }
  }

  Future<void> generateSchoolKeys(BuildContext context) async {
    final serverName = await shortTextfieldDialog(
        context: context,
        title: 'Servername',
        labelText: 'Servername',
        hintText: 'Geben Sie dem Server einen Namen');
    if (serverName == null || serverName.isEmpty) {
      return;
    }
    final serverUrl = await shortTextfieldDialog(
        context: context,
        title: 'Server URL',
        labelText: 'Server URL',
        hintText: 'Geben Sie die URL des Servers ein');
    if (serverUrl == null || serverUrl.isEmpty) {
      return;
    }
    await EnvUtils.generateNewEnvKeys(
        serverName: serverName, serverUrl: serverUrl);

    di<NotificationService>().showSnackBar(
        NotificationType.success, 'Schulschlüssel erfolgreich generiert');
  }

  @override
  Widget build(BuildContext context) {
    return EntryPointPage(
      controller: this,
    );
  }
}
