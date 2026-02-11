import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/schoolday_date_picker.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/models/schoolday_event_enums.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/new_schoolday_event_page/widgets/schoolday_event_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/widgets/schoolday_event_type_icon.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

/// Holds all local form state for creating a new schoolday event.
///
/// Created once per page lifetime via [createOnce] so that
/// ValueNotifiers are auto-disposed when the page is removed.
class _NewEventFormState {
  _NewEventFormState({required DateTime initialDate}) {
    final now = DateTime.now();
    eventType = ValueNotifier<SchooldayEventType>(SchooldayEventType.notSet);
    selectedDate = ValueNotifier<DateTime>(initialDate);
    eventTime = ValueNotifier<String>(
      '${now.hour.toString().padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}',
    );

    // Build reason notifiers for admonition-type events
    for (final reason in _admonitionReasons) {
      reasonNotifiers[reason] = ValueNotifier<bool>(false);
    }
    // Build reason notifiers for parents-meeting events
    for (final reason in _parentsMeetingReasons) {
      reasonNotifiers[reason] = ValueNotifier<bool>(false);
    }
  }

  late final ValueNotifier<SchooldayEventType> eventType;
  late final ValueNotifier<DateTime> selectedDate;
  late final ValueNotifier<String> eventTime;

  /// Every possible reason has a [ValueNotifier<bool>] keyed by its enum.
  final Map<SchooldayEventReason, ValueNotifier<bool>> reasonNotifiers = {};

  // ── Reason groups ──────────────────────────────────────────────────

  static const _admonitionReasons = [
    SchooldayEventReason.violenceAgainstPupils,
    SchooldayEventReason.violenceAgainstTeachers,
    SchooldayEventReason.violenceAgainstThings,
    SchooldayEventReason.insultOthers,
    SchooldayEventReason.annoyOthers,
    SchooldayEventReason.dangerousBehaviour,
    SchooldayEventReason.ignoreInstructions,
    SchooldayEventReason.disturbLesson,
    SchooldayEventReason.other,
  ];

  static const _parentsMeetingReasons = [
    SchooldayEventReason.learningDevelopmentInfo,
    SchooldayEventReason.learningSupportInfo,
    SchooldayEventReason.transitionAdvice,
    SchooldayEventReason.admonitionInfo,
    SchooldayEventReason.other,
  ];

  List<SchooldayEventReason> reasonsForType(SchooldayEventType type) {
    if (type == SchooldayEventType.parentsMeeting) {
      return _parentsMeetingReasons;
    }
    return _admonitionReasons;
  }

  // ── Derived helpers ────────────────────────────────────────────────

  bool get hasAnyReasonSelected =>
      reasonNotifiers.values.any((n) => n.value == true);

  /// Builds the `*`-separated reason string expected by the API.
  String buildReasonString() {
    final buffer = StringBuffer();
    for (final entry in reasonNotifiers.entries) {
      if (entry.value.value) {
        buffer.write('${entry.key.value}*');
      }
    }
    return buffer.toString();
  }

