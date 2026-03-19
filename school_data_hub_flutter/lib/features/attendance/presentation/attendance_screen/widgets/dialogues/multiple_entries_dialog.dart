import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:flutter_it/flutter_it.dart';

Future<void> createMissedSchooldayList(
  BuildContext context,
  PupilProxy pupil,
) async {
  final schoolCalendarManager = di<SchoolCalendarManager>();
  final DateTime thisDate = schoolCalendarManager.thisDate.value;

  return await Popup.show(
    context: context,
    title: 'Mehrere Einträge',
    child: _MultipleEntriesContent(pupil: pupil, initialDate: thisDate),
  );
}

class _MultipleEntriesContent extends StatefulWidget {
  final PupilProxy pupil;
  final DateTime initialDate;

  const _MultipleEntriesContent({
    required this.pupil,
    required this.initialDate,
  });

  @override
  State<_MultipleEntriesContent> createState() =>
      _MultipleEntriesContentState();
}

class _MultipleEntriesContentState extends State<_MultipleEntriesContent> {
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
    final style = Style.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(Style.spacing.sm),
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
                        color: style.colors.attendanceMissed,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "F",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: style.colors.foreground,
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
                      decoration: BoxDecoration(
                        color: style.colors.attendanceHome,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "H",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: style.colors.foreground,
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
              Text('von', style: context.typography.title),
              const Gap(15),
              GestureDetector(
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
                  style: context.typography.title.withColor(
                    style.colors.interactive,
                  ),
                ),
              ),
              const Gap(5),
              TappableIcon(
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
                  color: style.colors.interactive,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('bis', style: context.typography.title),
              const Gap(15),
              GestureDetector(
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
                  style: context.typography.title.withColor(
                    style.colors.interactive,
                  ),
                ),
              ),
              const Gap(5),
              TappableIcon(
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
                  color: style.colors.interactive,
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
          SizedBox(height: Style.spacing.xl),
          Row(
            children: [
              Expanded(
                child: Button(
                  label: 'ABBRECHEN',
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(width: Style.spacing.lg),
              Expanded(
                child: Button(
                  label: 'OK',
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
