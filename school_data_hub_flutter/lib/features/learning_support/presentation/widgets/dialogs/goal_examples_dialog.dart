import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

Future<Map<String, String?>?> goalExamplesDialog(
        context, title, List<SupportGoal> goals) =>
    showDialog<Map<String, String?>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Beispiele'),
        backgroundColor: AppColors.canvasColor,
        content: SizedBox(
          width: double.maxFinite,
          height: 400, // Adjust height according to your requirement
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(goals.length, (index) {
                return Card(
                  color: AppColors.cardInCardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Ziel:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text(goals[index].description!)),
                          ],
                        ),
                        const Gap(10),
                        const Row(
                          children: [
                            Text('Strategien:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        // TODO: uncomment when ready
                        // Row(
                        //   children: [
                        //     Expanded(child: Text(goals[index].strategies!)),
                        //   ],
                        // ),
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
                                child: const Text('übernehmen')),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color.fromRGBO(74, 76, 161, 1),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
