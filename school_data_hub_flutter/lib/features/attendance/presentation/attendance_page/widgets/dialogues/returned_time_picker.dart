import 'package:flutter/material.dart';

Future returnedDayTime(BuildContext context) async {
  final TimeOfDay initialTime = TimeOfDay.now();
  final TimeOfDay? timeOfDay = await showTimePicker(
    initialTime: initialTime,
    context: context,
  );
  if (timeOfDay == null) {
    return;
  }

  // ignore: use_build_context_synchronously
  final returnedTime = timeOfDay.format(context);

  return returnedTime;
}
