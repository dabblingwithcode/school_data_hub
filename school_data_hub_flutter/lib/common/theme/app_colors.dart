import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

enum AppColorSchemeKey { classic, lila, darkBlue }

AppColorSchemeKey appColorSchemeKeyFromString(String? key) {
  return AppColorSchemeKey.values.firstWhere(
    (k) => k.name == key,
    orElse: () => AppColorSchemeKey.classic,
  );
}

class AppColorPalette {
  const AppColorPalette({
    required this.key,
    required this.displayName,
    required this.backgroundColor,
    required this.interactiveColor,
    required this.accentColor,
    required this.canvasColor,
    required this.gridViewColor,
    required this.pupilProfileBackgroundColor,
    required this.pupilProfileCardColor,
    required this.cardInCardColor,
    required this.cardInCardBorderColor,
    required this.notProcessedColor,
    required this.mainMenuCardsColor,
    required this.selectedCardColor,
    required this.appStyleButtonColor,
    required this.successButtonColor,
    required this.warningButtonColor,
    required this.dangerButtonColor,
    required this.cancelButtonColor,
    required this.presentColor,
    required this.missedColor,
    required this.lateColor,
    required this.homeColor,
    required this.unexcusedCheckColor,
    required this.contactedQuestionColor,
    required this.contactedSuccessColor,
    required this.contactedCalledBackColor,
    required this.contactedFailedColor,
    required this.goneHomeColor,
    required this.koerperWahrnehmungMotorikColor,
    required this.sozialEmotionalColor,
    required this.mathematikColor,
    required this.lernenLeistenColor,
    required this.deutschColor,
    required this.spracheSprechenColor,
    required this.germanColor,
    required this.mathColor,
    required this.scienceColor,
    required this.englishColor,
    required this.artColor,
    required this.musicColor,
    required this.sportColor,
    required this.religionColor,
    required this.workBehaviourColor,
    required this.socialColor,
    required this.ogsColor,
    required this.groupColor,
    required this.schoolyearColor,
    required this.snackBarInfoColor,
    required this.snackBarSuccessColor,
    required this.snackBarWarningColor,
    required this.snackBarErrorColor,
    required this.filterChipSelectedColor,
    required this.filterChipUnselectedColor,
    required this.filterChipSelectedCheckColor,
    required this.schooldayEventReasonChipUnselectedColor,
    required this.schooldayEventReasonChipSelectedColor,
    required this.schooldayEventReasonChipSelectedCheckColor,
  });

  final AppColorSchemeKey key;
  final String displayName;
  final Color backgroundColor;
  final Color interactiveColor;
  final Color accentColor;
  final Color canvasColor;
  final Color gridViewColor;
  final Color pupilProfileBackgroundColor;
  final Color pupilProfileCardColor;
  final Color cardInCardColor;
  final Color cardInCardBorderColor;
  final Color notProcessedColor;
  final Color mainMenuCardsColor;
  final Color selectedCardColor;
  final Color appStyleButtonColor;
  final Color successButtonColor;
  final Color warningButtonColor;
  final Color dangerButtonColor;
  final Color cancelButtonColor;
  final Color presentColor;
  final Color missedColor;
  final Color lateColor;
  final Color homeColor;
  final Color unexcusedCheckColor;
  final Color contactedQuestionColor;
  final Color contactedSuccessColor;
  final Color contactedCalledBackColor;
  final Color contactedFailedColor;
  final Color goneHomeColor;
  final Color koerperWahrnehmungMotorikColor;
  final Color sozialEmotionalColor;
  final Color mathematikColor;
  final Color lernenLeistenColor;
  final Color deutschColor;
  final Color spracheSprechenColor;
  final Color germanColor;
  final Color mathColor;
  final Color scienceColor;
  final Color englishColor;
  final Color artColor;
  final Color musicColor;
  final Color sportColor;
  final Color religionColor;
  final Color workBehaviourColor;
  final Color socialColor;
  final Color ogsColor;
  final Color groupColor;
  final Color schoolyearColor;
  final Color snackBarInfoColor;
  final Color snackBarSuccessColor;
  final Color snackBarWarningColor;
  final Color snackBarErrorColor;
  final Color filterChipSelectedColor;
  final Color filterChipUnselectedColor;
  final Color filterChipSelectedCheckColor;
  final Color schooldayEventReasonChipUnselectedColor;
  final Color schooldayEventReasonChipSelectedColor;
  final Color schooldayEventReasonChipSelectedCheckColor;

