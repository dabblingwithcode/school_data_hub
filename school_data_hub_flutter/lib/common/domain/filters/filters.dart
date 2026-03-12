import 'package:flutter/material.dart';

abstract class Filter<T extends Object> with ChangeNotifier {
  Filter({
    required this.name,
    this.displayNameActive,
    this.displayNameInactive,
  });

  final String name;
  final String? displayNameActive;
  final String? displayNameInactive;

  Color get color => isActive ? Colors.blue : Colors.grey;

  String get displayName =>
      isActive ? displayNameActive ?? name : displayNameInactive ?? name;

  bool _isActive = false;
  bool get isActive => _isActive;

  /// Optional callback invoked after toggle. Set by the composition root
  /// (e.g. PupilsFilterImplementation) to wire filter state changes to
  /// global state managers without coupling the base class to DI.
  void Function(Filter<T> filter, bool isActive)? onToggle;

  void reset() {
    _isActive = false;
    notifyListeners();
  }

  void toggle(bool isActive) {
    _isActive = isActive;
    notifyListeners();
    onToggle?.call(this, isActive);
  }

  bool matches(T item);
}

class SelectorFilter<T extends Object, V extends Object> extends Filter<T> {
  SelectorFilter({
    required super.name,
    required this.selector,
    super.displayNameActive,
    super.displayNameInactive,
  });

  final V Function(T) selector;

  @override
  bool matches(T item) {
    return selector(item) == name;
  }
}

class TextFilter extends SelectorFilter<String, String> {
  TextFilter({
    required super.name,
    this.filterText = '',
    required super.selector,
    super.displayNameActive,
    super.displayNameInactive,
  });

  String filterText = '';

  void setFilterText(String text) {
    filterText = text;
    notifyListeners();
  }
}
