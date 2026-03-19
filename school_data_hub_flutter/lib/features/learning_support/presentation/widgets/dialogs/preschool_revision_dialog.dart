import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/
Future<void> preschoolRevisionDialog(
  BuildContext context,
  PupilProxy pupil,
  PreSchoolMedicalStatus? value,
) async {
  final hubSessionManager = di<HubSessionManager>();
  return await showDialog(
    context: context,
    builder: (context) {
      PreSchoolMedicalStatus dialogdropdownValue =
          value ?? PreSchoolMedicalStatus.notAvailable;

      return StatefulBuilder(
        builder: (context, setState) {
          final style = Style.of(context);
          return AlertDialog(
            contentPadding: EdgeInsets.all(Style.spacing.xl),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status description
                  Container(
                    padding: EdgeInsets.all(Style.spacing.md),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                        dialogdropdownValue,
                        style,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Style.radii.small),
                      border: Border.all(
                        color: _getStatusColor(
                          dialogdropdownValue,
                          style,
                        ).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: _getStatusColor(dialogdropdownValue, style),
                          size: 20,
                        ),
                        Gap(Style.spacing.sm),
                        Expanded(
                          child: Text(
                            _getStatusDescription(dialogdropdownValue),
                            style: context.typography.body.w500.withColor(
                              _getStatusColor(dialogdropdownValue, style),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(Style.spacing.lg),
                  // Dropdown
                  DropdownButtonFormField<PreSchoolMedicalStatus>(
                    initialValue: dialogdropdownValue,
                    decoration: InputDecoration(
                      labelText: 'Status der Eingangsuntersuchung',
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Style.spacing.md,
                        vertical: Style.spacing.sm,
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
                  color: style.colors.accent,
                  size: 24,
                ),
                Gap(Style.spacing.sm),
                const Text('Eingangsuntersuchung'),
              ],
            ),
            actions: <Widget>[
              Button.small(
                variant: ButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pop(),
                label: 'ABBRECHEN',
              ),
              Button.small(
                onPressed: () async {
                  await PupilMutator().updatePreSchoolMedicalStatus(
                    pupilId: pupil.pupilId,
                    preSchoolMedicalStatus: dialogdropdownValue,
                    createdBy: hubSessionManager.userName!,
                  );

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                label: 'SPEICHERN',
              ),
            ],
          );
        },
      );
    },
  );
}

Color _getStatusColor(PreSchoolMedicalStatus status, Style style) {
  switch (status) {
    case PreSchoolMedicalStatus.notAvailable:
      return style.colors.mutedForeground;
    case PreSchoolMedicalStatus.ok:
      return style.colors.success;
    case PreSchoolMedicalStatus.supportAreas:
      return style.colors.warning;
    case PreSchoolMedicalStatus.checkSpecialSupport:
      return style.colors.error;
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
