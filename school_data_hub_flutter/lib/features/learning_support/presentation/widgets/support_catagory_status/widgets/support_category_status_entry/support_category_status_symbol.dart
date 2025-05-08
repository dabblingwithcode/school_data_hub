import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

Widget getSupportCategoryStatusSymbol(
    PupilProxy pupil, int goalCategoryId, int statusId) {
  if (pupil.supportCategoryStatuses!.isNotEmpty) {
    final SupportCategoryStatus categoryStatus = pupil.supportCategoryStatuses!
        .firstWhere((element) =>
            element.supportCategoryId == goalCategoryId &&
            element.id! == statusId);

    switch (categoryStatus.status) {
      case 1:
        return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
      case 4:
        return SizedBox(width: 50, child: Image.asset('assets/growth_4-4.png'));
      case 3:
        return SizedBox(width: 50, child: Image.asset('assets/growth_3-4.png'));
      case 2:
        return SizedBox(width: 50, child: Image.asset('assets/growth_2-4.png'));
    }
    return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
  }

  return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
}

Widget getLastCategoryStatusSymbol(PupilProxy pupil, int goalCategoryId) {
  if (pupil.supportCategoryStatuses!.isNotEmpty) {
    final SupportCategoryStatus? categoryStatus = pupil.supportCategoryStatuses!
        .lastWhereOrNull(
            (element) => element.supportCategoryId == goalCategoryId);

    if (categoryStatus != null) {
      switch (categoryStatus.status) {
        case 1:
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_1-4.png'));
        case 4:
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_4-4.png'));
        case 3:
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_3-4.png'));
        // case 'orange':
        //   return Colors.orange;
        case 2:
          return SizedBox(
              width: 50, child: Image.asset('assets/growth_2-4.png'));
      }
    }
    return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
  }

  return SizedBox(width: 40, child: Image.asset('assets/growth_1-4.png'));
}
