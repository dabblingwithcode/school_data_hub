import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/theme/styles.dart';

Future<int?> intDialog(BuildContext context) async {
  int intValue = 0;
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    intValue > 0 ? '+$intValue' : intValue.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: intValue < 0
                            ? Colors.red
                            : intValue > 0
                                ? Colors.green
                                : Colors.black),
                  ),
                ),
              ],
            ),
            title: const Text(
              'Wert ändern',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        style: AppStyles.cancelButtonStyle,
                        onPressed: () {
                          setState(() {
                            intValue--;
                          });
                        },
                        child: const Text(
                          "-1",
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        style: AppStyles.successButtonStyle,
                        onPressed: () {
                          setState(() {
                            intValue++;
                          });
                        },
                        child: const Text(
                          "+1",
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        style: AppStyles.cancelButtonStyle,
                        onPressed: () {
                          setState(() {
                            intValue = intValue - 10;
                          });
                        },
                        child: const Text(
                          "-10",
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        style: AppStyles.successButtonStyle,
                        onPressed: () {
                          setState(() {
                            intValue = intValue + 10;
                          });
                        },
                        child: const Text(
                          "+10",
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "ABBRECHEN",
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
              ElevatedButton(
                style: AppStyles.successButtonStyle,
                onPressed: () {
                  Navigator.of(context).pop(intValue);
                },
                child: const Text(
                  "SENDEN",
                  style: AppStyles.buttonTextStyle,
                ),
              ),
            ],
          );
        });
      });
}
