import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';

final _schoolListFilterManager = di<SchoolListFilterManager>();
final _filtersStateManager = di<FiltersStateManager>();

class SchoolListSearchTextField extends WatchingStatefulWidget {
  final SearchType searchType;
  final String hintText;
  final Function refreshFunction;
  const SchoolListSearchTextField({
    required this.searchType,
    required this.hintText,
    required this.refreshFunction,
    super.key,
  });

  @override
  State<SchoolListSearchTextField> createState() =>
      _SchoolListSearchTextFieldState();
}

class _SchoolListSearchTextFieldState extends State<SchoolListSearchTextField> {
  final schoolListFilter = _schoolListFilterManager.filteredSchoolLists;

  FocusNode focusNode = FocusNode();
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (value) =>
          _schoolListFilterManager.onSearchTextSchoolListsFilter(value),
      decoration: InputDecoration(
        fillColor: style.colors.background,
        filled: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: filtersOn
            ? IconButton(
                icon: const Icon(Icons.close_outlined),
                onPressed: () {
                  _filtersStateManager.resetFilters();
                  textEditingController.clear();
                },
                color: style.colors.mutedForeground,
              )
            : IconButton(
                onPressed: () => widget.refreshFunction,
                icon: Icon(
                  Icons.search_outlined,
                  color: style.colors.mutedForeground,
                ),
              ),
        suffixIcon: const SizedBox.shrink(),
      ),
    );
  }
}
