import 'package:flutter/foundation.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/common/domain/search_text_source.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class PupilTextFilter extends Filter<PupilProxy> implements SearchTextSource {
  PupilTextFilter({required super.name});

  @override
  Listenable get listenable => this;

  String _text = '';
  @override
  String get text => _text;

  void setFilterText(String text) {
    _text = text;
    if (text.isEmpty) {
      toggle(false);
      notifyListeners();
      return;
    }
    toggle(true);

    notifyListeners();
    return;
  }

  @override
  void reset() {
    _text = '';
    super.reset();
  }

  @override
  bool matches(PupilProxy item) {
    return item.internalId.toString().contains(text) ||
        item.firstName.toLowerCase().contains(text.toLowerCase()) ||
        item.lastName.toLowerCase().contains(text.toLowerCase());
  }
}
