import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

Future<void> createMissedSchooldayList(
  BuildContext context,
  PupilProxy pupil,
) async {
  final schoolCalendarManager = di<SchoolCalendarManager>();
  final DateTime thisDate = schoolCalendarManager.thisDate.value;
  return await showDialog(
    context: context,
    builder: (context) {
      return _MultipleEntriesDialogContent(pupil: pupil, initialDate: thisDate);
    },
  );
}

class _MultipleEntriesDialogContent extends StatefulWidget {
  final PupilProxy pupil;
  final DateTime initialDate;

  const _MultipleEntriesDialogContent({
    required this.pupil,
    required this.initialDate,
  });

  @override
  State<_MultipleEntriesDialogContent> createState() =>
      _MultipleEntriesDialogContentState();
}

class _MultipleEntriesDialogContentState
    extends State<_MultipleEntriesDialogContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late MissedType _dialogdropdownValue;
  late DateTime _startDate;
  late DateTime _endDate;
  late final TextEditingController _commentController;
  final _attendanceManager = di<AttendanceManager>();

  @override
  void initState() {
    super.initState();
    _dialogdropdownValue = MissedType.missed;
    _startDate = widget.initialDate;
    _endDate = widget.initialDate;
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<MissedType>(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  value: _dialogdropdownValue,
                  items: [
                    DropdownMenuItem(
                      value: MissedType.missed,
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            "F",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: MissedType.home,
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            "H",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (newvalue) {
                    setState(() {
                      _dialogdropdownValue = newvalue!;
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'von',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Gap(15),
                InkWell(
                  onTap: () async {
                    final DateTime? date = await selectSchooldayDate(
                      context,
                      widget.initialDate,
                    );
                    if (date != null) {
                      setState(() {
                        _startDate = date;
                      });
                    }
                  },
                  child: Text(
                    _startDate.formatDateForUser(),
                    style: TextStyle(
                      color: AppColors.interactiveColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Gap(5),
                IconButton(
                  onPressed: () async {
                    final DateTime? date = await selectSchooldayDate(
                      context,
                      widget.initialDate,
                    );
                    if (date != null) {
                      setState(() {
                        _startDate = date;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'bis',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Gap(15),
                InkWell(
                  onTap: () async {
                    final DateTime? date = await selectSchooldayDate(
                      context,
                      widget.initialDate,
                    );
                    if (date != null) {
                      setState(() {
                        _endDate = date;
                      });
                    }
                  },
                  child: Text(
                    _endDate.formatDateForUser(),
                    style: TextStyle(
                      color: AppColors.interactiveColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Gap(5),
                IconButton(
                  onPressed: () async {
                    final DateTime? date = await selectSchooldayDate(
                      context,
                      widget.initialDate,
                    );
                    if (date != null) {
                      setState(() {
                        _endDate = date;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ],
            ),
            const Gap(15),
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Kommentar (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      title: const Text(
        'Mehrere Einträge',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            style: AppStyles.cancelButtonStyle,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("ABBRECHEN", style: AppStyles.buttonTextStyle),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            style: AppStyles.successButtonStyle,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _attendanceManager.postManyMissedSchooldays(
                  id: widget.pupil.pupilId,
                  startdate: _startDate,
                  enddate: _endDate,
                  missedType: _dialogdropdownValue,
                  comment: _commentController.text.trim().isEmpty
                      ? null
                      : _commentController.text.trim(),
                );
                _formKey.currentState!.reset();
                Navigator.of(context).pop();
              }
            },
            child: const Text("OK", style: AppStyles.buttonTextStyle),
          ),
        ),
      ],
    );
  }
}
