import 'package:flutter/material.dart';

final GlobalKey<FormState> _minutesLateKey = GlobalKey<FormState>();
final TextEditingController _textEditingController = TextEditingController();

// based on https://mobikul.com/creating-stateful-dialog-form-in-flutter/

Future<String?> pupilAuthorizationCommentDialog(BuildContext context) async {
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
                      width: 400,
                      height: 300,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "";
                        },
                        decoration: const InputDecoration(hintText: "?"),
                      ),
                    ),
                  ],
                )),
            title: const Text('Kommentar'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    _textEditingController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "ABBRECHEN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  if (_minutesLateKey.currentState!.validate()) {
                    String comment = _textEditingController.text;

                    _textEditingController.clear();
                    Navigator.of(context).pop(comment);
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
