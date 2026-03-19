import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

Future<int?> changePowerLevelsDialog(BuildContext context) async {
  int credit = 0;
  return await showDialog(
      context: context,
      builder: (context) {
        final style = Style.of(context);
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
                    style: context.typography.display.withColor(
                      credit < 0
                          ? style.colors.error
                          : credit > 0
                              ? style.colors.success
                              : style.colors.foreground,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              'Power Level ändern',
              textAlign: TextAlign.center,
              style: context.typography.title,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Button(
                        variant: ButtonVariant.destructive,
                        onPressed: () {
                          setState(() {
                            credit--;
                          });
                        },
                        label: "-1",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Button(
                        variant: ButtonVariant.primary,
                        onPressed: () {
                          setState(() {
                            credit++;
                          });
                        },
                        label: "+1",
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
                      child: Button(
                        variant: ButtonVariant.destructive,
                        onPressed: () {
                          setState(() {
                            credit = credit - 10;
                          });
                        },
                        label: "-10",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Button(
                        variant: ButtonVariant.primary,
                        onPressed: () {
                          setState(() {
                            credit = credit + 10;
                          });
                        },
                        label: "+10",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Button(
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: "ABBRECHEN",
                ),
              ),
              Button(
                variant: ButtonVariant.primary,
                onPressed: () {
                  Navigator.of(context).pop(credit);
                },
                label: "SENDEN",
              ),
            ],
          );
        });
      });
}
