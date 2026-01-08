import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final _log = Logger('[BottomNavManager]');

class BottomNavManager {
  final _bottomNavState = ValueNotifier<int>(0);
  ValueListenable<int> get bottomNavState => _bottomNavState;

  final _pupilProfileNavState = ValueNotifier<int>(0);
  ValueListenable<int> get pupilProfileNavState => _pupilProfileNavState;

  BottomNavManager() {
    _bottomNavState.value = 0;
  }

  void setBottomNavPage(int index) {
    _bottomNavState.value = index;
  }

  void setPupilProfileNavPage(int index) {
    _pupilProfileNavState.value = index;
    _log.info('PupilProfileNavPage set to $index');
  }

  void dispose() {
    _bottomNavState.dispose();
    _pupilProfileNavState.dispose();
    _log.info('BottomNavManager disposed');
  }
}
