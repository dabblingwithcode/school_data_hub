import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

Future<Map<String, String?>?> goalExamplesDialog(
  BuildContext context,
  String title,
  List<SupportGoal> goals,
) => showDialog<Map<String, String?>>(
  context: context,
  builder: (context) {
    final style = Style.of(context);
    return AlertDialog(
      title: const Text('Beispiele'),
      backgroundColor: style.colors.canvas,
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(goals.length, (index) {
              return CardBox(
                padding: EdgeInsets.all(Style.spacing.lg),
                variant: CardBoxVariant.filledSecondary,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Ziel:',
                          style: context.typography.body.bold,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(goals[index].description)),
                      ],
                    ),
                    Gap(Style.spacing.md),
                    Row(
                      children: [
                        Text(
                          'Strategien:',
                          style: context.typography.body.bold,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(goals[index].strategies)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            return Navigator.pop(context, {
                              'goal': goals[index].description,
                              'strategies': goals[index].strategies,
                            });
                          },
                          child: const Text('übernehmen'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'OK',
            style: context.typography.body.bold
                .withColor(style.colors.interactive),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  },
);
