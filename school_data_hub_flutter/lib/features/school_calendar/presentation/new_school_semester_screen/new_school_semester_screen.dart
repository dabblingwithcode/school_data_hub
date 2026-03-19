import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/multi_choice.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/new_school_semester_screen/widgets/date_picker_button.dart';

class NewSchoolSemesterScreen extends WatchingStatefulWidget {
  final SchoolSemester? semester;

  const NewSchoolSemesterScreen({super.key, this.semester});

  @override
  State<NewSchoolSemesterScreen> createState() =>
      _NewSchoolSemesterScreenState();
}

class _NewSchoolSemesterScreenState extends State<NewSchoolSemesterScreen> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime? classConferenceDate;
  DateTime? supportConferenceDate;
  DateTime? reportSignedDate;
  DateTime? reportConferenceDate;
  bool isFirst = false;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-populate fields if editing
    if (widget.semester != null) {
      final semester = widget.semester!;
      _textController.text = semester.schoolYear;
      startDate = semester.startDate;
      endDate = semester.endDate;
      classConferenceDate = semester.classConferenceDate;
      supportConferenceDate = semester.supportConferenceDate;
      reportSignedDate = semester.reportSignedDate;
      reportConferenceDate = semester.reportConferenceDate;
      isFirst = semester.isFirst;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schoolCalendarManager = di<SchoolCalendarManager>();
    final List<SchoolSemester> semesters = watchValue(
      (SchoolCalendarManager m) => m.schoolSemesters,
    );

    bool isNotInExistingSemesters(DateTime day) {
      final dayUtc = day.toDateOnlyUtc();
      for (final semester in semesters) {
        final startUtc = semester.startDate.toDateOnlyUtc();
        final endUtc = semester.endDate.toDateOnlyUtc();
        final isInside =
            !dayUtc.isBefore(startUtc) && !dayUtc.isAfter(endUtc);
        if (isInside) return false;
      }
      return true;
    }

    bool isWithinSemesterStartDateAndEndDate(DateTime day) {
      final dayUtc = day.toDateOnlyUtc();
      if (dayUtc.isBefore(startDate!) || dayUtc.isAfter(endDate!)) return false;
      return true;
    }

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_view_month_rounded,
              size: 25,
              color: style.colors.background,
            ),
            const Gap(10),
            Text(
              widget.semester != null
                  ? 'Schulhalbjahr bearbeiten'
                  : 'Neues Schulhalbjahr',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Style.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SectionCard(
                        title: 'Schulhalbjahr',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _LabeledField(
                              label: 'Schuljahr',
                              child: TextField(
                                controller: _textController,
                                decoration: AppStyles.textFieldDecoration(
                                  labelText: 'z.B. 2023/2024',
                                ),
                                minLines: 1,
                                maxLines: 1,
                              ),
                            ),
                            Gap(Style.spacing.md),
                            Row(
                              children: [
                                MultiChoice(
                                  value: isFirst,
                                  onChanged: (value) {
                                    setState(() {
                                      isFirst = value;
                                    });
                                  },
                                ),
                                SizedBox(width: Style.spacing.sm),
                                Text(
                                  '1. Halbjahr',
                                  style: context.typography.body.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(Style.spacing.lg),
                      _SectionCard(
                        title: 'Zeitraum',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _LabeledField(
                              label: 'Startdatum',
                              child: DatePickerButton(
                                dateToSelect: startDate,
                                selectableDayPredicate:
                                    isNotInExistingSemesters,
                                onDateSelected: (pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      startDate = pickedDate;
                                    });
                                  }
                                },
                              ),
                            ),
                            Gap(Style.spacing.lg),
                            _LabeledField(
                              label: 'Enddatum',
                              child: DatePickerButton(
                                dateToSelect: endDate,
                                firstDate: startDate ?? DateTime(2000),
                                selectableDayPredicate:
                                    isNotInExistingSemesters,
                                onDateSelected: (pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      endDate = pickedDate;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(Style.spacing.lg),
                      _SectionCard(
                        title: 'Konferenzen & Zeugnis',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _LabeledField(
                              label: 'Klassenkonferenzdatum',
                              child: DatePickerButton(
                                dateToSelect: classConferenceDate,
                                selectableDayPredicate:
                                    isWithinSemesterStartDateAndEndDate,
                                onDateSelected: (pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      classConferenceDate = pickedDate;
                                    });
                                  }
                                },
                              ),
                            ),
                            Gap(Style.spacing.lg),
                            _LabeledField(
                              label: 'F\u00f6rderkonferenzdatum',
                              child: DatePickerButton(
                                dateToSelect: supportConferenceDate,
                                selectableDayPredicate:
                                    isWithinSemesterStartDateAndEndDate,
                                onDateSelected: (pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      supportConferenceDate = pickedDate;
                                    });
                                  }
                                },
                              ),
                            ),
                            Gap(Style.spacing.lg),
                            _LabeledField(
                              label: 'Zeugniskonferenzdatum',
                              child: DatePickerButton(
                                dateToSelect: reportConferenceDate,
                                selectableDayPredicate:
                                    isWithinSemesterStartDateAndEndDate,
                                onDateSelected: (pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      reportConferenceDate = pickedDate;
                                    });
                                  }
                                },
                              ),
                            ),
                            Gap(Style.spacing.lg),
                            _LabeledField(
                              label: 'Zeugnisausgabe',
                              child: DatePickerButton(
                                dateToSelect: reportSignedDate,
                                selectableDayPredicate:
                                    isWithinSemesterStartDateAndEndDate,
                                onDateSelected: (pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      reportSignedDate = pickedDate;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Style.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Button(
                      label: widget.semester != null
                          ? 'AKTUALISIEREN'
                          : 'SENDEN',
                      variant: ButtonVariant.primary,
                      onPressed: () async {
                        if (widget.semester != null) {
                          final updatedSemester = widget.semester!.copyWith(
                            schoolYear: _textController.text,
                            startDate: startDate ?? widget.semester!.startDate,
                            endDate: endDate ?? widget.semester!.endDate,
                            classConferenceDate: classConferenceDate,
                            supportConferenceDate: supportConferenceDate,
                            reportSignedDate: reportSignedDate,
                            reportConferenceDate: reportConferenceDate,
                            isFirst: isFirst,
                          );
                          await schoolCalendarManager.updateSchoolSemester(
                            updatedSemester,
                          );
                        } else {
                          await schoolCalendarManager.postSchoolSemester(
                            schoolYearName: _textController.text,
                            startDate: startDate!,
                            endDate: endDate!,
                            classConferenceDate: classConferenceDate,
                            supportConferenceDate: supportConferenceDate,
                            reportSignedDate: reportSignedDate,
                            reportConferenceDate: reportConferenceDate,
                            isFirst: isFirst,
                          );
                        }
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    Gap(Style.spacing.md),
                    Button(
                      label: 'ABBRECHEN',
                      variant: ButtonVariant.destructive,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return CardBox(
      variant: CardBoxVariant.bordered,
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.typography.subtitle.bold
                .withColor(Style.of(context).colors.accent),
          ),
          Gap(Style.spacing.md),
          child,
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typography.body.bold,
        ),
        const Gap(6),
        child,
      ],
    );
  }
}
