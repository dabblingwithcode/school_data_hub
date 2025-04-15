import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

Future<void> changeCreditDialog(BuildContext context, PupilProxy pupil) async {
  int credit = 0;
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
                    credit > 0 ? '+$credit' : credit.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: credit < 0
                            ? Colors.red
                            : credit > 0
                                ? Colors.green
                                : Colors.black),
                  ),
                ),
              ],
            ),
            title: const Text(
              'Guthaben ändern',
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
                            credit--;
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
                            credit++;
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
                            credit = credit - 10;
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
                            credit = credit + 10;
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
                  // if (credit != 0) {
                  //   di<PupilManager>().patchOnePupilProperty(
                  //       pupilId: pupil.internalId,
                  //       jsonKey: 'credit',
                  //       value: credit);

                  //   di<SessionManager>().changeSessionCredit(credit);

                  //   Navigator.of(context).pop();
                  // }
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
