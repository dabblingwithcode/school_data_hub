import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListFilterManager = di<SchoolListFilterManager>();
final _filtersStateManager = di<FiltersStateManager>();

class SchoolListSearchTextField extends WatchingStatefulWidget {
  final SearchType searchType;
  final String hintText;
  final Function refreshFunction;
  const SchoolListSearchTextField(
      {required this.searchType,
      required this.hintText,
      required this.refreshFunction,
      super.key});

  @override
  State<SchoolListSearchTextField> createState() =>
      _SchoolListSearchTextFieldState();
}

class _SchoolListSearchTextFieldState extends State<SchoolListSearchTextField> {
  final schoolListFilter = _schoolListFilterManager.filteredSchoolLists;

  //final searchManager = locator<SearchManager>();
  FocusNode focusNode = FocusNode();
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final textFilter = watch(locator<PupilsFilter>().textFilter);
    final filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (value) => _schoolListFilterManager.onSearchEnter(value),
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
