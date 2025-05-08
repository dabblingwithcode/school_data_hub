import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/barcode_stream_scanner.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_image_picker.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:watch_it/watch_it.dart';

final _pupilIdentityManager = di<PupilIdentityManager>();
final _sessionManager = di<ServerpodSessionManager>();

class ScanToolsPage extends WatchingWidget {
  const ScanToolsPage({super.key});

  importFileWithWindows(String function) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      if (function == 'update_backend') {
        _pupilIdentityManager
            .updateBackendPupilsFromSchoolPupilIdentitySource(rawTextResult);
      } else if (function == 'pupil_identities') {
        _pupilIdentityManager.addOrUpdateNewPupilIdentities(
            identitiesInStringLines: rawTextResult);
      }
    } else {
      // User canceled the picker
      return;
    }
  }

  importFromQrImage() async {
    final rawTextResult = await scanPickedQrImage();
    if (rawTextResult == null) {
      return;
    }
    _pupilIdentityManager.decryptAndAddOrUpdatePupilIdentities([rawTextResult]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Scan-Tools',
          style: AppStyles.appBarTextStyle,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Spacer(),
                (Platform.isWindows || Platform.isMacOS) && _sessionManager.isAdmin
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.amber[800],
                            minimumSize: const Size.fromHeight(90)),
                        onPressed: () async {
                          final bool? confirm = await confirmationDialog(
                              context: context,
                              title: 'Datenbank aus SchiLD importieren',
                              message:
                                  'Achtung! Nicht mehr vorhandene SchülerInnen auf dem Server werden gelöscht. Fortfahren?');
                          if (confirm == true) {
                            importFileWithWindows('update_backend');
                          }
                        },
                        child: const Text(
                          'Daten aus SchiLD importieren',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      )
                    : const SizedBox.shrink(),
                if (Platform.isWindows || Platform.isMacOS) ...<Widget>[
                  const Gap(20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.amber[800],
                        minimumSize: const Size.fromHeight(90)),
                    onPressed: () async {
                      importFromQrImage();
                    },
                    child: const Text(
                      'Daten aus QR-Bilddatei importieren',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  const Gap(20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.amber[800],
                          minimumSize: const Size.fromHeight(90)),
                      onPressed: () =>
                          importFileWithWindows('pupil_identities'),
                      child: const Text(
                        'ID-Liste importieren',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ))
                ],
                if (Platform.isAndroid || Platform.isIOS)
                  Container(
                    height: 90,
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: FloatingActionButton.extended(
                      heroTag: 'tag',
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      backgroundColor: AppColors.accentColor,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const BarcodeStreamScanner(),
                        ));
                      },
                      label: const Text(
                        'alle Kinder-IDs scannen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      icon: const Icon(Icons.note_add),
                    ),
                  ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
