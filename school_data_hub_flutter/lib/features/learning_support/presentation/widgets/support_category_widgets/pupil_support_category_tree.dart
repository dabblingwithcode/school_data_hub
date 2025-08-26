import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_page/controller/select_support_category_controller.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

final _learningSupportManager = di<SupportCategoryManager>();
final _hubSessionManager = di<HubSessionManager>();

List<Widget> pupilSupportCategoryTree({
  required BuildContext context,
  required PupilProxy pupil,
  int? parentCategoryId,
  required double indentation,
  Color? backGroundColor,
  required SelectCategoryPageController controller,
  required String elementType,
}) {
  List<Widget> supportCategoryWidgets = [];

  List<SupportCategory> supportCategories =
      _learningSupportManager.supportCategories.value;
  Color categoryBackgroundColor;

  for (SupportCategory supportCategory in supportCategories) {
    if (backGroundColor == null) {
      categoryBackgroundColor =
          LearningSupportHelper.getRootSupportCategoryColor(supportCategory);
    } else {
      categoryBackgroundColor = backGroundColor;
    }

    if (supportCategory.parentCategory == parentCategoryId) {
      final children = pupilSupportCategoryTree(
          context: context,
          pupil: pupil,
          parentCategoryId: supportCategory.categoryId,
          indentation: indentation + 15,
          backGroundColor: categoryBackgroundColor,
          controller: controller,
          elementType: elementType);

      supportCategoryWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: 10, left: indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Card(
                      color: categoryBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        maintainState: false,
                        backgroundColor: categoryBackgroundColor,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      supportCategory.name,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        collapsedBackgroundColor: categoryBackgroundColor,
                        children: children,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child:
                                // getCategoryStatus(
                                //             pupil, goalCategory.categoryId) ==
                                //         null
                                //     ?
                                Radio(
                              value: supportCategory.categoryId,
                              groupValue: controller.selectedCategoryId,
                              onChanged: (value) {
                                controller.selectCategory(value!);
                              },
                            ),
                            // : const Row(children: [
                            //     Gap(7),
                            //     Icon(
                            //       Icons.support,
                            //       color: Colors.white,
                            //     )
                            //   ]),
                          ),
                          const Gap(5),
                          Flexible(
                            child: InkWell(
                              onTap: () => controller
                                  .selectCategory(supportCategory.categoryId),
                              onLongPress: _hubSessionManager.isAdmin
                                  ? () async {
                                      if (pupil
                                          .supportCategoryStatuses!.isEmpty) {
                                        return;
                                      }
                                      final bool? delete =
                                          await confirmationDialog(
                                              context: context,
                                              title: 'Kategoriestatus löschen',
                                              message:
                                                  'Kategoriestatus löschen?');
                                      if (delete == true) {
                                        // final SupportCategoryStatus?
                                        //     supportCategoryStatus = pupil
                                        //         .supportCategoryStatuses!
                                        //         .lastWhereOrNull((element) =>
                                        //             element.supportCategoryId ==
                                        //             supportCategory.categoryId);
                                        // TODO: uncomment when ready
                                        // await _learningSupportManager
                                        //     .deleteSupportCategoryStatus(
                                        //         supportCategoryStatus!
                                        //             .statusId);
                                      }
                                      return;
                                    }
                                  : () {},
                              child: Text(
                                supportCategory.name,
                                maxLines: 4,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    }
  }

  return supportCategoryWidgets;
}
