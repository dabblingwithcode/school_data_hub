import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class WorkbooksInfoSwitch extends WatchingWidget {
  final PupilProxy pupil;
  const WorkbooksInfoSwitch({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Text('Anzahl: ${pupil.pupilWorkbooks!.length}'),
          ],
        ),
        Column(
          children: [],
        ),
      ],
    );
  }
}
