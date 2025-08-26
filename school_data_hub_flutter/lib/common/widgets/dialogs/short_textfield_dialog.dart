import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

Future<String?> shortTextfieldDialog({
  required BuildContext context,
  required String title,
  required String labelText,
  String? textinField,
  required String hintText,
  bool? obscureText,
}) async {
  final TextEditingController textEditingController = TextEditingController();
  textEditingController.text = textinField ?? '';
  final result = await showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textEditingController,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),

            //maxLength: 16,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              //border: InputBorder.none,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.backgroundColor,
                  width: 2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.backgroundColor,
                  width: 2,
                ),
              ),
              labelStyle: const TextStyle(color: AppColors.backgroundColor),
              labelText: labelText,
              hintText: hintText,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: AppStyles.cancelButtonStyle,
              child: const Text('ABBRECHEN', style: AppStyles.buttonTextStyle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: AppStyles.successButtonStyle,
              child: const Text('OKAY', style: AppStyles.buttonTextStyle),
              onPressed: () {
                Navigator.of(context).pop(textEditingController.text);
              },
            ),
          ),
        ],
      );
    },
  );

  // Dispose the controller after the dialog is fully closed
  WidgetsBinding.instance.addPostFrameCallback((_) {
    textEditingController.dispose();
  });

  return result;
}
