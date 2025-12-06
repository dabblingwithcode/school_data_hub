import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:watch_it/watch_it.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/
Future<void> preschoolRevisionDialog(
  BuildContext context,
  PupilProxy pupil,
  PreSchoolMedicalStatus? value,
) async {
  final _hubSessionManager = di<HubSessionManager>();
  return await showDialog(
    context: context,
    builder: (context) {
      PreSchoolMedicalStatus dialogdropdownValue =
          value ?? PreSchoolMedicalStatus.notAvailable;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status description
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                        dialogdropdownValue,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getStatusColor(
                          dialogdropdownValue,
                        ).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: _getStatusColor(dialogdropdownValue),
                          size: 20,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            _getStatusDescription(dialogdropdownValue),
                            style: TextStyle(
                              fontSize: 14,
                              color: _getStatusColor(dialogdropdownValue),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                  // Dropdown
                  DropdownButtonFormField<PreSchoolMedicalStatus>(
                    initialValue: dialogdropdownValue,
                    decoration: const InputDecoration(
                      labelText: 'Status der Eingangsuntersuchung',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: PreSchoolMedicalStatus.notAvailable,
                        child: Text("nicht vorhanden"),
                      ),
                      DropdownMenuItem(
                        value: PreSchoolMedicalStatus.ok,
                        child: Text("unauffällig"),
                      ),
                      DropdownMenuItem(
                        value: PreSchoolMedicalStatus.supportAreas,
                        child: Text("Förderbedarf"),
                      ),
                      DropdownMenuItem(
                        value: PreSchoolMedicalStatus.checkSpecialSupport,
                        child: Text("AO-SF prüfen"),
                      ),
                    ],
                    onChanged: (newvalue) {
                      setState(() {
                        dialogdropdownValue = newvalue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.medical_services,
                  color: AppColors.accentColor,
                  size: 24,
                ),
                const Gap(8),
                const Text('Eingangsuntersuchung'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'ABBRECHEN',
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await PupilMutator().updatePreSchoolMedicalStatus(
                    pupilId: pupil.pupilId,
                    preSchoolMedicalStatus: dialogdropdownValue,
                    createdBy: _hubSessionManager.userName!,
                  );

                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'SPEICHERN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Color _getStatusColor(PreSchoolMedicalStatus status) {
  switch (status) {
    case PreSchoolMedicalStatus.notAvailable:
      return Colors.grey;
    case PreSchoolMedicalStatus.ok:
      return Colors.green;
    case PreSchoolMedicalStatus.supportAreas:
      return Colors.orange;
    case PreSchoolMedicalStatus.checkSpecialSupport:
      return Colors.red;
  }
}

String _getStatusDescription(PreSchoolMedicalStatus status) {
  switch (status) {
    case PreSchoolMedicalStatus.notAvailable:
      return 'Die Eingangsuntersuchung ist noch nicht durchgeführt worden oder nicht verfügbar.';
    case PreSchoolMedicalStatus.ok:
      return 'Die Eingangsuntersuchung wurde durchgeführt und keine Auffälligkeiten festgestellt.';
    case PreSchoolMedicalStatus.supportAreas:
      return 'Bei der Eingangsuntersuchung wurden Förderbereiche identifiziert, die Unterstützung benötigen.';
    case PreSchoolMedicalStatus.checkSpecialSupport:
      return 'Es wird empfohlen, eine Überprüfung auf sonderpädagogischen Förderbedarf (AO-SF) durchzuführen.';
  }
}
