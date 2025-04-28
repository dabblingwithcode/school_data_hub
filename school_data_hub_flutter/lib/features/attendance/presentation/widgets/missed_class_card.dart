import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class MissedClassCard extends StatelessWidget {
  final PupilProxy pupil;
  final MissedClass missedClass;
  const MissedClassCard(
      {required this.pupil, required this.missedClass, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppColors.cardInCardColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            //- TO-DO: change missed class function
          },
          onLongPress: () async {
            bool? confirm = await confirmationDialog(
                context: context,
                title: 'Fehlzeit löschen',
                message: 'Die Fehlzeit löschen?');
            if (confirm != true) return;
            await di<AttendanceManager>().deleteMissedClass(
                pupil.internalId, missedClass.schoolday!.schoolday);

            di<NotificationService>()
                .showSnackBar(NotificationType.success, 'Fehlzeit gelöscht!');
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy')
                        .format(missedClass.schoolday!.schoolday)
                        .toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(5),
                  missedTypeBadge(missedClass.missedType),
                  const Gap(3),
                  excusedBadge(missedClass.unexcused),
                  const Gap(3),
                  contactedDayBadge(missedClass.contacted),
                  const Gap(3),
                  returnedBadge(missedClass.returned),
                  const Spacer(),
                  Text(
                    missedClass.createdBy,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (missedClass.missedType == MissedType.late)
                    Row(
                      children: [
                        const Text('Verspätung:'),
                        const Gap(5),
                        Text('${missedClass.minutesLate ?? 0} min',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Gap(5),
                      ],
                    ),
                  if (missedClass.returned == true) ...[
                    RichText(
                        text: TextSpan(
                      text: 'abgeholt um: ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: missedClass.returnedAt != null
                                ? DateFormat('HH:mm')
                                    .format(missedClass.returnedAt!)
                                    .toString()
                                : 'kein Eintrag',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    )),
                  ]
                ],
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Kommentar:'),
                  const Gap(5),
                  Text(
                    missedClass.comment ?? 'kein Eintrag',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // TODO: check why no modifiedBy values are stored
                ],
              ),
              if (missedClass.modifiedBy != null) ...[
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('zuletzt geändert von: '),
                    Text(
                      missedClass.modifiedBy!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
