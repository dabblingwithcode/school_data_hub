import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/attendance_values.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_dropdown_menu_items.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/dialogues/late_in_minutes_dialog.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/dialogues/returned_time_picker.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_badges.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class MissedSchooldayCard extends WatchingWidget {
  final PupilProxy pupil;
  final MissedSchoolday missedSchoolday;
  const MissedSchooldayCard({
    required this.pupil,
    required this.missedSchoolday,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tileController = createOnce(() => CustomExpansionTileController());
    final thisDate = missedSchoolday.schoolday!.schoolday;
    final info = AttendanceHelper.getAttendanceValues(missedSchoolday);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: AppColors.cardInCardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onLongPress: () async {
                bool? confirm = await confirmationDialog(
                  context: context,
                  title: 'Fehlzeit löschen',
                  message: 'Die Fehlzeit löschen?',
                );
                if (confirm != true) return;
                await di<AttendanceManager>().deleteMissedSchoolday(
                  pupil.pupilId,
                  missedSchoolday.schoolday!.schoolday,
                );
                di<NotificationManager>().showSnackBar(
                  NotificationType.success,
                  'Fehlzeit gelöscht!',
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat('dd.MM.yyyy').format(thisDate).toString(),
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
                      const Gap(3),
                      CustomExpansionTileSwitch(
                        customExpansionTileController: tileController,
                        switchColor: Colors.grey,
                      ),
                      const Spacer(),
                      Text(
                        missedSchoolday.createdBy,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  CustomExpansionTileContent(
                    title: null,
                    tileController: tileController,
                    widgetList: [
                      _MissedSchooldayEditControls(
                        pupil: pupil,
                        thisDate: thisDate,
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
                                text: missedSchoolday.returnedAt != null
                                    ? DateFormat('HH:mm')
                                          .format(missedSchoolday.returnedAt!)
                                          .toString()
                                    : 'kein Eintrag',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Gap(5),
                  InkWell(
                    onTap: () async {
                      final result = await longTextFieldDialog(
                        title: 'Kommentar',
                        labelText: 'Kommentar',
                        initialValue: info.commentValue,
                        parentContext: context,
                      );
                      if (result == null || result.value == info.commentValue) {
                        return;
                      }
                      di<AttendanceManager>().updateCommentValue(
                        pupil.pupilId,
                        result.value,
                        thisDate,
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Kommentar: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: missedSchoolday.comment ?? 'kein Eintrag',
                            ),
                          ],
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  if (missedSchoolday.modifiedBy != null) ...[
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'zuletzt geändert von: ',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const Gap(5),
                        Text(
                          missedSchoolday.modifiedBy!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Watches the missed schoolday proxy so controls always reflect current state.
class _MissedSchooldayEditControls extends WatchingWidget {
  final PupilProxy pupil;
  final DateTime thisDate;

  const _MissedSchooldayEditControls({
    required this.pupil,
    required this.thisDate,
  });

  @override
  Widget build(BuildContext context) {
    final missedSchoolday =
        watch(
          di<AttendanceManager>().getPupilMissedSchooldaysProxy(pupil.pupilId),
        ).missedSchooldays.firstWhereOrNull(
          (e) => e.schoolday?.schoolday.isSameDate(thisDate.toLocal()) ?? false,
        );

    if (missedSchoolday == null) return const SizedBox.shrink();
    final info = AttendanceHelper.getAttendanceValues(missedSchoolday);

    return Column(
      children: [
        Row(
          children: [
            // Missed type
            _buildMissedTypeDropdown(context, info),
            const Gap(8),
            // Unexcused
            Checkbox(
              checkColor: Colors.white,
              activeColor: AppColors.unexcusedCheckColor,
              value: info.unexcusedValue,
              onChanged: (newValue) {
                di<AttendanceManager>().updateUnexcusedValue(
                  pupil.pupilId,
                  thisDate,
                  newValue!,
                );
              },
            ),
            // Contacted
            _buildContactedDropdown(info),
            const Gap(4),
            // Returned
            Checkbox(
              checkColor: Colors.white,
              activeColor: AppColors.goneHomeColor,
              value: info.returnedValue,
              onChanged: (newValue) async {
                if (info.missedTypeValue == MissedType.missed) return;
                if (newValue == true) {
                  final returnedTime = await returnedDayTime(context);
                  if (returnedTime == null) return;
                  di<AttendanceManager>().updateReturnedValue(
                    pupil.pupilId,
                    true,
                    thisDate,
                    DateTime(
                      thisDate.year,
                      thisDate.month,
                      thisDate.day,
                      returnedTime.hour,
                      returnedTime.minute,
                    ),
                  );
                  return;
                }
                di<AttendanceManager>().updateReturnedValue(
                  pupil.pupilId,
                  false,
                  thisDate,
                  null,
                );
              },
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildMissedTypeDropdown(BuildContext context, AttendanceValues info) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<MissedType>(
        focusColor: Colors.transparent,
        icon: const Visibility(
          visible: false,
          child: Icon(Icons.arrow_downward),
        ),
        value: info.missedTypeValue,
        items: missedTypeMenuItems,
        onChanged: (newValue) async {
          if (info.missedTypeValue == newValue) return;
          if (newValue == MissedType.late) {
            final minutesLate = await minutesLateDialog(context);
            if (minutesLate == null) return;
            di<AttendanceManager>().updateLateTypeValue(
              pupil.pupilId,
              newValue!,
              thisDate,
              minutesLate,
            );
          } else {
            di<AttendanceManager>().updateMissedTypeValue(
              pupil.pupilId,
              newValue!,
              thisDate,
            );
          }
        },
      ),
    );
  }

  Widget _buildContactedDropdown(AttendanceValues info) {
    final showDropdown =
        (info.missedTypeValue == MissedType.missed &&
            info.unexcusedValue == true) ||
        info.contactedTypeValue != ContactedType.notSet ||
        info.returnedValue == true;

    if (!showDropdown) {
      return const SizedBox(width: 30, height: 45);
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<ContactedType>(
        icon: const Visibility(
          visible: false,
          child: Icon(Icons.arrow_downward),
        ),
        value: info.contactedTypeValue,
        items: dropdownContactedMenuItems,
        onChanged: (newValue) {
          if (info.contactedTypeValue == newValue ||
              info.unexcusedValue == false) {
            return;
          }
          di<AttendanceManager>().updateContactedValue(
            pupil.pupilId,
            newValue!,
            thisDate,
          );
        },
      ),
    );
  }
}
