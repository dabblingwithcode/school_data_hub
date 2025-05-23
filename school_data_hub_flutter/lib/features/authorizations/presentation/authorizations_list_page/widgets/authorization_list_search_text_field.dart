import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/authorization_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

final _authorizationFilterManager = di<AuthorizationFilterManager>();
final _filtersStateManager = di<FiltersStateManager>();

class AuthorizationListSearchTextField extends WatchingStatefulWidget {
  final SearchType searchType;
  final String hintText;
  final Function refreshFunction;
  const AuthorizationListSearchTextField(
      {required this.searchType,
      required this.hintText,
      required this.refreshFunction,
      super.key});

  @override
  State<AuthorizationListSearchTextField> createState() =>
      _AuthorizationListSearchTextFieldState();
}

class _AuthorizationListSearchTextFieldState
    extends State<AuthorizationListSearchTextField> {
  final schoolListFilter = _authorizationFilterManager.filteredAuthorizations;

  //final searchManager = locator<SearchManager>();
  FocusNode focusNode = FocusNode();
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final textFilter = watch(locator<PupilsFilter>().textFilter);
    final filtersOn =
        watchValue((AuthorizationFilterManager x) => x.filterState);

    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (value) => _authorizationFilterManager.onSearchText(value),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        filled: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: filtersOn
            ? IconButton(
                icon: const Icon(
                  Icons.close_outlined,
                ),
                onPressed: () {
                  _filtersStateManager.resetFilters();

                  textEditingController.clear();
                },
                color: Colors.black45,
              )
            : IconButton(
                onPressed: () => widget.refreshFunction,
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black45,
                ),
              ),
        suffixIcon: const SizedBox.shrink(),
      ),
    );
  }
}
