import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

// items for the missedType dropdown
List<DropdownMenuItem<MissedType>> missedTypeMenuItems(BuildContext context) {
  final colors = Style.of(context).colors;
  final fgColor = colors.foreground;
  return [
    DropdownMenuItem(
      value: MissedType.notSet,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: colors.attendancePresent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "A",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fgColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
    DropdownMenuItem(
      value: MissedType.late,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: colors.attendanceLate,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "V",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fgColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
    DropdownMenuItem(
      value: MissedType.missed,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: colors.attendanceMissed,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "F",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fgColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
  ];
}

List<DropdownMenuItem<ContactedType>> dropdownContactedMenuItems(
  BuildContext context,
) {
  final colors = Style.of(context).colors;
  final fgColor = colors.foreground;
  return [
    DropdownMenuItem(
      value: ContactedType.notSet,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: colors.attendanceContactedQuestion,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fgColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
    DropdownMenuItem(
      value: ContactedType.contacted,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: colors.attendanceContactedSuccess,
          shape: BoxShape.circle,
        ),
        child: const Center(child: Icon(Icons.local_phone_rounded)),
      ),
    ),
    DropdownMenuItem(
      value: ContactedType.calledBack,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: colors.attendanceContactedCalledBack,
          shape: BoxShape.circle,
        ),
        child: const Center(child: Icon(Icons.phone_callback_rounded)),
      ),
    ),
    DropdownMenuItem(
      value: ContactedType.notReached,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: colors.attendanceContactedFailed,
          shape: BoxShape.circle,
        ),
        child: const Center(child: Icon(Icons.phone_disabled_rounded)),
      ),
    ),
  ];
}