  AppColorPalette copyWith({
    AppColorSchemeKey? key,
    String? displayName,
    Color? backgroundColor,
    Color? interactiveColor,
    Color? accentColor,
    Color? canvasColor,
    Color? gridViewColor,
    Color? pupilProfileBackgroundColor,
    Color? pupilProfileCardColor,
    Color? cardInCardColor,
    Color? cardInCardBorderColor,
    Color? notProcessedColor,
    Color? mainMenuCardsColor,
    Color? selectedCardColor,
    Color? appStyleButtonColor,
    Color? successButtonColor,
    Color? warningButtonColor,
    Color? dangerButtonColor,
    Color? cancelButtonColor,
    Color? presentColor,
    Color? missedColor,
    Color? lateColor,
    Color? homeColor,
    Color? unexcusedCheckColor,
    Color? contactedQuestionColor,
    Color? contactedSuccessColor,
    Color? contactedCalledBackColor,
    Color? contactedFailedColor,
    Color? goneHomeColor,
    Color? koerperWahrnehmungMotorikColor,
    Color? sozialEmotionalColor,
    Color? mathematikColor,
    Color? lernenLeistenColor,
    Color? deutschColor,
    Color? spracheSprechenColor,
    Color? germanColor,
    Color? mathColor,
    Color? scienceColor,
    Color? englishColor,
    Color? artColor,
    Color? musicColor,
    Color? sportColor,
    Color? religionColor,
    Color? workBehaviourColor,
    Color? socialColor,
    Color? ogsColor,
    Color? groupColor,
    Color? schoolyearColor,
    Color? snackBarInfoColor,
    Color? snackBarSuccessColor,
    Color? snackBarWarningColor,
    Color? snackBarErrorColor,
    Color? filterChipSelectedColor,
    Color? filterChipUnselectedColor,
    Color? filterChipSelectedCheckColor,
    Color? schooldayEventReasonChipUnselectedColor,
    Color? schooldayEventReasonChipSelectedColor,
    Color? schooldayEventReasonChipSelectedCheckColor,
  }) {
    return AppColorPalette(
      key: key ?? this.key,
      displayName: displayName ?? this.displayName,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      interactiveColor: interactiveColor ?? this.interactiveColor,
      accentColor: accentColor ?? this.accentColor,
      canvasColor: canvasColor ?? this.canvasColor,
      gridViewColor: gridViewColor ?? this.gridViewColor,
      pupilProfileBackgroundColor:
          pupilProfileBackgroundColor ?? this.pupilProfileBackgroundColor,
      pupilProfileCardColor:
          pupilProfileCardColor ?? this.pupilProfileCardColor,
      cardInCardColor: cardInCardColor ?? this.cardInCardColor,
      cardInCardBorderColor:
          cardInCardBorderColor ?? this.cardInCardBorderColor,
      notProcessedColor: notProcessedColor ?? this.notProcessedColor,
      mainMenuCardsColor: mainMenuCardsColor ?? this.mainMenuCardsColor,
      selectedCardColor: selectedCardColor ?? this.selectedCardColor,
      appStyleButtonColor: appStyleButtonColor ?? this.appStyleButtonColor,
      successButtonColor: successButtonColor ?? this.successButtonColor,
      warningButtonColor: warningButtonColor ?? this.warningButtonColor,
      dangerButtonColor: dangerButtonColor ?? this.dangerButtonColor,
      cancelButtonColor: cancelButtonColor ?? this.cancelButtonColor,
      presentColor: presentColor ?? this.presentColor,
      missedColor: missedColor ?? this.missedColor,
      lateColor: lateColor ?? this.lateColor,
      homeColor: homeColor ?? this.homeColor,
      unexcusedCheckColor: unexcusedCheckColor ?? this.unexcusedCheckColor,
      contactedQuestionColor:
          contactedQuestionColor ?? this.contactedQuestionColor,
      contactedSuccessColor:
          contactedSuccessColor ?? this.contactedSuccessColor,
      contactedCalledBackColor:
          contactedCalledBackColor ?? this.contactedCalledBackColor,
      contactedFailedColor: contactedFailedColor ?? this.contactedFailedColor,
      goneHomeColor: goneHomeColor ?? this.goneHomeColor,
      koerperWahrnehmungMotorikColor:
          koerperWahrnehmungMotorikColor ?? this.koerperWahrnehmungMotorikColor,
      sozialEmotionalColor: sozialEmotionalColor ?? this.sozialEmotionalColor,
      mathematikColor: mathematikColor ?? this.mathematikColor,
      lernenLeistenColor: lernenLeistenColor ?? this.lernenLeistenColor,
      deutschColor: deutschColor ?? this.deutschColor,
      spracheSprechenColor: spracheSprechenColor ?? this.spracheSprechenColor,
      germanColor: germanColor ?? this.germanColor,
      mathColor: mathColor ?? this.mathColor,
      scienceColor: scienceColor ?? this.scienceColor,
      englishColor: englishColor ?? this.englishColor,
      artColor: artColor ?? this.artColor,
      musicColor: musicColor ?? this.musicColor,
      sportColor: sportColor ?? this.sportColor,
      religionColor: religionColor ?? this.religionColor,
      workBehaviourColor: workBehaviourColor ?? this.workBehaviourColor,
      socialColor: socialColor ?? this.socialColor,
      ogsColor: ogsColor ?? this.ogsColor,
      groupColor: groupColor ?? this.groupColor,
      schoolyearColor: schoolyearColor ?? this.schoolyearColor,
      snackBarInfoColor: snackBarInfoColor ?? this.snackBarInfoColor,
      snackBarSuccessColor: snackBarSuccessColor ?? this.snackBarSuccessColor,
      snackBarWarningColor: snackBarWarningColor ?? this.snackBarWarningColor,
      snackBarErrorColor: snackBarErrorColor ?? this.snackBarErrorColor,
      filterChipSelectedColor:
          filterChipSelectedColor ?? this.filterChipSelectedColor,
      filterChipUnselectedColor:
          filterChipUnselectedColor ?? this.filterChipUnselectedColor,
      filterChipSelectedCheckColor:
          filterChipSelectedCheckColor ?? this.filterChipSelectedCheckColor,
      schooldayEventReasonChipUnselectedColor:
          schooldayEventReasonChipUnselectedColor ??
          this.schooldayEventReasonChipUnselectedColor,
      schooldayEventReasonChipSelectedColor:
          schooldayEventReasonChipSelectedColor ??
          this.schooldayEventReasonChipSelectedColor,
      schooldayEventReasonChipSelectedCheckColor:
          schooldayEventReasonChipSelectedCheckColor ??
          this.schooldayEventReasonChipSelectedCheckColor,
    );
  }
}

