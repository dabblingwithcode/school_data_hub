import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

final _log = Logger('PupilTextFilter');

class PupilTextFilter extends Filter<PupilProxy> {
  PupilTextFilter({required super.name});

  String _text = '';
  String get text => _text;

  void setFilterText(String text) {
    _text = text;
    if (text.isEmpty) {
      toggle(false);
      notifyListeners();
      return;
    }
    toggle(true);
    _log.finer('Setting pupil filter text: $text');
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
