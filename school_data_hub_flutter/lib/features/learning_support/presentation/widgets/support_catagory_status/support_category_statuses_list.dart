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

            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //       side: BorderSide(
            //         color: pupil.supportCategoryStatuses!.any((element) =>
            //                 element.supportCategoryId ==
            //                 status.supportCategoryId)
            //             ? Colors.green
            //             : accentColor,
            //         width: 2,
            //       )),
            //   child: Column(
            //     children: [
            //       const Gap(10),
            //       Row(
            //         children: [
            //           const Gap(10),
            //           Expanded(
            //             child: InkWell(
            //               onLongPress: () {
            //                 Navigator.of(context).push(MaterialPageRoute(
            //                     builder: (ctx) => NewSupportCategoryGoal(
            //                           appBarTitle: 'Neuer Status Förderbereich',
            //                           pupilId: pupil.internalId,
            //                           goalCategoryId: status.supportCategoryId,
            //                           elementType: 'status',
            //                         )));
            //               },
            //               child: Column(children: [
            //                 const Gap(5),
            //                 ...categoryTreeAncestorsNames(
            //                   categoryId: status.supportCategoryId,
            //                   categoryColor: supportCategoryColor,
            //                 ),
            //               ]),
            //             ),
            //           ),
            //           const Gap(10),
            //         ],
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5.0),
            //             color: supportCategoryColor,
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 5.0),
            //             child: Row(
            //               children: [
            //                 const Gap(10),
            //                 Flexible(
            //                   child: Text(
            //                     locator<LearningSupportManager>()
            //                         .getSupportCategory(
            //                             status.supportCategoryId)
            //                         .categoryName,
            //                     style: const TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 20,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       const Gap(10),
            //       SupportCategoryStatusEntry(
            //         pupil: pupil,
            //         status: status,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: ElevatedButton(
            //           style: actionButtonStyle,
            //           onPressed: () async {
            //             await Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (ctx) => NewSupportCategoryGoal(
            //                       appBarTitle: 'Neues Förderziel',
            //                       pupilId: pupil.internalId,
            //                       goalCategoryId: status.supportCategoryId,
            //                       elementType: 'goal',
            //                     )));
            //           },
            //           child: const Text(
            //             "NEUES FÖRDERZIEL",
            //             style: TextStyle(
            //                 fontSize: 17.0,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