  void dispose() {
    eventType.dispose();
    selectedDate.dispose();
    eventTime.dispose();
    for (final n in reasonNotifiers.values) {
      n.dispose();
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Display text for the event type dropdown
// ═══════════════════════════════════════════════════════════════════════

String _eventTypeDisplayText(SchooldayEventType type) {
  return switch (type) {
    SchooldayEventType.notSet => 'bitte wählen',
    SchooldayEventType.admonition => 'rote Karte',
    SchooldayEventType.afternoonCareAdmonition => 'rote Karte - OGS',
    SchooldayEventType.admonitionAndBanned => 'rote Karte + abholen',
    SchooldayEventType.parentsMeeting => 'Elterngespräch',
    SchooldayEventType.otherEvent => 'sonstiges',
  };
}

/// Display text + emoji for each reason chip.
({String emoji, String label}) _reasonChipData(SchooldayEventReason reason) {
  return switch (reason) {
    SchooldayEventReason.violenceAgainstPupils => (
      emoji: '🤜🤕',
      label: 'Gewalt gegen Kinder',
    ),
    SchooldayEventReason.violenceAgainstTeachers => (
      emoji: '🤜🎓️',
      label: 'Gewalt gegen Erwachsene',
    ),
    SchooldayEventReason.violenceAgainstThings => (
      emoji: '🤜🏫',
      label: 'Gewalt gegen Sachen',
    ),
    SchooldayEventReason.insultOthers => (emoji: '🤬💔', label: 'Beleidigen'),
    SchooldayEventReason.annoyOthers => (emoji: '😈😖', label: 'Ärgern'),
    SchooldayEventReason.dangerousBehaviour => (
      emoji: '🚨😱',
      label: 'Gefahr für sich/andere',
    ),
    SchooldayEventReason.ignoreInstructions => (
      emoji: '🎓️🙉',
      label: 'Anweisungen ignorieren',
    ),
    SchooldayEventReason.disturbLesson => (
      emoji: '🛑🎓️',
      label: 'Unterricht stören',
    ),
    SchooldayEventReason.learningDevelopmentInfo => (
      emoji: '💡🧠',
      label: 'Lernentwicklung',
    ),
    SchooldayEventReason.learningSupportInfo => (
      emoji: '🛟🧠',
      label: 'Förderung',
    ),
    SchooldayEventReason.transitionAdvice => (
      emoji: '🧠🗺️',
      label: 'Übergang',
    ),
    SchooldayEventReason.admonitionInfo => (
      emoji: '⚠️ℹ️',
      label: 'Regelverstoß',
    ),
    SchooldayEventReason.other => (emoji: '📝', label: 'Sonstiges'),
  };
}

// ═══════════════════════════════════════════════════════════════════════
// Page widget (top-level, doesn't watch anything itself)
// ═══════════════════════════════════════════════════════════════════════

class NewSchooldayEventPage extends WatchingWidget {
  final int pupilId;

  const NewSchooldayEventPage({super.key, required this.pupilId});

  @override
  Widget build(BuildContext context) {
    final formState = createOnce(
      () => _NewEventFormState(
        initialDate: di<SchoolCalendarManager>().thisDate.value,
      ),
      dispose: (s) => s.dispose(),
    );

    final eventType = watch(formState.eventType).value;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Neues Ereignis', style: AppStyles.appBarTextStyle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  // ── Scrollable form content ──
                  Expanded(
                    child: ListView(
                      children: [
                        _EventTypeSection(formState: formState),
                        const Gap(16),
                        _DateTimeSection(formState: formState),
                        const Gap(16),
                        _ReasonSection(
                          formState: formState,
                          eventType: eventType,
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  // ── Action buttons pinned at bottom ──
                  _ActionButtons(formState: formState, pupilId: pupilId),
                  const Gap(8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Section: Event type dropdown
// ═══════════════════════════════════════════════════════════════════════

class _EventTypeSection extends WatchingWidget {
  final _NewEventFormState formState;
  const _EventTypeSection({required this.formState});

  @override
  Widget build(BuildContext context) {
    final eventType = watch(formState.eventType).value;

    return _SectionCard(
      icon: Icons.warning_rounded,
      title: 'Ereignis-Art',
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.backgroundColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.backgroundColor, width: 2),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<SchooldayEventType>(
            isDense: true,
            isExpanded: true,
            value: eventType,
            onChanged: (SchooldayEventType? newValue) {
              if (newValue != null) {
                formState.eventType.value = newValue;
              }
            },
            items: SchooldayEventType.values
                .map(
                  (type) => DropdownMenuItem<SchooldayEventType>(
                    value: type,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SchooldayEventTypeIcon(type: type),
                        const Gap(8),
                        Text(
                          _eventTypeDisplayText(type),
                          style: TextStyle(
                            color: type == SchooldayEventType.notSet
                                ? Colors.red
                                : AppColors.backgroundColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Section: Date & Time pickers
// ═══════════════════════════════════════════════════════════════════════

class _DateTimeSection extends WatchingWidget {
  final _NewEventFormState formState;
  const _DateTimeSection({required this.formState});

  Future<void> _pickDate(BuildContext context) async {
    final newDate = await selectSchooldayDate(
      context,
      formState.selectedDate.value,
    );
    if (newDate != null) {
      formState.selectedDate.value = newDate;
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final parts = formState.eventTime.value.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked != null) {
      formState.eventTime.value =
          '${picked.hour.toString().padLeft(2, '0')}:'
          '${picked.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = watch(formState.selectedDate).value;
    final time = watch(formState.eventTime).value;

    return _SectionCard(
      icon: Icons.schedule_rounded,
      title: 'Datum & Uhrzeit',
      child: Row(
        children: [
          // ── Date ──
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _pickDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.interactiveColor,
                      size: 20,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        date.formatDateForUser(),
                        style: AppStyles.subtitle.copyWith(
                          color: AppColors.interactiveColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Gap(12),
          // ── Time ──
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _pickTime(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: AppColors.interactiveColor,
                    size: 20,
                  ),
                  const Gap(8),
                  Text(
                    time,
                    style: AppStyles.subtitle.copyWith(
                      color: AppColors.interactiveColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Section: Reason chips
// ═══════════════════════════════════════════════════════════════════════

class _ReasonSection extends WatchingWidget {
  final _NewEventFormState formState;
  final SchooldayEventType eventType;
  const _ReasonSection({required this.formState, required this.eventType});

  @override
  Widget build(BuildContext context) {
    if (eventType == SchooldayEventType.notSet) {
      return _SectionCard(
        icon: Icons.help_outline_rounded,
        title: 'Grund',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              'Bitte zuerst eine Ereignis-Art auswählen',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final reasons = formState.reasonsForType(eventType);

    // Watch every reason notifier so this widget rebuilds on toggles
    for (final reason in reasons) {
      watch(formState.reasonNotifiers[reason]!);
    }

    return _SectionCard(
      icon: Icons.checklist_rounded,
      title: 'Grund',
      child: Wrap(
        spacing: 4,
        runSpacing: 0,
        children: reasons.map((reason) {
          final notifier = formState.reasonNotifiers[reason]!;
          final chipData = _reasonChipData(reason);
          return SchooldayEventReasonFilterChip(
            isReason: notifier.value,
            onSelected: (value) => notifier.value = value,
            emojis: chipData.emoji,
            text: chipData.label,
          );
        }).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Action buttons (pinned at bottom)
// ═══════════════════════════════════════════════════════════════════════

class _ActionButtons extends StatelessWidget {
  final _NewEventFormState formState;
  final int pupilId;
  const _ActionButtons({required this.formState, required this.pupilId});

  Future<void> _submit(BuildContext context) async {
    if (formState.eventType.value == SchooldayEventType.notSet) {
      informationDialog(
        context,
        'Kein Ereignis ausgewählt',
        'Bitte eine Ereignis-Art auswählen!',
      );
      return;
    }
    if (!formState.hasAnyReasonSelected) {
      informationDialog(
        context,
        'Kein Grund ausgewählt',
        'Bitte mindestens einen Grund auswählen!',
      );
      return;
    }

    final calendarManager = di<SchoolCalendarManager>();
    final schoolday = calendarManager.getSchooldayByDate(
      formState.selectedDate.value,
    );

    if (schoolday == null) {
      informationDialog(
        context,
        'Kein Schultag',
        'Das ausgewählte Datum ist kein gültiger Schultag!',
      );
      return;
    }

    unawaited(
      di<SchooldayEventManager>().postSchooldayEvent(
        pupilId: pupilId,
        schooldayId: schoolday.id!,
        dateTime: formState.selectedDate.value,
        type: formState.eventType.value,
        reason: formState.buildReasonString(),
        eventTime: formState.eventTime.value,
      ),
    );

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: AppStyles.successButtonStyle,
            onPressed: () => _submit(context),
            icon: const Icon(Icons.send_rounded, color: Colors.white),
            label: const Text('SENDEN', style: AppStyles.buttonTextStyle),
          ),
        ),
        const Gap(10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: AppStyles.cancelButtonStyle,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            label: const Text('ABBRECHEN', style: AppStyles.buttonTextStyle),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Reusable card wrapper for each form section
// ═══════════════════════════════════════════════════════════════════════

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.backgroundColor, size: 22),
                const Gap(8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ],
            ),
            const Gap(12),
            child,
          ],
        ),
      ),
    );
  }
}
