import 'package:flutter/material.dart';

class AppColors {
//- COLORS

  static const backgroundColor = Color.fromRGBO(74, 76, 161, 1);
  static const interactiveColor = Color.fromRGBO(74, 76, 161, 1);
  static const accentColor = Color.fromRGBO(252, 160, 39, 1);
  static const canvasColor = Color(0xfff2f2f7);
  static const gridViewColor = Color.fromRGBO(252, 160, 39, 1);
  static const pupilProfileCardColor = Color.fromARGB(255, 237, 237, 251);
  static const cardInCardColor = Color.fromARGB(255, 248, 248, 255);
  static const cardInCardBorderColor = Color.fromARGB(255, 195, 195, 253);
  static const notProcessedColor = Color.fromARGB(255, 249, 202, 131);
  static const mainMenuCardsColor = Color.fromARGB(255, 220, 220, 255);
  static const selectedCardColor =
      Color.fromARGB(255, 255, 220, 168); // Color.fromARGB(255, 197, 212, 255);
//button colors

  static const appStyleButtonColor = Color.fromRGBO(252, 160, 39, 1);
  static const successButtonColor = Color.fromARGB(255, 139, 195, 74);
  static const warningButtonColor = Color.fromARGB(255, 239, 108, 0);
  static const dangerButtonColor = Color.fromARGB(255, 239, 56, 0);
  static const cancelButtonColor = Color.fromARGB(255, 250, 65, 19);
//- attendance card colors

// missedType dropdown
  static const presentColor = Color.fromRGBO(238, 238, 238, 1);
  static const missedColor = Color.fromRGBO(255, 183, 77, 1);
  static const lateColor = Color.fromRGBO(255, 241, 118, 1);
  static const homeColor = Colors.lightBlue;

// excused checkbox
  static const excusedCheckColor = Color.fromRGBO(239, 108, 0, 1);

// contacted dropdown
  static const contactedQuestionColor = Color.fromRGBO(238, 238, 238, 1);
  static const contactedSuccessColor = Color.fromRGBO(139, 195, 74, 1);
  static const contactedCalledBackColor = Color.fromRGBO(255, 183, 77, 1);
  static const contactedFailedColor = Color.fromRGBO(239, 108, 0, 1);
  static const goneHomeColor = Colors.blue;

//- support category colors

  static const koerperWahrnehmungMotorikColor =
      Color.fromARGB(255, 156, 76, 149);
  static const sozialEmotionalColor = Color.fromARGB(255, 233, 127, 22);
  static const mathematikColor = Color.fromARGB(255, 5, 118, 172);
  static const lernenLeistenColor = Color.fromARGB(255, 5, 155, 88);
  static const deutschColor = Color.fromARGB(255, 228, 70, 60);
  static const spracheSprechenColor = Color.fromARGB(255, 244, 198, 17);

//- Competence colors

  static const germanColor = Color.fromARGB(255, 151, 0, 65);
  static const mathColor = Color.fromARGB(255, 204, 60, 77);
  static const scienceColor = Color.fromARGB(255, 235, 108, 60);
  static const englishColor = Color.fromARGB(255, 246, 173, 90);
  static const artColor = Color.fromARGB(255, 251, 223, 134);
  static const musicColor = Color.fromARGB(255, 231, 245, 147);
  static const sportColor = Color.fromARGB(255, 176, 221, 162);
  static const religionColor = Color.fromARGB(255, 114, 194, 164);
  static const workBehaviourColor = Color.fromARGB(255, 67, 137, 191);
  static const socialColor = Color.fromARGB(255, 94, 80, 164);

  static Color bestContrastCompetenceFontColor(Color color) {
    switch (color) {
      case AppColors.musicColor:
        return const Color.fromARGB(255, 99, 179, 103);
      case AppColors.artColor:
        return const Color.fromARGB(255, 252, 134, 0);
    }
    return Colors.white;
  }

//- text colors
  static const ogsColor = Color.fromRGBO(126, 87, 194, 1);
  static const groupColor = Color.fromARGB(255, 78, 196, 82);
  static const schoolyearColor = Color.fromARGB(255, 153, 92, 211);

//- snackbars

  static const snackBarInfoColor = Colors.blue;
  static const snackBarSuccessColor = Colors.green;
  static const snackBarWarningColor = Colors.orange;
  static const snackBarErrorColor = Colors.red;

//- filterchips

  static const filterChipSelectedColor = Color.fromRGBO(74, 76, 161, 1);
  static const filterChipUnselectedColor = Color.fromRGBO(138, 139, 203, 1);
  static const filterChipSelectedCheckColor = Colors.green;

  static const schooldayEventReasonChipUnselectedColor =
      Color.fromARGB(255, 248, 162, 93);
  static const Color schooldayEventReasonChipSelectedColor =
      Color.fromARGB(255, 239, 137, 13);
  static const Color schooldayEventReasonChipSelectedCheckColor =
      Color.fromARGB(255, 249, 56, 56);
}
