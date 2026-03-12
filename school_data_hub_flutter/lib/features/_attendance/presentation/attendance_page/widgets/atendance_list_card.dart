import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/models/attendance_values.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/attendance_dropdown_menu_items.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/dialogues/late_in_minutes_dialog.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/dialogues/multiple_entries_dialog.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/widgets/dialogues/returned_time_picker.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class AttendanceCard extends WatchingWidget {
  final PupilProxy pupil;
  final DateTime thisDate;

  const AttendanceCard(this.pupil, this.thisDate, {super.key});

  @override
  Widget build(BuildContext context) {
    final dropdownFocusNode = createOnce(() => FocusNode());
    final isAndroid = Platform.isAndroid;

    return Container(
      constraints: isAndroid ? const BoxConstraints(maxWidth: 500) : null,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 1.0,
        margin: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AvatarWithBadges(pupil: pupil, size: 80),
                const Gap(5),
                Expanded(
                  child: GestureDetector(
                    onLongPress: () =>
                        createMissedSchooldayList(context, pupil),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => PupilProfilePage(pupil: pupil),
                      ),
                    ),
                    child: Column(
                      children: [
                        Gap(isAndroid ? 10 : 15),
                        _buildNameRow(context, isAndroid),
                        _AttendanceData(
                          pupil: pupil,
                          thisDate: thisDate,
                          builder: (context, info) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isAndroid)
                                _buildAndroidControls(context, info)
                              else
                                _buildDesktopControls(
                                  context,
                                  info,
                                  dropdownFocusNode,
                                ),
                            ],
                          ),
                        ),
                        const Gap(5),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            _AttendanceComment(pupil: pupil, thisDate: thisDate),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Name Row
  // ---------------------------------------------------------------------------

  Widget _buildNameRow(BuildContext context, bool isAndroid) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: InkWell(
              onTap: () => _navigateToAttendanceProfile(context),
              child: isAndroid
                  ? Text(
                      '${pupil.firstName} ${pupil.lastName}',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          pupil.firstName,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          pupil.lastName,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const Gap(5),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Android Controls
  // ---------------------------------------------------------------------------

  Widget _buildAndroidControls(BuildContext context, AttendanceValues info) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(20),
            _buildMissedTypeDropdown(
              context,
              info: info,
              unfocus: () => FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const Gap(8),
            _buildUnexcusedCheckbox(info),
            const Gap(4),
            _buildContactedDropdown(info, emptyHeight: 45),
            const Gap(4),
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
                    _toReturnedDateTime(returnedTime),
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
        // Legend row with author initials and badges
        Row(
          children: [
            SizedBox(
              width: 70,
              child: Center(
                child: info.createdOrModifiedByValue != null
                    ? Text(
                        info.createdOrModifiedByValue!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            _attendanceBadge('U', AppColors.unexcusedCheckColor, size: 25),
            const Gap(18),
            _attendanceBadge('K', Colors.red[900]!, size: 25),
            const Gap(19),
            _attendanceBadge('H', AppColors.homeColor, size: 25),
          ],
        ),
        if (info.minutesLateValue != null || info.returnedTimeValue != null)
          _buildInfoRow(info),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Desktop Controls
  // ---------------------------------------------------------------------------

  Widget _buildDesktopControls(
    BuildContext context,
    AttendanceValues info,
    FocusNode dropdownFocusNode,
  ) {
    final notificationService = di<NotificationService>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Missed type + author initials
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(5),
            _buildMissedTypeDropdown(
              context,
              info: info,
              unfocus: () => dropdownFocusNode.unfocus(),
              onMissedWithReturned: () {
                notificationService.showSnackBar(
                  NotificationType.error,
                  'Ein Kind, das abgeholt wurde, gilt nicht als fehlend für den Tag!',
                );
              },
            ),
            SizedBox(
              width: 50,
              child: Center(
                child: info.createdOrModifiedByValue != null
                    ? Text(
                        info.createdOrModifiedByValue!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            if (info.minutesLateValue != null)
              Text(
                '${info.minutesLateValue} min',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.orange,
                ),
              ),
          ],
        ),
        const Gap(8),
        // Unexcused checkbox + badge
        Column(
          children: [
            const Gap(10),
            _buildUnexcusedCheckbox(info),
            const Gap(8),
            _attendanceBadge('U', AppColors.unexcusedCheckColor),
          ],
        ),
        const Gap(5),
        // Contacted dropdown + badge
        Column(
          children: [
            const Gap(8),
            _buildContactedDropdown(info, emptyHeight: 48),
            const Gap(2),
            _attendanceBadge('K', Colors.red[900]!),
          ],
        ),
        const Gap(5),
        // Returned checkbox + badge
        Column(
          children: [
            const Gap(10),
            Checkbox(
              checkColor: Colors.white,
              activeColor: AppColors.goneHomeColor,
              value: info.returnedValue,
              onChanged: (newValue) async {
                if (newValue == true) {
                  if (info.missedTypeValue == MissedType.missed) {
                    notificationService.showSnackBar(
                      NotificationType.error,
                      'Ein fehlendes Kind kann nicht abgeholt werden!',
                    );
                    return;
                  }
                  final returnedTime = await returnedDayTime(context);
                  if (returnedTime == null) return;
                  di<AttendanceManager>().updateReturnedValue(
                    pupil.pupilId,
                    true,
                    thisDate,
                    _toReturnedDateTime(returnedTime),
                  );
                  return;
                }
                di<AttendanceManager>().deleteMissedSchoolday(
                  pupil.pupilId,
                  thisDate,
                );
              },
            ),
            const Gap(8),
            _attendanceBadge('H', AppColors.homeColor),
            if (info.returnedTimeValue != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _formatTime(info.returnedTimeValue!),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.homeColor,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Controls
  // ---------------------------------------------------------------------------

  Widget _buildMissedTypeDropdown(
    BuildContext context, {
    required AttendanceValues info,
    required VoidCallback unfocus,
    VoidCallback? onMissedWithReturned,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<MissedType>(
        focusColor: Colors.transparent,
        icon: const Visibility(
          visible: false,
          child: Icon(Icons.arrow_downward),
        ),
        onTap: unfocus,
        value: info.missedTypeValue,
        items: missedTypeMenuItems,
        onChanged: (newValue) async {
          unfocus();
          if (info.missedTypeValue == newValue) return;
          if (onMissedWithReturned != null &&
              newValue == MissedType.missed &&
              info.returnedValue == true) {
            onMissedWithReturned();
            return;
          }
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

  Widget _buildUnexcusedCheckbox(AttendanceValues info) {
    return Checkbox(
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
    );
  }

  Widget _buildContactedDropdown(
    AttendanceValues info, {
    required double emptyHeight,
  }) {
    final showDropdown =
        (info.missedTypeValue == MissedType.missed &&
            info.unexcusedValue == true) ||
        info.contactedTypeValue != ContactedType.notSet ||
        info.returnedValue == true;

    if (!showDropdown) {
      return Container(
        height: emptyHeight,
        width: 30,
        decoration: const BoxDecoration(color: Colors.white),
      );
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<ContactedType>(
        icon: const Visibility(
          visible: false,
          child: Icon(Icons.arrow_downward),
        ),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _navigateToAttendanceProfile(BuildContext context) {
    di<BottomNavManager>().setPupilProfileNavPage(
      ProfileNavigationState.attendance.value,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => PupilProfilePage(pupil: pupil)),
    );
  }

  Widget _buildInfoRow(AttendanceValues info) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 2),
      child: Row(
        children: [
          if (info.minutesLateValue != null)
            Text(
              '${info.minutesLateValue} min',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.orange,
              ),
            ),
          if (info.minutesLateValue != null && info.returnedTimeValue != null)
            const Gap(12),
          if (info.returnedTimeValue != null)
            Text(
              'Abgeholt: ${_formatTime(info.returnedTimeValue!)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.homeColor,
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime _toReturnedDateTime(TimeOfDay time) {
    return DateTime(
      thisDate.year,
      thisDate.month,
      thisDate.day,
      time.hour,
      time.minute,
    );
  }

  Widget _attendanceBadge(String label, Color color, {double size = 20}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Rebuilds only when the missed schooldays list for this pupil changes.
/// Isolates the watch so the card shell and layout do not rebuild.
class _AttendanceData extends WatchingWidget {
  final PupilProxy pupil;
  final DateTime thisDate;
  final Widget Function(BuildContext context, AttendanceValues info) builder;

  const _AttendanceData({
    required this.pupil,
    required this.thisDate,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final missedSchooldaysList = di<AttendanceManager>()
        .getPupilMissedSchooldaysProxy(pupil.pupilId);

    final missedSchoolday = watch(missedSchooldaysList).missedSchooldays
        .firstWhereOrNull(
          (entry) =>
              entry.schoolday?.schoolday.isSameDate(thisDate.toLocal()) ??
              false,
        );

    final info = AttendanceHelper.getAttendanceValues(missedSchoolday);
    return builder(context, info);
  }
}

class _AttendanceComment extends WatchingWidget {
  final PupilProxy pupil;
  final DateTime thisDate;

  const _AttendanceComment({required this.pupil, required this.thisDate});
  bool _shouldShowComment(AttendanceValues info, bool isAndroid) {
    if (isAndroid) return info.missedTypeValue != MissedType.notSet;
    return info.missedTypeValue != MissedType.notSet || info.returnedValue;
  }

  @override
  Widget build(BuildContext context) {
    final missedSchooldaysList = di<AttendanceManager>()
        .getPupilMissedSchooldaysProxy(pupil.pupilId);

    final missedSchoolday = watch(missedSchooldaysList).missedSchooldays
        .firstWhereOrNull(
          (entry) =>
              entry.schoolday?.schoolday.isSameDate(thisDate.toLocal()) ??
              false,
        );
    final info = AttendanceHelper.getAttendanceValues(missedSchoolday);
    return _shouldShowComment(info, Platform.isAndroid)
        ? InkWell(
            onTap: () async {
              final result = await longTextFieldDialog(
                title: Platform.isAndroid ? 'Kommentar eintragen' : 'Kommentar',
                labelText: 'Kommentar',
                initialValue: Platform.isAndroid ? null : info.commentValue,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: ' Kommentar: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            (info.commentValue == null ||
                                info.commentValue!.isEmpty)
                            ? (Platform.isAndroid
                                  ? 'Kein Kommentar'
                                  : 'Kein Eintrag')
                            : info.commentValue!,
                      ),
                    ],
                  ),
                  softWrap: true,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
