import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class GrowthDropdown extends StatelessWidget {
  final int dropdownValue;
  final void Function(int) onChangedFunction;
  const GrowthDropdown({
    required this.dropdownValue,
    required this.onChangedFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            icon: const Visibility(
              visible: false,
              child: Icon(Icons.arrow_downward),
            ),
            // dropdownColor: Colors.transparent,
            // elevation: 0,
            borderRadius: BorderRadius.circular(50),
            focusColor: AppColors.cardInCardBorderColor,
            value: dropdownValue,
            items: competenceCheckDropdownItems,
            selectedItemBuilder: (context) => [
              const Center(
                child: Icon(
                  Icons.question_mark_rounded,
                  color: Colors.black,
                  size: 50,
                ),
              ),
              for (final entry in [
                (AppColors.growthIconColor1, 'growth_1-4.png'),
                (AppColors.growthIconColor2, 'growth_2-4.png'),
                (AppColors.growthIconColor3, 'growth_3-4.png'),
                (AppColors.growthIconColor4, 'growth_4-4.png'),
              ])
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: entry.$1,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/growth_icons/${entry.$2}',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
            ],
            onChanged: (value) {
              if (value != dropdownValue) {
                onChangedFunction(value!);
              }
            },
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            itemHeight: 55, // Controls vertical spacing between items
          ),
        ),
      ),
    );
  }
}

const _itemPadding = EdgeInsets.all(4.0);

List<DropdownMenuItem<int>> competenceCheckDropdownItems = [
  const DropdownMenuItem(
    value: 0,
    alignment: AlignmentDirectional.center,
    child: Icon(Icons.question_mark_rounded, color: Colors.black, size: 50),
  ),
  DropdownMenuItem(
    value: 1,
    child: Padding(
      padding: _itemPadding,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.growthIconColor1,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/growth_icons/growth_1-4.png',
          width: 50,
          height: 50,
        ),
      ),
    ),
  ),
  DropdownMenuItem(
    value: 2,
    child: Padding(
      padding: _itemPadding,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.growthIconColor2,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/growth_icons/growth_2-4.png',
          width: 50,
          height: 50,
        ),
      ),
    ),
  ),
  DropdownMenuItem(
    value: 3,
    child: Padding(
      padding: _itemPadding,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.growthIconColor3,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/growth_icons/growth_3-4.png',
          width: 50,
          height: 50,
        ),
      ),
    ),
  ),
  DropdownMenuItem(
    value: 4,
    child: Padding(
      padding: _itemPadding,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.growthIconColor4,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/growth_icons/growth_4-4.png',
          width: 50,
          height: 50,
        ),
      ),
    ),
  ),
];
