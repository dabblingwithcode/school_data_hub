import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final TextEditingController _textEditingController = TextEditingController();

// TODO: Should be deleted
// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<void> changePowerLevelsDialog(
    BuildContext context, PupilProxy pupil) async {
  final _pupilManager = di<PupilManager>();
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "";
                        },
                        decoration: const InputDecoration(hintText: "?"),
                      ),
                    ),
                  ],
                )),
            title: const Text(
              'Guthaben ändern',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "ABBRECHEN",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   int amount = -int.parse(_textEditingController.text);
                    //  _pupilManager.updateStringProperty(pupilId: pupil.pupilId, property: property, value: value) patchOnePupilProperty(
                    //       pupilId: pupil.internalId,
                    //       jsonKey: 'credit',
                    //       value: amount);
                    //   // Do something like updating SharedPreferences or User Settings etc.
                    //   _textEditingController.clear();
                    //   Navigator.of(context).pop();
                    // }
                  },
                  child: const Text(
                    "MINUS",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
              ElevatedButton(
                style: AppStyles.successButtonStyle,
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   int amount = int.parse(_textEditingController.text);
                  //   locator<SessionManager>().changeSessionCredit(-amount);
                  //   locator<PupilManager>().patchOnePupilProperty(
                  //       pupilId: pupil.internalId,
                  //       jsonKey: 'credit',
                  //       value: amount);
                  //   // Do something like updating SharedPreferences or User Settings etc.
                  //   _textEditingController.clear();
                  //   Navigator.of(context).pop();
                  // }
                },
                child: const Text(
                  "PLUS",
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ],
          );
        });
      });
}
