import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:watch_it/watch_it.dart';

final _learningSupportManager = di<LearningSupportManager>();

class SupportCategoryTree extends StatelessWidget {
  final int? parentId;
  final int indentation;
  final Color? backGroundColor;
  const SupportCategoryTree(
      {required this.parentId,
      required this.indentation,
      this.backGroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> goalCategoryWidgets = [];

    List<SupportCategory> goalCategories =
        _learningSupportManager.supportCategories.value;
    Color categoryBackgroundColor = backGroundColor ?? Colors.blue;
    for (var goalCategory in goalCategories) {
      if (backGroundColor == null) {
        if (goalCategory.name == 'Körper, Wahrnehmung, Motorik') {
          categoryBackgroundColor = AppColors.koerperWahrnehmungMotorikColor;
        } else if (goalCategory.name == 'Sozialkompetenz / Emotionalität') {
          categoryBackgroundColor = AppColors.sozialEmotionalColor;
        } else if (goalCategory.name == 'Mathematik') {
          categoryBackgroundColor = AppColors.mathematikColor;
        } else if (goalCategory.name == 'Lernen und Leisten') {
          categoryBackgroundColor = AppColors.lernenLeistenColor;
        } else if (goalCategory.name == 'Deutsch') {
          categoryBackgroundColor = AppColors.deutschColor;
        } else if (goalCategory.name == 'Sprache und Sprechen') {
          categoryBackgroundColor = AppColors.spracheSprechenColor;
        }
      } else {
        categoryBackgroundColor = backGroundColor!;
      }

      if (goalCategory.parentCategory == parentId) {
        final children = buildCategoryTree(
            goalCategory.categoryId, indentation + 1, categoryBackgroundColor);

        goalCategoryWidgets.add(
          Padding(
            padding: EdgeInsets.only(top: 10, left: 5.0 * indentation),
            child: children.isNotEmpty
                ? Wrap(
                    children: [
                      Card(
                        color: categoryBackgroundColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.zero,
                        child: ExpansionTile(
                          iconColor: Colors.white,
                          collapsedTextColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          textColor: Colors.white,
                          maintainState: true,
                          backgroundColor: categoryBackgroundColor,
                          title: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    goalCategory.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          goalCategory.parentCategory == null
                                              ? 20
                                              : 16,
                                    ),
                                  ),
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
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            goalCategory.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );

        //return goalCategoryWidgets;
      }
    }
    return Column(
      children: goalCategoryWidgets,
    );
  }
}

List<Widget> buildCategoryTree(
    int? parentId, int indentation, Color? backGroundColor) {
  List<Widget> goalCategoryWidgets = [];

  List<SupportCategory> supportCategories =
      _learningSupportManager.supportCategories.value;
  Color categoryBackgroundColor = backGroundColor ?? Colors.blue;
  for (var goalCategory in supportCategories) {
    if (backGroundColor == null) {
      if (goalCategory.name == 'Körper, Wahrnehmung, Motorik') {
        categoryBackgroundColor = const Color.fromARGB(255, 156, 76, 149);
      } else if (goalCategory.name == 'Sozialkompetenz / Emotionalität') {
        categoryBackgroundColor = const Color.fromARGB(255, 233, 127, 22);
      } else if (goalCategory.name == 'Mathematik') {
        categoryBackgroundColor = const Color.fromARGB(255, 5, 118, 172);
      } else if (goalCategory.name == 'Lernen und Leisten') {
        categoryBackgroundColor = const Color.fromARGB(255, 5, 155, 88);
      } else if (goalCategory.name == 'Deutsch') {
        categoryBackgroundColor = const Color.fromARGB(255, 228, 70, 60);
      } else if (goalCategory.name == 'Sprache und Sprechen') {
        categoryBackgroundColor = const Color.fromARGB(255, 244, 198, 17);
      }
    } else {
      categoryBackgroundColor = backGroundColor;
    }

    if (goalCategory.parentCategory == parentId) {
      final children = buildCategoryTree(
          goalCategory.categoryId, indentation + 1, categoryBackgroundColor);

      goalCategoryWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: 10, left: 5.0 * indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Card(
                      color: categoryBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        maintainState: true,
                        backgroundColor: categoryBackgroundColor,
                        title: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  goalCategory.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
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
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          goalCategory.name,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );

      //return goalCategoryWidgets;
    }
  }

  return goalCategoryWidgets;
}
