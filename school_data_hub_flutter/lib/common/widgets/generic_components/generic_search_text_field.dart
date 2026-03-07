import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/domain/search_text_source.dart';

class GenericSearchTextField extends StatefulWidget {
  final SearchType searchType;
  final String hintText;
  final VoidCallback refreshFunction;
  final ValueChanged<String> onChanged;
  final SearchTextSource? searchTextSource;
  final ValueListenable<bool> filtersActive;
  final VoidCallback onResetFilters;

  const GenericSearchTextField({
    required this.searchType,
    required this.hintText,
    required this.refreshFunction,
    required this.onChanged,
    required this.filtersActive,
    required this.onResetFilters,
    this.searchTextSource,
    super.key,
  });

  @override
  State<GenericSearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<GenericSearchTextField> {
  FocusNode focusNode = FocusNode();
  final textEditingController = TextEditingController();

  void _onSearchTextSourceChanged() {
    final source = widget.searchTextSource;
    if (source != null && source.text == '' && mounted) {
      textEditingController.clear();
    }
  }

  void _onFiltersActiveChanged() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.searchTextSource?.listenable.addListener(_onSearchTextSourceChanged);
    widget.filtersActive.addListener(_onFiltersActiveChanged);
  }

  @override
  void didUpdateWidget(covariant GenericSearchTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchTextSource != widget.searchTextSource) {
      oldWidget.searchTextSource?.listenable.removeListener(
        _onSearchTextSourceChanged,
      );
      widget.searchTextSource?.listenable.addListener(
        _onSearchTextSourceChanged,
      );
    }
    if (oldWidget.filtersActive != widget.filtersActive) {
      oldWidget.filtersActive.removeListener(_onFiltersActiveChanged);
      widget.filtersActive.addListener(_onFiltersActiveChanged);
    }
  }

  @override
  void dispose() {
    widget.searchTextSource?.listenable.removeListener(
      _onSearchTextSourceChanged,
    );
    widget.filtersActive.removeListener(_onFiltersActiveChanged);
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtersOn = widget.filtersActive.value;

    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onChanged: widget.onChanged,
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
                onPressed: widget.onResetFilters,
                color: Colors.black45,
              )
            : IconButton(
                onPressed: widget.refreshFunction,
                icon: const Icon(Icons.search_outlined, color: Colors.black45),
              ),
        suffixIcon: const SizedBox.shrink(),
      ),
    );
  }
}
