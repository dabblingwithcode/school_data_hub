import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pick_file_return_content_as_string.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_image_picker.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/pupil_identity_stream_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_page/timetable_page.dart';
import 'package:watch_it/watch_it.dart';

final _pupilIdentityManager = di<PupilIdentityManager>();
final _hubSessionManager = di<HubSessionManager>();

class ScanToolsPage extends WatchingWidget {
  const ScanToolsPage({super.key});

  void importFileWithWindows(String function) async {
    final fileContent = await pickFileReturnContentAsString();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null || fileContent == null) {
      // User canceled the picker
      return;
    }

    if (function == 'update_backend') {
      _pupilIdentityManager.updateBackendPupilsFromSchoolPupilIdentitySource(
        fileContent,
      );
    } else if (function == 'pupil_identities') {
      _pupilIdentityManager.addOrUpdateNewPupilIdentities(
        identitiesInStringLines: fileContent,
      );
    }
  }

  void importFromQrImage() async {
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
        title: const Text('Scan-Tools', style: AppStyles.appBarTextStyle),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(90),
                    ),
                    onLongPress: () async {
                      if (Platform.isAndroid || Platform.isIOS) {
                        final channelName = await shortTextfieldDialog(
                          context: context,
                          title: 'Verbindungscode eingeben',
                          hintText: 'z.B. 12345678',
                          labelText: 'Verbindungscode',
                        );
                        if (channelName == null || channelName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kein gültiger Verbindungscode.'),
                            ),
                          );
                          return;
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => PupilIdentityStreamPage(
                                  role: PupilIdentityStreamRole.receiver,
                                  importedChannelName: channelName,
                                ),
                          ),
                        );
                      }
                    },
                    onPressed: () async {
                      String? channelName;
                      if (!Platform.isWindows && !Platform.isMacOS) {
                        channelName = await qrScanner(
                          context: context,
                          overlayText: "Bitte Verbindungscode scannen",
                        );
                      } else {
                        channelName = await shortTextfieldDialog(
                          context: context,
                          title: 'Verbindungscode eingeben',
                          hintText: 'z.B. 12345678',
                          labelText: 'Verbindungscode',
                        );
                      }

                      if (channelName == null || channelName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Kein gültiger Verbindungscode.'),
                          ),
                        );
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => PupilIdentityStreamPage(
                                role: PupilIdentityStreamRole.receiver,
                                importedChannelName: channelName,
                              ),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.mobile_screen_share,
                          size: 30,
                          color: Colors.white,
                        ),
                        const Icon(
                          Icons.mobile_friendly_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        const Gap(10),
                        const Text(
                          'Schülerdaten von einem anderen Gerät übertragen',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_hubSessionManager.isAdmin) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(90),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TimetablePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Stundenplan verwalten',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(90),
                    ),
                    onPressed: () async {
                      final bool? confirm = await confirmationDialog(
                        context: context,
                        title: 'Datenbank aus json importieren',
                        message: 'Json importieren?',
                      );
                      if (confirm == true) {
                        di<PupilManager>().importSupportLevelsFromJson();
                      }
                    },
                    child: const Text(
                      'Daten aus json importieren',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                const Gap(20),
                (Platform.isWindows || Platform.isMacOS)
                    // &&                        _sessionManager.isAdmin
                    ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.amber[800],
                        minimumSize: const Size.fromHeight(90),
                      ),
                      onPressed: () async {
                        final bool? confirm = await confirmationDialog(
                          context: context,
                          title: 'Datenbank aus SchiLD importieren',
                          message:
                              'Achtung! Nicht mehr vorhandene SchülerInnen auf dem Server werden gelöscht. Fortfahren?',
                        );
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
                          color: Colors.white,
                        ),
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
                      minimumSize: const Size.fromHeight(90),
                    ),
                    onPressed: () async {
                      importFromQrImage();
                    },
                    child: const Text(
                      'Daten aus QR-Bilddatei importieren',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(90),
                    ),
                    onPressed: () => importFileWithWindows('pupil_identities'),
                    child: const Text(
                      'ID-Liste importieren',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],

                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
