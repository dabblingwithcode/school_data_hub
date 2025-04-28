import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/dialogs/language_dialog_dropdown.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/
// TODO: It must be a better way to do this

Future<void> languageDialog(
    BuildContext context, PupilProxy pupil, String type, String? value) async {
  String languageValue = value ?? '000';

  return await showDialog(
      context: context,
      builder: (context) {
        String dropdownUnderstandValue = languageValue.substring(0, 1);
        String dropdownSpeakValue = languageValue.substring(1, 2);
        String dropdownReadValue = languageValue.substring(2, 3);

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: SizedBox(
                width: 700,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LanguageDialogDropdown(
                      value: dropdownUnderstandValue,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownUnderstandValue = newValue!;
                        });
                      },
                      label: "Versteht",
                      icon: Icons.hearing,
                    ),
                    LanguageDialogDropdown(
                      value: dropdownSpeakValue,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownSpeakValue = newValue!;
                        });
                      },
                      label: "spricht",
                      icon: Icons.chat_bubble_outline_rounded,
                    ),
                    LanguageDialogDropdown(
                      value: dropdownReadValue,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownReadValue = newValue!;
                        });
                      },
                      label: "liest",
                      icon: Icons.book,
                    ),
                  ],
                )),
            title: const Text('Kommunikation auf Deutsch'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  child: const Text(
                    'ABBRECHEN',
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    final String communicationValue = dropdownUnderstandValue +
                        dropdownSpeakValue +
                        dropdownReadValue;
                    // _pupilManager.updateTutorInfo(internalId: pupil.internalId, tutorInfo: tutorInfo)
                    // patchOnePupilProperty(
                    //     pupilId: pupil.internalId,
                    //     jsonKey: type,
                    //     value: communicationValue);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
      });
}