class AppColorPalettes {
  static const classic = AppColorPalette(
    key: AppColorSchemeKey.classic,
    displayName: 'Classic Indigo',
    backgroundColor: Color.fromRGBO(74, 76, 161, 1),
    interactiveColor: Color.fromRGBO(74, 76, 161, 1),
    accentColor: Color.fromRGBO(252, 160, 39, 1),
    canvasColor: Color(0xfff2f2f7),
    gridViewColor: Color.fromRGBO(252, 160, 39, 1),
    pupilProfileBackgroundColor: Color.fromARGB(255, 215, 215, 235),
    pupilProfileCardColor: Color(0xfff2f2f7),
    cardInCardColor: Color.fromARGB(255, 248, 248, 255),
    cardInCardBorderColor: Color.fromARGB(255, 195, 195, 253),
    notProcessedColor: Color.fromARGB(255, 249, 202, 131),
    mainMenuCardsColor: Color.fromARGB(255, 220, 220, 255),
    selectedCardColor: Color.fromARGB(255, 255, 220, 168),
    appStyleButtonColor: Color.fromRGBO(252, 160, 39, 1),
    successButtonColor: Color.fromARGB(255, 139, 195, 74),
    warningButtonColor: Color.fromARGB(255, 239, 108, 0),
    dangerButtonColor: Color.fromARGB(255, 239, 56, 0),
    cancelButtonColor: Color.fromARGB(255, 250, 65, 19),
    presentColor: Color.fromRGBO(238, 238, 238, 1),
    missedColor: Color.fromRGBO(255, 183, 77, 1),
    lateColor: Color.fromRGBO(255, 241, 118, 1),
    homeColor: Colors.lightBlue,
    unexcusedCheckColor: Color.fromRGBO(239, 108, 0, 1),
    contactedQuestionColor: Color.fromRGBO(238, 238, 238, 1),
    contactedSuccessColor: Color.fromRGBO(139, 195, 74, 1),
    contactedCalledBackColor: Color.fromRGBO(255, 183, 77, 1),
    contactedFailedColor: Color.fromRGBO(239, 108, 0, 1),
    goneHomeColor: Colors.blue,
    koerperWahrnehmungMotorikColor: Color.fromARGB(255, 156, 76, 149),
    sozialEmotionalColor: Color.fromARGB(255, 233, 127, 22),
    mathematikColor: Color.fromARGB(255, 5, 118, 172),
    lernenLeistenColor: Color.fromARGB(255, 5, 155, 88),
    deutschColor: Color.fromARGB(255, 228, 70, 60),
    spracheSprechenColor: Color.fromARGB(255, 244, 198, 17),
    germanColor: Color.fromARGB(255, 151, 0, 65),
    mathColor: Color.fromARGB(255, 204, 60, 77),
    scienceColor: Color.fromARGB(255, 235, 108, 60),
    englishColor: Color.fromARGB(255, 246, 173, 90),
    artColor: Color.fromARGB(255, 251, 223, 134),
    musicColor: Color.fromARGB(255, 231, 245, 147),
    sportColor: Color.fromARGB(255, 176, 221, 162),
    religionColor: Color.fromARGB(255, 114, 194, 164),
    workBehaviourColor: Color.fromARGB(255, 67, 137, 191),
    socialColor: Color.fromARGB(255, 94, 80, 164),
    ogsColor: Color.fromRGBO(126, 87, 194, 1),
    groupColor: Color.fromARGB(255, 78, 196, 82),
    schoolyearColor: Color.fromARGB(255, 153, 92, 211),
    snackBarInfoColor: Colors.blue,
    snackBarSuccessColor: Colors.green,
    snackBarWarningColor: Colors.orange,
    snackBarErrorColor: Colors.red,
    filterChipSelectedColor: Color.fromRGBO(74, 76, 161, 1),
    filterChipUnselectedColor: Color.fromRGBO(138, 139, 203, 1),
    filterChipSelectedCheckColor: Colors.green,
    schooldayEventReasonChipUnselectedColor: Color.fromARGB(255, 248, 162, 93),
    schooldayEventReasonChipSelectedColor: Color.fromARGB(255, 239, 137, 13),
    schooldayEventReasonChipSelectedCheckColor: Color.fromARGB(
      255,
      249,
      56,
      56,
    ),
  );

