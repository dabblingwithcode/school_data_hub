import 'package:flutter/foundation.dart';

class MainMenuBottomNavManager {
  final _bottomNavState = ValueNotifier<int>(0);
  ValueListenable<int> get bottomNavState => _bottomNavState;

  final _pupilProfileNavState = ValueNotifier<int>(0);
  ValueListenable<int> get pupilProfileNavState => _pupilProfileNavState;

  MainMenuBottomNavManager() {
    _bottomNavState.value = 0;
  }

  setBottomNavPage(int index) {
    _bottomNavState.value = index;
  }

  setPupilProfileNavPage(int index) {
    _pupilProfileNavState.value = index;
  }
}
