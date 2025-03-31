//- STYLES

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static InputDecoration textFieldDecoration({required String labelText}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.backgroundColor, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.backgroundColor, width: 2),
      ),
      labelStyle: const TextStyle(color: AppColors.backgroundColor),
      labelText: labelText,
    );
  }

  static const TextStyle appBarTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 25,
  );
  static const TextStyle filterItemsTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle title = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle subtitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static ButtonStyle actionButtonStyle = ElevatedButton.styleFrom(
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.accentColor,
      minimumSize: const Size.fromHeight(50));

  static ButtonStyle cancelButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.cancelButtonColor,
      minimumSize: const Size.fromHeight(50));

  static ButtonStyle successButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.groupColor,
      minimumSize: const Size.fromHeight(50));

//- FILTER CHIP STYLES

  static const filterChipShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));
}
