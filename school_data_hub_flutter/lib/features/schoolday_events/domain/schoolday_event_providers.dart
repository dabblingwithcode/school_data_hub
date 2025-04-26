import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schuldaten_hub/features/schoolday_events/domain/models/schoolday_event_enums.dart';

class DropdownNotifier extends StateNotifier<SchooldayEventType?> {
  DropdownNotifier() : super(SchooldayEventType.notSet);

  void selectEventType(SchooldayEventType? newValue) {
    if (newValue != null) {
      state = newValue;
    }
  }
}

final dropdownProvider =
    StateNotifierProvider<DropdownNotifier, SchooldayEventType?>((ref) {
  return DropdownNotifier();
});
