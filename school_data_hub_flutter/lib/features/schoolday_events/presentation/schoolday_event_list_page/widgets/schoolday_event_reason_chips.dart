import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/models/schoolday_event_enums.dart';

class SchooldayEventReasonChip extends StatelessWidget {
  final String reason;
  const SchooldayEventReasonChip({required this.reason, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        backgroundColor: AppColors.filterChipUnselectedColor,
        label: Text(
          reason,
          style: const TextStyle(fontSize: emojiSize),
        ));
  }
}

const double emojiSize = 20;
List<Widget> schooldayEventReasonChips(String reason) {
  List<Widget> chips = [];
  if (reason.contains(SchooldayEventReason.violenceAgainstPupils.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🤜🤕'));
  }
  if (reason.contains(SchooldayEventReason.violenceAgainstTeachers.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🤜🎓️'));
  }
  if (reason.contains(SchooldayEventReason.violenceAgainstThings.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🤜🏫'));
  }
  if (reason.contains(SchooldayEventReason.insultOthers.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🤬💔'));
  }
  if (reason.contains(SchooldayEventReason.dangerousBehaviour.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🚨😱'));
  }
  if (reason.contains(SchooldayEventReason.annoyOthers.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '😈😖'));
  }
  if (reason.contains(SchooldayEventReason.ignoreInstructions.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🎓️🙉'));
  }
  if (reason.contains(SchooldayEventReason.disturbLesson.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🛑🎓️'));
  }
  if (reason.contains(SchooldayEventReason.other.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '📝'));
  }
  if (reason.contains(SchooldayEventReason.learningDevelopmentInfo.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '💡🧠'));
  }
  if (reason.contains(SchooldayEventReason.learningSupportInfo.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '🛟🧠'));
  }
  if (reason.contains(SchooldayEventReason.admonitionInfo.value)) {
    chips.add(const SchooldayEventReasonChip(reason: '⚠️ℹ️'));
  }
  return chips;
}
