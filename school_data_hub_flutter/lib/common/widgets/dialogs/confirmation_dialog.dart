import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

Future<bool?> confirmationDialog(
    {required BuildContext context,
    required String title,
    required String message}) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(
          Icons.question_mark_rounded,
          color: AppColors.backgroundColor,
          size: 50,
        ),
        content: Text(message, textAlign: TextAlign.center),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: AppStyles.cancelButtonStyle,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }, // Add onPressed
                    child: const Text(
                      "NEIN",
                      style: AppStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: AppStyles.successButtonStyle,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }, // Add onPressed
                    child: const Text(
                      "JA",
                      style: AppStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
