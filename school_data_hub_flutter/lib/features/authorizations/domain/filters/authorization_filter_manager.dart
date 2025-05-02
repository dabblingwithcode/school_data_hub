import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/domain/filters/filters_state_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';

class AuthorizationFilterManager {
  final ValueNotifier<List<Authorization>> _filteredAuthorizations =
      ValueNotifier<List<Authorization>>([]);
  ValueListenable<List<Authorization>> get filteredAuthorizations =>
      _filteredAuthorizations;

  ValueListenable<bool> get filterState => _filterState;
  final _filterState = ValueNotifier<bool>(false);

  AuthorizationFilterManager init() {
    resetFilters();
    return this;
  }

  resetFilters() {
    _filterState.value = false;
    _filteredAuthorizations.value =
        locator<AuthorizationManager>().authorizations.value;
    locator<FiltersStateManager>()
        .setFilterState(filterState: FilterState.authorization, value: false);
  }

  onSearchText(String text) {
    if (text.isEmpty) {
      _filteredAuthorizations.value =
          locator<AuthorizationManager>().authorizations.value;
      _filterState.value = false;
      return;
    }
    _filterState.value = true;
    String lowerCaseText = text.toLowerCase();
    _filteredAuthorizations.value = locator<AuthorizationManager>()
        .authorizations
        .value
        .where((element) =>
            element.authorizationName.toLowerCase().contains(lowerCaseText))
        .toList();
  }
}
