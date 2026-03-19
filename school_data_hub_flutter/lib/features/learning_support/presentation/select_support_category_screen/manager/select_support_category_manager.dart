import 'package:flutter/foundation.dart';

/// Manager for handling support category selection state
/// in the SelectSupportCategoryPage
class SelectSupportCategoryManager extends ChangeNotifier {
  final _selectedCategoryId = ValueNotifier<int?>(null);
  
  /// The currently selected category ID
  ValueListenable<int?> get selectedCategoryId => _selectedCategoryId;

  /// Select a category by ID
  void selectCategory(int id) {
    _selectedCategoryId.value = id;
  }

  /// Clear the current selection
  void clearSelection() {
    _selectedCategoryId.value = null;
  }

  @override
  void dispose() {
    _selectedCategoryId.dispose();
    super.dispose();
  }
}