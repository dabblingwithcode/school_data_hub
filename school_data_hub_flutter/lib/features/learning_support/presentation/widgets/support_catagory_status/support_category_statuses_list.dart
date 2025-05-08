import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_catagory_status/widgets/support_category_status_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

List<Widget> pupilCategoryStatusesList(PupilProxy pupil, BuildContext context) {
  if (pupil.supportCategoryStatuses != null) {
    List<Widget> statusesWidgetList = [];

    Map<int, List<SupportCategoryStatus>> statusesWithDuplicateGoalCategory =
        {};
    for (SupportCategoryStatus status in pupil.supportCategoryStatuses!) {
      if (pupil.supportCategoryStatuses!.any((element) =>
          element.supportCategoryId == status.supportCategoryId &&
          pupil.supportCategoryStatuses!.indexOf(element) !=
              pupil.supportCategoryStatuses!.indexOf(status))) {
        //- This one is duplicate. Adding a key / widget in the map
        if (!statusesWithDuplicateGoalCategory
            .containsKey(status.supportCategoryId)) {
          statusesWithDuplicateGoalCategory[(status.supportCategoryId)] =
              List<SupportCategoryStatus>.empty(growable: true);
          statusesWithDuplicateGoalCategory[(status.supportCategoryId)]!
              .add(status);
        } else {
          statusesWithDuplicateGoalCategory[(status.supportCategoryId)]!
              .add(status);
        }

        log('Adding status vom ${status.createdAt.formatForUser()} erstellt von ${status.createdBy}');
      } else {
        statusesWidgetList.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SupportCategoryStatusCard(
                pupil: pupil, statusesWithSameGoalCategory: [status]),
          ),
        );
      }
    }
    //- Now let's build the statuses with multiple entries for a category
    if (statusesWithDuplicateGoalCategory.isNotEmpty) {
      for (int supportCategoryId in statusesWithDuplicateGoalCategory.keys) {
        log('Duplicate status, setting a key: $supportCategoryId');
        List<SupportCategoryStatus> mappedStatusesWithSameGoalCategory = [];

        mappedStatusesWithSameGoalCategory =
            statusesWithDuplicateGoalCategory[supportCategoryId]!;

        statusesWidgetList.add(
          SupportCategoryStatusCard(
            pupil: pupil,
            statusesWithSameGoalCategory: mappedStatusesWithSameGoalCategory,
          ),
        );
      }
    }
    return statusesWidgetList;
  }
  return [];
}
