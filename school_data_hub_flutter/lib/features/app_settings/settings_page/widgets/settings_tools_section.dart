import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/birthdays_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/pupil_identity_stream_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:watch_it/watch_it.dart';

class SettingsToolsSection extends AbstractSettingsSection {
  const SettingsToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Tools',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          leading: const Icon(Icons.bar_chart_rounded),
          title: const Text('Statistik-Zahlen ansehen'),
          onPressed: (context) {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (ctx) => const Statistics(),
            // ));
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.cake_rounded),
          title: const Text('vergangene Geburtstage seit einem Datum'),
          onPressed: (context) async {
            final DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (selectedDate == null) {
              return;
            }
            if (context.mounted) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => BirthdaysView(
                  selectedDate: selectedDate,
                ),
              ));
            }
          },
        ),
        SettingsTile.navigation(
            leading: const Icon(Icons.qr_code_rounded),
            title: const Text('QR-Ids von ausgewählten Kindern zeigen'),
            onPressed: (context) async {
              final List<int>? pupilIds =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => SelectPupilsListPage(
                    selectablePupils: di<PupilManager>()
                        .getPupilsFromInternalIds(
                            di<PupilIdentityManager>().availablePupilIds)),
              ));
              if (pupilIds == null || pupilIds.isEmpty) {
                return;
              }
              final internalIds =
                  di<PupilManager>().getInternalIdsFromPupilIds(pupilIds);
              final String encryptedPupilIdentities =
                  await di<PupilIdentityManager>()
                      .generatePupilIdentitiesQrData(internalIds);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PupilIdentityStreamPage(
                    role: PupilIdentityStreamRole.sender,
                    encryptedData: encryptedPupilIdentities,
                    selectedPupilIds: pupilIds,
                  ),
                ),
              );
            }),
        // SettingsTile.navigation(
        //     leading: const Icon(Icons.qr_code_rounded),
        //     title: const Text('Alle vorhandenen QR-Ids zeigen (autoplay)'),
        //     onPressed: (context) async {
        //       final List<Map<String, Object>> qrData = _pupilIdentityManager
        //           .generateAllPupilIdentitiesQrData(pupilsPerCode: 8);

        //       Navigator.of(context).push(MaterialPageRoute(
        //         builder: (ctx) => QrCodeSpeedShow(qrMaps: qrData),
        //       ));
        //     }),
        // SettingsTile.navigation(
        //     leading: const Icon(Icons.qr_code_rounded),
        //     title:
        //         const Text('Alle vorhandenen QR-Ids zeigen (manuelle slides)'),
        //     onPressed: (context) async {
        //       final qrDataMaps = _pupilIdentityManager
        //           .generateAllPupilIdentitiesQrData(pupilsPerCode: 8);
        //       final qrData = qrDataMaps[1] as Map<String, String>;

        //       showQrCarouselWithController(qrData, context);
        //     }),
      ],
    );
  }
}
