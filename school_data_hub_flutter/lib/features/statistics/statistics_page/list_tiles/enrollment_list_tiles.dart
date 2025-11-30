import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_list_card.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';

class EnrollmentListTiles extends StatelessWidget {
  final StatisticsController controller;
  const EnrollmentListTiles({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final Set<DateTime> seenEnrollmentDates = {};

    final currentYearPupils = controller.pupilsEnrolledAfterDate(
      DateTime(2025, 08, 01),
    )..sort((a, b) => b.pupilSince.compareTo(a.pupilSince));

    return ListTileTheme(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: Row(
          children: [
            const Text(
              'Unterjährige Anmeldungen',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const Gap(10),
            Text(
              controller
                  .pupilsNotEnrolledOnDate(controller.pupils)
                  .length
                  .toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        children: [
          ExpansionTile(
            title: Row(
              children: [
                const Text(
                  'im laufenden Schulahr:',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const Gap(10),
                Text(
                  currentYearPupils.length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentYearPupils.length,
                itemBuilder: (BuildContext context, int index) {
                  final pupil = currentYearPupils[index];
                  final bool isDatePrinted = seenEnrollmentDates.contains(
                    DateTime(
                      pupil.pupilSince.year,
                      pupil.pupilSince.month,
                      pupil.pupilSince.day,
                    ),
                  );

                  if (!isDatePrinted) {
                    seenEnrollmentDates.add(
                      DateTime(
                        pupil.pupilSince.year,
                        pupil.pupilSince.month,
                        pupil.pupilSince.day,
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isDatePrinted)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                const Gap(5),
                                Text(
                                  '${pupil.pupilSince.asWeekdayName(context)}, ${pupil.pupilSince.formatDateForUser()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.backgroundColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        PupilListCard(passedPupil: pupil),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'im letzten Schulahr:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(10),
              Text(
                controller
                    .pupilsEnrolledBetweenDates(
                      DateFormat('yyy-MM-dd').parse('2025-08-02'),
                      DateFormat('yyy-MM-dd').parse('2026-07-31'),
                    )
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
