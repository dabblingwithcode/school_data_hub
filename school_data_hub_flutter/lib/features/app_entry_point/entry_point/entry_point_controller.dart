import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_page.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class EntryPoint extends WatchingStatefulWidget {
  const EntryPoint({super.key});

  @override
  EntryPointController createState() => EntryPointController();
}

class EntryPointController extends State<EntryPoint> {
  final _envManager = di<EnvManager>();
  final _notificationService = di<NotificationManager>();

  Future<void> importEnvDataFromQrCode(BuildContext context) async {
    final locale = AppLocalizations.of(context)!;
    final String? scanResponse = await qrScanner(
      context: context,
      overlayText: locale.scanSchoolId,
    );
    if (scanResponse != null) {
      _envManager.importNewEnv(scanResponse);

      return;
    } else {
      _notificationService.showSnackBar(
        NotificationType.warning,
        'Keine Daten gescannt',
      );
      return;
    }
  }

  Future<void> importEnvFromTxtFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      _envManager.importNewEnv(rawTextResult);

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EntryPointScreen(controller: this);
  }
}
