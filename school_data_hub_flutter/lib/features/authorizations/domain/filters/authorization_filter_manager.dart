import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationFilterManager {
  AuthorizationManager get _authorizationManager => di<AuthorizationManager>();
  FiltersStateManager get _filtersStateManager => di<FiltersStateManager>();
  final ValueNotifier<List<Authorization>> _filteredAuthorizations =
      ValueNotifier<List<Authorization>>([]);
  ValueListenable<List<Authorization>> get filteredAuthorizations =>
      _filteredAuthorizations;

  ValueListenable<bool> get filterState => _filterState;
  final _filterState = ValueNotifier<bool>(false);

  String _currentSearchText = '';

  AuthorizationFilterManager init() {
    _authorizationManager.authorizations.addListener(_onAuthorizationsChanged);

    resetFilters();
    return this;
  }

  void dispose() {
    _authorizationManager.authorizations.removeListener(
      _onAuthorizationsChanged,
    );
    _filterState.dispose();
    _filteredAuthorizations.dispose();
    return;
  }

  void _onAuthorizationsChanged() {
    // If we have an active filter, reapply it to the new data
    if (_filterState.value && _currentSearchText.isNotEmpty) {
      _applySearchFilter(_currentSearchText);
    } else {
      // Otherwise, just update with the new full list
      _filteredAuthorizations.value =
          _authorizationManager.authorizations.value;
    }
  }

  void resetFilters() {
    _filterState.value = false;
    _filteredAuthorizations.value = _authorizationManager.authorizations.value;
    _filtersStateManager.setFilterState(
      filterState: FilterState.authorization,
      value: false,
    );
  }

  void onSearchText(String text) {
    _currentSearchText = text;
    if (text.isEmpty) {
      _filteredAuthorizations.value =
          di<AuthorizationManager>().authorizations.value;
      _filterState.value = false;
      return;
    }
    _filterState.value = true;
    _applySearchFilter(text);
  }

  void _applySearchFilter(String text) {
    String lowerCaseText = text.toLowerCase();
    _filteredAuthorizations.value = _authorizationManager.authorizations.value
        .where((element) => element.name.toLowerCase().contains(lowerCaseText))
        .toList();
  }
}
