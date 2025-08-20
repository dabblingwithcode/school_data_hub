import 'package:flutter/material.dart';

class GrowthDropdown extends StatelessWidget {
  final int dropdownValue;
  final Function(int) onChangedFunction;
  const GrowthDropdown(
      {required this.dropdownValue,
      required this.onChangedFunction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Center(
        child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
          icon: const Visibility(
              visible: false, child: Icon(Icons.arrow_downward)),
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          value: dropdownValue,
          items: competenceCheckDropdownItems,
          onChanged: (value) {
            if (value != dropdownValue) {
              onChangedFunction(value!);
            }
          },
          alignment: Alignment.center,
        )),
      ),
    );
  }
}

List<DropdownMenuItem<int>> competenceCheckDropdownItems = [
  const DropdownMenuItem(
    value: 0,
    alignment: AlignmentDirectional.center,
    child: Center(
      child: Icon(Icons.question_mark_rounded, color: Colors.black, size: 50),
    ),
  ),
  DropdownMenuItem(
    value: 1,
    child: Image.asset('assets/growth_1-4.png', width: 50, height: 50),
  ),
  DropdownMenuItem(
    value: 2,
    child: Image.asset('assets/growth_2-4.png', width: 50, height: 50),
  ),
  DropdownMenuItem(
    value: 3,
    child: Image.asset('assets/growth_3-4.png', width: 50, height: 50),
  ),
  DropdownMenuItem(
    value: 4,
    child: Image.asset('assets/growth_4-4.png', width: 50, height: 50),
  ),
];
