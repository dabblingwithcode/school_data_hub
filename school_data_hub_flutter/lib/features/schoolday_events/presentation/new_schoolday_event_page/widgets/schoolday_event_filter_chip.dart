import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class SchooldayEventReasonFilterChip extends StatelessWidget {
  final bool isReason;
  final Function(bool) onSelected;
  final String emojis;
  final String text;
  const SchooldayEventReasonFilterChip(
      {required this.isReason,
      required this.onSelected,
      required this.emojis,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: FilterChip(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        avatar: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(244, 255, 221, 170),
            child: SizedBox(
              width: 5,
            ),
          ),
        ),
        labelPadding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        selectedColor: AppColors.schooldayEventReasonChipSelectedColor,
        checkmarkColor: AppColors.schooldayEventReasonChipSelectedCheckColor,
        backgroundColor: AppColors.schooldayEventReasonChipUnselectedColor,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emojis,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            const Gap(5),
            Text(
              text,
              style: AppStyles.filterItemsTextStyle,
            ),
          ],
        ),
        selected: isReason,
        onSelected: onSelected,
      ),
    );
  }
}