  static final lila = classic.copyWith(
    key: AppColorSchemeKey.lila,
    displayName: 'lila',
    backgroundColor: const Color.fromARGB(255, 107, 13, 126),
    interactiveColor: const Color.fromARGB(255, 107, 13, 126),
    accentColor: const Color.fromARGB(255, 216, 141, 3),
    gridViewColor: const Color.fromARGB(255, 216, 141, 3),
  );

  static final darkBlue = classic.copyWith(
    key: AppColorSchemeKey.darkBlue,
    displayName: 'darkBlue',
    backgroundColor: const Color.fromARGB(255, 40, 28, 105),
    interactiveColor: const Color.fromARGB(255, 40, 28, 105),
    accentColor: const Color.fromARGB(255, 255, 172, 78),
    gridViewColor: const Color.fromARGB(255, 255, 172, 78),
  );

  static final Map<AppColorSchemeKey, AppColorPalette> _byKey = {
    AppColorSchemeKey.classic: classic,
    AppColorSchemeKey.lila: lila,
    AppColorSchemeKey.darkBlue: darkBlue,
  };

  static Iterable<AppColorPalette> get all => _byKey.values;

  static AppColorPalette byKey(AppColorSchemeKey key) => _byKey[key] ?? classic;
}

class AppColors {
  static final Signal<AppColorPalette> _activePalette = signal(
    AppColorPalettes.classic,
  );

  static AppColorPalette get palette => _activePalette.value;
  static Signal<AppColorPalette> get paletteSignal => _activePalette;

  static AppColorSchemeKey get activeSchemeKey => palette.key;

  static List<AppColorPalette> availablePalettes() =>
      AppColorPalettes.all.toList();

  static void setPalette(AppColorSchemeKey key) {
    _activePalette.value = AppColorPalettes.byKey(key);
  }

  static void setPaletteByKeyString(String? key) {
    setPalette(appColorSchemeKeyFromString(key));
  }

