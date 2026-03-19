import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_helper.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/models/attendance_values.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/widgets/attendance_dropdown_menu_items.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/widgets/dialogues/late_in_minutes_dialog.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/widgets/dialogues/returned_time_picker.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/widgets/attendance_badges.dart';
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
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());
    final thisDate = missedSchoolday.schoolday!.schoolday;
    final info = AttendanceHelper.getAttendanceValues(missedSchoolday);

    return CardBox(
      variant: CardBoxVariant.filledSecondary,
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        children: [
          GestureDetector(
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
                      style: context.typography.subtitle.bold,
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
                    ExpansionHeader(
                      expansionController: tileController,
                      switchColor: style.colors.mutedForeground,
                    ),
                    const Spacer(),
                    Text(
                      missedSchoolday.createdBy,
                      style: context.typography.body.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                ExpansionBody(
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
                          Text('Verspätung:', style: context.typography.body),
                          const Gap(5),
                          Text(
                            '${missedSchoolday.minutesLate ?? 0} min',
                            style: context.typography.body.bold,
                          ),
                          const Gap(5),
                        ],
                      ),
                    if (missedSchoolday.returned == true) ...[
                      Text.rich(
                        TextSpan(
                          text: 'abgeholt um: ',
                          style: context.typography.body,
                          children: <TextSpan>[
                            TextSpan(
                              text: missedSchoolday.returnedAt != null
                                  ? DateFormat('HH:mm')
                                        .format(missedSchoolday.returnedAt!)
                                        .toString()
                                  : 'kein Eintrag',
                              style: context.typography.body.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const Gap(5),
                GestureDetector(
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
                          TextSpan(
                            text: 'Kommentar: ',
                            style: context.typography.body.bold,
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
                      Text(
                        'zuletzt geändert von: ',
                        style: context.typography.caption.muted(context),
                      ),
                      const Gap(5),
                      Text(
                        missedSchoolday.modifiedBy!,
                        style: context.typography.caption.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ],
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
    final style = Style.of(context);
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
              checkColor: style.colors.background,
              activeColor: style.colors.attendanceUnexcused,
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
            _buildContactedDropdown(context, info),
            const Gap(4),
            // Returned
            Checkbox(
              checkColor: style.colors.background,
              activeColor: style.colors.attendanceGoneHome,
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
        focusColor: const Color(0x00000000),
        icon: const Visibility(
          visible: false,
          child: Icon(Icons.arrow_downward),
        ),
        value: info.missedTypeValue,
        items: missedTypeMenuItems(context),
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

  Widget _buildContactedDropdown(BuildContext context, AttendanceValues info) {
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
        items: dropdownContactedMenuItems(context),
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
