import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class MissedSchooldayCard extends StatelessWidget {
  final PupilProxy pupil;
  final MissedSchoolday missedSchoolday;
  const MissedSchooldayCard({
    required this.pupil,
    required this.missedSchoolday,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
              message: 'Die Fehlzeit löschen?',
            );
            if (confirm != true) return;
            await di<AttendanceManager>().deleteMissedSchoolday(
              pupil.pupilId,
              missedSchoolday.schoolday!.schoolday,
            );

            di<NotificationService>().showSnackBar(
              NotificationType.success,
              'Fehlzeit gelöscht!',
            );
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DateFormat(
                      'dd.MM.yyyy',
                    ).format(missedSchoolday.schoolday!.schoolday).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(5),
                  missedTypeBadge(missedSchoolday.missedType),
                  const Gap(3),
                  excusedBadge(missedSchoolday.unexcused),
                  const Gap(3),
                  contactedDayBadge(missedSchoolday.contacted),
                  const Gap(3),
                  returnedBadge(missedSchoolday.returned),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      missedSchoolday.createdBy,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (missedSchoolday.missedType == MissedType.late)
                    Row(
                      children: [
                        const Text('Verspätung:'),
                        const Gap(5),
                        Text(
                          '${missedSchoolday.minutesLate ?? 0} min',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(5),
                      ],
                    ),
                  if (missedSchoolday.returned == true) ...[
                    RichText(
                      text: TextSpan(
                        text: 'abgeholt um: ',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                missedSchoolday.returnedAt != null
                                    ? DateFormat('HH:mm')
                                        .format(missedSchoolday.returnedAt!)
                                        .toString()
                                    : 'kein Eintrag',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Kommentar:'),
                  const Gap(5),
                  Expanded(
                    child: Text(
                      missedSchoolday.comment ?? 'kein Eintrag',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),

                  // TODO: check why no modifiedBy values are stored
                ],
              ),
              if (missedSchoolday.modifiedBy != null) ...[
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('zuletzt geändert von: '),
                    Expanded(
                      child: Text(
                        missedSchoolday.modifiedBy!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
