import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyFilterManager = di<MatrixPolicyFilterManager>();

class MatrixSearchTextField extends WatchingStatefulWidget {
  final SearchType searchType;
  final String hintText;
  final Function refreshFunction;
  const MatrixSearchTextField(
      {required this.searchType,
      required this.hintText,
      required this.refreshFunction,
      super.key});

  @override
  State<MatrixSearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<MatrixSearchTextField> {
  FocusNode focusNode = FocusNode();
  final textEditingController =
      _matrixPolicyFilterManager.searchController.value;

  @override
  Widget build(BuildContext context) {
    // final textFilter = watch(locator<PupilsFilter>().textFilter);
    bool filtersOn = watchValue((MatrixPolicyFilterManager x) => x.filtersOn);

    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        if (widget.searchType == SearchType.room) {
          _matrixPolicyFilterManager.setRoomsFilterText(value);
        } else {
          _matrixPolicyFilterManager.setUsersFilterText(value);
        }
      },
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
                  textEditingController.clear();
                  _matrixPolicyFilterManager.resetAllMatrixFilters();
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

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }
}
