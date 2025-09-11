import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/pick_file_return_content_as_string.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/qr/qr_image_picker.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/pupil_identity_stream_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_page/timetable_page.dart';
import 'package:watch_it/watch_it.dart';

final _pupilIdentityManager = di<PupilIdentityManager>();
final _hubSessionManager = di<HubSessionManager>();

class ToolsPage extends WatchingWidget {
  const ToolsPage({super.key});

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
      appBar: const GenericAppBar(
        iconData: Icons.build_rounded,
        title: 'Tools',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(20),

                  // Main transfer button
                  _buildToolButton(
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
                    onLongPress:
                        Platform.isAndroid || Platform.isIOS
                            ? () async {
                              final channelName = await shortTextfieldDialog(
                                context: context,
                                title: 'Verbindungscode eingeben',
                                hintText: 'z.B. 12345678',
                                labelText: 'Verbindungscode',
                              );
                              if (channelName == null || channelName.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Kein gültiger Verbindungscode.',
                                    ),
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
                            : null,
                    icon: Icons.mobile_screen_share,
                    title: 'Schülerdaten von einem anderen Gerät übertragen',
                    subtitle: 'QR-Code scannen oder Verbindungscode eingeben',
                    color: Colors.blue[700]!,
                  ),

                  const Gap(16),

                  // Admin section
                  if (_hubSessionManager.isAdmin) ...[
                    _buildSectionHeader('Administration'),

                    _buildToolButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TimetablePage(),
                          ),
                        );
                      },
                      icon: Icons.schedule,
                      title: 'Stundenplan verwalten',
                      subtitle: 'Timetables und Lerngruppen verwalten',
                      color: Colors.green[700]!,
                    ),

                    const Gap(16),

                    _buildToolButton(
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
                      icon: Icons.file_upload,
                      title: 'Daten aus JSON importieren',
                      subtitle: 'Support-Levels und andere Daten importieren',
                      color: Colors.orange[700]!,
                    ),

                    const Gap(16),
                  ],

                  // Desktop-only section
                  if (Platform.isWindows || Platform.isMacOS) ...[
                    _buildSectionHeader('Desktop Tools'),

                    _buildToolButton(
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
                      icon: Icons.school,
                      title: 'Daten aus SchiLD importieren',
                      subtitle: 'Schülerdaten aus SchiLD-Export importieren',
                      color: Colors.purple[700]!,
                    ),

                    const Gap(16),

                    _buildToolButton(
                      onPressed: () async {
                        importFromQrImage();
                      },
                      icon: Icons.qr_code_scanner,
                      title: 'Daten aus QR-Bilddatei importieren',
                      subtitle: 'QR-Code aus Bilddatei scannen',
                      color: Colors.teal[700]!,
                    ),

                    const Gap(16),

                    _buildToolButton(
                      onPressed:
                          () => importFileWithWindows('pupil_identities'),
                      icon: Icons.people,
                      title: 'ID-Liste importieren',
                      subtitle: 'Schüler-Identitäten aus Datei importieren',
                      color: Colors.indigo[700]!,
                    ),

                    const Gap(16),
                  ],

                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 28, color: Colors.white),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
