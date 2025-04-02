import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/theme/styles.dart';

Future<String?> longTextFieldDialog(
    {required String title,
    required String? textinField,
    required String labelText,
    required BuildContext parentContext}) async {
  return await showDialog(
      context: parentContext,
      builder: (context) {
        return StatefulBuilder(builder: (statefulContext, setState) {
          final TextEditingController textEditingController =
              TextEditingController();
          setState(() {
            textEditingController.text = textinField ?? '';
          });
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 4,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(fontSize: 17),
                      keyboardType: TextInputType.multiline,
                      controller: textEditingController,
                      decoration:
                          AppStyles.textFieldDecoration(labelText: labelText),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    textEditingController.dispose();
                    Navigator.of(parentContext).pop(null);
                    return;
                  }, // Add onPressed
                  child: const Text(
                    "ABBRECHEN",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
              textinField != null
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: AppStyles.actionButtonStyle,
                        onPressed: () {
                          textEditingController.dispose();
                          Navigator.of(parentContext).pop(null);
                          return;
                        }, // Add onPressed
                        child: const Text(
                          "LÖSCHEN",
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () {
                    String? newSpecialInformation = textEditingController.text;

                    if (newSpecialInformation.isEmpty) {
                      return;
                    }

                    textEditingController.dispose();
                    Navigator.of(parentContext).pop(newSpecialInformation);
                  }, // Add onPressed
                  child: const Text(
                    "OK",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
            ],
          );
        });
      });
}
