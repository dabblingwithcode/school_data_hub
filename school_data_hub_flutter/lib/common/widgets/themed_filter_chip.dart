import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/theme/app_colors.dart';
import 'package:school_data_hub_flutter/theme/paddings.dart';
import 'package:school_data_hub_flutter/theme/styles.dart';

class ThemedFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const ThemedFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FilterChip(
        autofocus: true,
        elevation: 0,
        pressElevation: 0,
        padding: AppPaddings.filterChipPadding,
        labelPadding: AppPaddings.filterChipLabelPadding,
        shape: AppStyles.filterChipShape,
        avatar: const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 10,
          ),
        ),
        selectedColor: AppColors.filterChipSelectedColor,
        checkmarkColor: AppColors.filterChipSelectedCheckColor,
        backgroundColor: AppColors.filterChipUnselectedColor,
        label: Text(
          label,
          style: AppStyles.filterItemsTextStyle,
        ),
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }
}
