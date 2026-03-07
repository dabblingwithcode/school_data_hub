import 'package:flutter/foundation.dart';

/// Contract for a source of search/filter text that the widget can observe
/// (e.g. clear the text field when the external source is cleared).
abstract class SearchTextSource {
  Listenable get listenable;
  String get text;
}
