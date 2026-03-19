import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class SchooldayEventReasonFilterChip extends StatelessWidget {
  final bool isReason;
  final void Function(bool) onSelected;
  final String emojis;
  final String text;
  const SchooldayEventReasonFilterChip({
    required this.isReason,
    required this.onSelected,
    required this.emojis,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Padding(
      padding: EdgeInsets.all(Style.spacing.xs),
      child: FilterChip(
        padding: EdgeInsets.zero,
        avatar: Padding(
          padding: EdgeInsets.all(Style.spacing.sm),
          child: const CircleAvatar(
            backgroundColor: Color.fromARGB(244, 255, 221, 170),
            child: SizedBox(width: 5),
          ),
        ),
        labelPadding: EdgeInsets.only(
          right: Style.spacing.lg,
          top: Style.spacing.xs,
          bottom: Style.spacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.radii.large),
        ),
        selectedColor: style.colors.filterChipSelected,
        checkmarkColor: style.colors.filterChipCheck,
        backgroundColor: style.colors.filterChipUnselected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emojis, style: const TextStyle(fontSize: 25)),
            Gap(Style.spacing.xs),
            Text(
              text,
              style: context.typography.body.bold.withColor(
                style.colors.background,
              ),
            ),
          ],
        ),
        selected: isReason,
        onSelected: onSelected,
      ),
    );
  }
}
