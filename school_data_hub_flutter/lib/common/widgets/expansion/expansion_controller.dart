import 'package:flutter/foundation.dart';

class ExpansionController {
  ExpansionController({bool initiallyExpanded = false})
    : isExpanded = ValueNotifier<bool>(initiallyExpanded);

  final ValueNotifier<bool> isExpanded;

  void expand() => isExpanded.value = true;
  void collapse() => isExpanded.value = false;
  void toggle() => isExpanded.value = !isExpanded.value;

  void dispose() => isExpanded.dispose();
}
