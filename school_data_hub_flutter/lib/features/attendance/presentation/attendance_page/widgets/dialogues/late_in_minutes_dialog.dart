import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

final GlobalKey<FormState> _minutesLateKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<int> minutesLateDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _minutesLateKey,
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
              'Minuten Verspätung',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.of(context).pop();
                  },
                  child:
                      const Text("ABBRECHEN", style: AppStyles.buttonTextStyle),
                ),
              ),
              ElevatedButton(
                style: AppStyles.successButtonStyle,
                onPressed: () {
                  if (_minutesLateKey.currentState!.validate()) {
                    int amount = int.parse(_textEditingController.text);

                    _textEditingController.clear();
                    Navigator.of(context).pop(amount);
                  }
                },
                child: const Text(
                  "OKAY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
      });
}
