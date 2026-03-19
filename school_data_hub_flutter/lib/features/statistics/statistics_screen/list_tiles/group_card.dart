import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_screen/controller/statistics.dart';

Widget statisticsGroupCard(
  BuildContext context,
  StatisticsController controller,
  List<PupilProxy> group,
) {
  final style = Style.of(context);
  return CardBox(
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
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              const Icon(Icons.female_rounded),
              const Gap(5),
              Text(
                controller.femalePupils(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          Row(
            children: [
              Text('E1:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'E1')
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('E2:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'E2')
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('E3:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'E3')
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('K3:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'K3')
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('K4:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .schoolyearInaGivenGroup(group, 'K4')
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
              Text('EF', style: context.typography.subtitle),
              const Gap(5),
              Icon(Icons.language, color: style.colors.success),
              const Gap(5),
              Text(
                controller.pupilsWithLanguageSupport(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('ehem. EF', style: context.typography.subtitle),
              const Gap(5),
              Icon(Icons.language, color: style.colors.mutedForeground),
              const Gap(10),
              Text(
                controller.pupilsHadLanguageSupport(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
              Icon(Icons.translate_rounded, color: style.colors.accent),

              const Gap(5),
              Text(
                controller.pupilsNotSpeakingGerman(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('unterjährig:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .pupilsNotEnrolledOnRegularDate(group)
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
              Text('Verbleiber*innen:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .pupilsWithSchoolyearHeldBack(group)
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          const Gap(5),
          Row(
            children: [
              Icon(Icons.support_rounded, color: style.colors.error),
              const Gap(10),
              Text('1:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .developmentPlan1InAGivenGroup(group)
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('2:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .developmentPlan2InAGivenGroup(group)
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('3:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller
                    .developmentPlan3InAGivenGroup(group)
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              Text('AO-SF:', style: context.typography.subtitle),
              const Gap(5),
              Text(
                controller.specialNeedsInAGivenGroup(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'schulärztliche Eingangsuntersuchung:',
                style: context.typography.body.bold,
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
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              const Text('o.B.:'),
              const Gap(5),
              Text(
                controller.preschoolRevisionOk(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              const Text('Förd.:'),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionSupportInaGivenGroup(group)
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(10),
              const Text('AO-SF:'),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionSpecialNeedsInaGivenGroup(group)
                    .length
                    .toString(),
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Fehlzeiten:', style: context.typography.subtitle.bold),
            ],
          ),
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              missedTypeBadge(MissedType.missed),
              const Gap(5),
              Text(
                controller.totalMissedClasses(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(5),
              excusedBadge(true),
              const Gap(5),
              Text(
                controller.totalUnexcusedMissedClasses(group).length.toString(),
                style: context.typography.subtitle.bold,
              ),
              const Gap(5),
              contactedBadge(1),
              const Gap(5),
              Text(
                controller.totalContactedMissedClasses(group).length.toString(),
                style: context.typography.subtitle.bold,
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
                style: context.typography.subtitle.bold,
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
                style: context.typography.subtitle.bold,
              ),
              const Gap(5),
              Text('%', style: context.typography.subtitle.bold),
            ],
          ),
        ],
      ),
    ),
  );
}
