import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:watch_it/watch_it.dart';

class PupilSearchTextField extends WatchingStatefulWidget {
  final SearchType searchType;
  final String hintText;
  final Function refreshFunction;
  const PupilSearchTextField({
    required this.searchType,
    required this.hintText,
    required this.refreshFunction,
    super.key,
  });

  @override
  State<PupilSearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<PupilSearchTextField> {
  final pupilsFilter = di<PupilsFilter>();

  //final searchManager = locator<SearchManager>();
  FocusNode focusNode = FocusNode();
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    if (di<PupilsFilter>().textFilter.text == '') {
      textEditingController.clear();
    }
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (value) => di<PupilsFilter>().textFilter.setFilterText(value),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        filled: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: filtersOn
            ? IconButton(
                icon: const Icon(Icons.close_outlined),
                onPressed: () => di<PupilsFilter>().resetFilters(),
                color: Colors.black45,
              )
            : IconButton(
                onPressed: () => widget.refreshFunction,
                icon: const Icon(Icons.search_outlined, color: Colors.black45),
              ),
        suffixIcon: const SizedBox.shrink(),
      ),
    );
  }
}
