import 'package:flutter/foundation.dart';

enum SelectedContent {
  competenceStatuses,
  competenceGoals,
  competenceReports,
  workbooks,
  books,
  none,
}

class LearningContentSelection {
  final _selectedContent = ValueNotifier<SelectedContent>(
    SelectedContent.books,
  );
  ValueListenable<SelectedContent> get selectedContent => _selectedContent;

  void setSelectedContent(SelectedContent content) {
    _selectedContent.value = content;
  }

  void dispose() {
    _selectedContent.dispose();
  }
}
