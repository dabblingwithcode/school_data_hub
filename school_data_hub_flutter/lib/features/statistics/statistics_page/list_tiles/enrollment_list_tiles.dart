import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/list_tiles/pupil_enrollment_day_card.dart';
import 'package:watch_it/watch_it.dart';

class EnrollmentListTiles extends WatchingWidget {
  final StatisticsController controller;
  const EnrollmentListTiles({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final seenEnrollmentDates = <DateTime>{};
    //- TODO: Make the date dynamic based on the current school year
    final currentYearPupils = controller.pupilsEnrolledAfterDate(
      DateTime(2025, 08, 01),
    )..sort((a, b) => b.pupilSince.compareTo(a.pupilSince));
    //- TODO: Make the date dynamic based on the current school year
    final pupilsEnrolledLastYearAfterRegulatDate = controller
        .pupilsEnrolledBetweenDates(
          DateFormat('yyy-MM-dd').parse('2024-08-02'),
          DateFormat('yyy-MM-dd').parse('2025-07-31'),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Unterjährige Anmeldungen',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const Gap(10),
            Text(
              controller
                  .pupilsNotEnrolledOnRegularDate(controller.pupils)
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
        const Gap(10),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'im laufenden Schuljahr:',
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
              const Gap(10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentYearPupils.length,
                itemBuilder: (BuildContext context, int index) {
                  final pupil = currentYearPupils[index];
                  final enrollmentDate = DateTime(
                    pupil.pupilSince.year,
                    pupil.pupilSince.month,
                    pupil.pupilSince.day,
                  );
                  final isDatePrinted = seenEnrollmentDates.contains(
                    enrollmentDate,
                  );

                  if (!isDatePrinted) {
                    seenEnrollmentDates.add(enrollmentDate);
                  }

                  return Column(
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backgroundColor,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      PupilEnrollmentDateCard(passedPupil: pupil),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const Gap(20),

        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'im letzten Schuljahr:',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const Gap(10),
                  Text(
                    pupilsEnrolledLastYearAfterRegulatDate.length.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pupilsEnrolledLastYearAfterRegulatDate.length,
                itemBuilder: (BuildContext context, int index) {
                  final pupil = pupilsEnrolledLastYearAfterRegulatDate[index];
                  final enrollmentDate = DateTime(
                    pupil.pupilSince.year,
                    pupil.pupilSince.month,
                    pupil.pupilSince.day,
                  );
                  final isDatePrinted = seenEnrollmentDates.contains(
                    enrollmentDate,
                  );

                  if (!isDatePrinted) {
                    seenEnrollmentDates.add(enrollmentDate);
                  }

                  return Column(
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backgroundColor,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      PupilEnrollmentDateCard(passedPupil: pupil),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
