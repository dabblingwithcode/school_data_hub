import 'package:flutter/material.dart';

Future<void> showGenericBottomSheet(
    BuildContext parentContext, Widget bottomSheet) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: parentContext,
    builder: (_) => bottomSheet,
  );
}
