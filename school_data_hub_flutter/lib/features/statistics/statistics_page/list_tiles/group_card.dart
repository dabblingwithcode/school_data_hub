import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';

Widget statisticsGroupCard(
  StatisticsController controller,
  List<PupilProxy> group,
) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.male_rounded),
              const Gap(5),
              Text(
                controller.malePupils(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Icon(Icons.female_rounded),
              const Gap(5),
              Text(
                controller.femalePupils(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'E1:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'E1')
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'E2:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'E2')
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'E3:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'E3')
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'S3:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'S3')
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'S4:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'S4')
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
          const Gap(5),
          Row(
            children: [
              const Text(
                'EF',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              const Icon(Icons.language, color: Colors.green),
              const Gap(5),
              Text(
                controller.pupilsWithLanguageSupport(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'ehem. EF',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              const Icon(Icons.language, color: Colors.grey),
              const Gap(10),
              Text(
                controller.pupilsHadLanguageSupport(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
              // const Text(
              //   'a. Familiensprache:',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 18,
              //   ),
              // ),
              Icon(Icons.translate_rounded, color: AppColors.backgroundColor),

              const Gap(5),
              Text(
                controller.pupilsNotSpeakingGerman(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'unterjährig:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller.pupilsNotEnrolledOnDate(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
              const Text(
                'Verbleiber*innen:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .pupilsWithSchoolyearHeldBack(group)
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
          const Gap(5),
          Row(
            children: [
              const Icon(Icons.support_rounded, color: Colors.red),
              const Gap(10),
              const Text(
                '1:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .developmentPlan1InAGivenGroup(group)
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                '2:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .developmentPlan2InAGivenGroup(group)
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                '3:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller
                    .developmentPlan3InAGivenGroup(group)
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'AO-SF:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Gap(5),
              Text(
                controller.specialNeedsInAGivenGroup(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'schulärztliche Eingangsuntersuchung:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('n.v.:'),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionNotAvailable(group)
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text('o.B.:'),
              const Gap(5),
              Text(
                controller.preschoolRevisionOk(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text('Förd.:'),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionSupportInaGivenGroup(group)
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text('AO-SF:'),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionSpecialNeedsInaGivenGroup(group)
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
          const Gap(5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Fehlzeiten:',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              missedTypeBadge('missed'),
              const Gap(5),
              Text(
                controller.totalMissedClasses(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              excusedBadge(true),
              const Gap(5),
              Text(
                controller.totalUnexcusedMissedClasses(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              contactedBadge(1),
              const Gap(5),
              Text(
                controller.totalContactedMissedClasses(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Ø'),
              const Gap(5),
              const Text(' pro Kind:'),
              const Gap(5),
              Text(
                '${controller.averageMissedClassesperPupil(group).toStringAsFixed(2)} Tage',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Tage im laufenden Schuljahr:'),
              const Gap(5),
              Text(
                controller
                    .percentageMissedSchooldays(
                      controller.averageMissedClassesperPupil(group),
                    )
                    .toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              const Text(
                '%',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
