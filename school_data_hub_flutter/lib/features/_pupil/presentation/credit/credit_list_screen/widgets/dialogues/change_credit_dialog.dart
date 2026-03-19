import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:flutter_it/flutter_it.dart';

Future<void> changeCreditDialog(BuildContext context, PupilProxy pupil) async {
  int credit = 0;
  return await showDialog(
    context: context,
    builder: (context) {
      final style = Style.of(context);
      return StatefulBuilder(
        builder: (context, setState) {
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
              'Guthaben ändern',
              textAlign: TextAlign.center,
              style: context.typography.title,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Style.spacing.md),
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
                  SizedBox(width: Style.spacing.md),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Style.spacing.md),
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
                      padding: EdgeInsets.only(bottom: Style.spacing.md),
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
                  SizedBox(width: Style.spacing.md),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Style.spacing.md),
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
                padding: EdgeInsets.only(bottom: Style.spacing.md),
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
                  if (credit != 0) {
                    PupilMutator().updateCredit(
                      pupilId: pupil.pupilId,
                      credit: credit,
                    );

                    di<HubSessionManager>().changeUserCredit(credit);

                    Navigator.of(context).pop();
                  }
                },
                label: "SENDEN",
              ),
            ],
          );
        },
      );
    },
  );
}
