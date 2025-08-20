import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_page.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:watch_it/watch_it.dart';

final _envManager = di<EnvManager>();
final _notificationService = di<NotificationService>();

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
      _envManager.importNewEnv(scanResponse);

      return;
    } else {
      _notificationService.showSnackBar(
          NotificationType.warning, 'Keine Daten gescannt');
      return;
    }
  }

  Future<void> importEnvFromTxt() async {
    FilePickerResult? result =await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      _envManager.importNewEnv(rawTextResult);

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EntryPointPage(
      controller: this,
    );
  }
}