  //- COLORS

  static Color get backgroundColor => palette.backgroundColor;
  static Color get interactiveColor => palette.interactiveColor;
  static Color get accentColor => palette.accentColor;
  static Color get canvasColor => palette.canvasColor;
  static Color get gridViewColor => palette.gridViewColor;
  static Color get pupilProfileBackgroundColor =>
      palette.pupilProfileBackgroundColor;
  static Color get pupilProfileCardColor => palette.pupilProfileCardColor;
  static Color get cardInCardColor => palette.cardInCardColor;
  static Color get cardInCardBorderColor => palette.cardInCardBorderColor;
  static Color get notProcessedColor => palette.notProcessedColor;
  static Color get mainMenuCardsColor => palette.mainMenuCardsColor;
  static Color get selectedCardColor => palette.selectedCardColor;

  //button colors

  static Color get appStyleButtonColor => palette.appStyleButtonColor;
  static Color get successButtonColor => palette.successButtonColor;
  static Color get warningButtonColor => palette.warningButtonColor;
  static Color get dangerButtonColor => palette.dangerButtonColor;
  static Color get cancelButtonColor => palette.cancelButtonColor;

  //- attendance card colors

  // missedType dropdown
  static Color get presentColor => palette.presentColor;
  static Color get missedColor => palette.missedColor;
  static Color get lateColor => palette.lateColor;
  static Color get homeColor => palette.homeColor;

  // excused checkbox
  static Color get unexcusedCheckColor => palette.unexcusedCheckColor;

  // contacted dropdown
  static Color get contactedQuestionColor => palette.contactedQuestionColor;
  static Color get contactedSuccessColor => palette.contactedSuccessColor;
  static Color get contactedCalledBackColor => palette.contactedCalledBackColor;
  static Color get contactedFailedColor => palette.contactedFailedColor;
  static Color get goneHomeColor => palette.goneHomeColor;

  //- support category colors

  static Color get koerperWahrnehmungMotorikColor =>
      palette.koerperWahrnehmungMotorikColor;
  static Color get sozialEmotionalColor => palette.sozialEmotionalColor;
  static Color get mathematikColor => palette.mathematikColor;
  static Color get lernenLeistenColor => palette.lernenLeistenColor;
  static Color get deutschColor => palette.deutschColor;
  static Color get spracheSprechenColor => palette.spracheSprechenColor;

  //- Competence colors

  static Color get germanColor => palette.germanColor;
  static Color get mathColor => palette.mathColor;
  static Color get scienceColor => palette.scienceColor;
  static Color get englishColor => palette.englishColor;
  static Color get artColor => palette.artColor;
  static Color get musicColor => palette.musicColor;
  static Color get sportColor => palette.sportColor;
  static Color get religionColor => palette.religionColor;
  static Color get workBehaviourColor => palette.workBehaviourColor;
  static Color get socialColor => palette.socialColor;

  static Color bestContrastCompetenceFontColor(Color color) {
    if (color == palette.musicColor) {
      return const Color.fromARGB(255, 99, 179, 103);
    }
    if (color == palette.artColor) {
      return const Color.fromARGB(255, 252, 134, 0);
    }
    return Colors.white;
  }

  //- text colors
  static Color get ogsColor => palette.ogsColor;
  static Color get groupColor => palette.groupColor;
  static Color get schoolyearColor => palette.schoolyearColor;

  //- snackbars

  static Color get snackBarInfoColor => palette.snackBarInfoColor;
  static Color get snackBarSuccessColor => palette.snackBarSuccessColor;
  static Color get snackBarWarningColor => palette.snackBarWarningColor;
  static Color get snackBarErrorColor => palette.snackBarErrorColor;

  //- filterchips

  static Color get filterChipSelectedColor => palette.filterChipSelectedColor;
  static Color get filterChipUnselectedColor =>
      palette.filterChipUnselectedColor;
  static Color get filterChipSelectedCheckColor =>
      palette.filterChipSelectedCheckColor;

  static Color get schooldayEventReasonChipUnselectedColor =>
      palette.schooldayEventReasonChipUnselectedColor;
  static Color get schooldayEventReasonChipSelectedColor =>
      palette.schooldayEventReasonChipSelectedColor;
  static Color get schooldayEventReasonChipSelectedCheckColor =>
      palette.schooldayEventReasonChipSelectedCheckColor;
}
