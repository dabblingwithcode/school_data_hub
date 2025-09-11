import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:watch_it/watch_it.dart';

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/
final _pupilManager = di<PupilManager>();
final _hubSessionManager = di<HubSessionManager>();

Future<void> preschoolRevisionDialog(
  BuildContext context,
  PupilProxy pupil,
  PreSchoolMedicalStatus? value,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      PreSchoolMedicalStatus dialogdropdownValue =
          value ?? PreSchoolMedicalStatus.notAvailable;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<PreSchoolMedicalStatus>(
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        value: dialogdropdownValue,
                        items: const [
                          DropdownMenuItem(
                            value: PreSchoolMedicalStatus.notAvailable,
                            child: Center(
                              child: Text(
                                "nicht vorhanden",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: PreSchoolMedicalStatus.ok,
                            child: Center(
                              child: Text(
                                "unauffällig",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: PreSchoolMedicalStatus.supportAreas,
                            child: Center(
                              child: Text(
                                "Förderbedarf",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: PreSchoolMedicalStatus.checkSpecialSupport,
                            child: Center(
                              child: Text(
                                "AO-SF prüfen",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (newvalue) {
                          setState(() {
                            dialogdropdownValue = newvalue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: const Text('Eingangsuntersuchung'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'ABBRECHEN',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    await PupilMutator().updatePreSchoolMedicalStatus(
                      pupilId: pupil.pupilId,
                      preSchoolMedicalStatus: dialogdropdownValue,
                      createdBy: _hubSessionManager.userName!,
                    );

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
