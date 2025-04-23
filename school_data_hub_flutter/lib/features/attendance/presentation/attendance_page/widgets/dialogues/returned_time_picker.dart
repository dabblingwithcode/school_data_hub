import 'package:flutter/material.dart';

Future<TimeOfDay?> returnedDayTime(BuildContext context) async {
  final TimeOfDay initialTime = TimeOfDay.now();
  final TimeOfDay? timeOfDay = await showTimePicker(
    initialTime: initialTime,
    context: context,
  );
  if (timeOfDay == null) {
    return null;
  }

  return timeOfDay;
}
