import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Provides [UserWithDevices] by matrix user id to descendants (e.g. list item builder).
class MatrixUserAppUserMapScope extends InheritedWidget {
  const MatrixUserAppUserMapScope({
    required this.appUserByMatrixId,
    required super.child,
    super.key,
  });

  final Map<String?, UserWithDevices> appUserByMatrixId;

  static Map<String?, UserWithDevices> of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<MatrixUserAppUserMapScope>();
    return scope?.appUserByMatrixId ?? {};
  }

  @override
  bool updateShouldNotify(MatrixUserAppUserMapScope oldWidget) =>
      appUserByMatrixId != oldWidget.appUserByMatrixId;
}
