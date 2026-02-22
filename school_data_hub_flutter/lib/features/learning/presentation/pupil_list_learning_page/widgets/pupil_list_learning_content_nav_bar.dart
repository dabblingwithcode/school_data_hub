import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';

class PupilListLearningContentNavBar extends WatchingWidget {
  const PupilListLearningContentNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedContent = watchValue(
      (CompetenceManager m) => m.selectedLearningContent,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (di<HubSessionManager>().isAdmin)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    isSelected:
                        selectedContent == SelectedContent.competenceStatuses,
                    icon: Icon(
                      Icons.lightbulb,
                      color: AppColors.interactiveColor,
                    ),
                    selectedIcon: Icon(
                      Icons.lightbulb,
                      color: AppColors.accentColor,
                    ),
                    onPressed: () {
                      if (selectedContent !=
                          SelectedContent.competenceStatuses) {
                        di<CompetenceManager>().setSelectedContent(
                          SelectedContent.competenceStatuses,
                        );

                        return;
                      }
                    },
                  ),
                  Text(
                    'Lernspuren',
                    style: TextStyle(
                      color:
                          selectedContent == SelectedContent.competenceStatuses
                          ? AppColors.accentColor
                          : AppColors.interactiveColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            if (di<HubSessionManager>().isTester)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    isSelected:
                        selectedContent == SelectedContent.competenceGoals,
                    icon: Icon(
                      Icons.emoji_nature_rounded,
                      color: AppColors.interactiveColor,
                    ),
                    selectedIcon: Icon(
                      Icons.emoji_nature_rounded,
                      color: AppColors.accentColor,
                    ),
                    onPressed: () {
                      if (selectedContent != SelectedContent.competenceGoals) {
                        di<CompetenceManager>().setSelectedContent(
                          SelectedContent.competenceGoals,
                        );

                        return;
                      }
                    },
                  ),
                  Text(
                    'Ziele',
                    style: TextStyle(
                      color: selectedContent == SelectedContent.competenceGoals
                          ? AppColors.accentColor
                          : AppColors.interactiveColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            if (di<HubSessionManager>().isTester)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    isSelected: selectedContent == SelectedContent.workbooks,
                    icon: Icon(
                      Icons.note_alt,
                      color: AppColors.interactiveColor,
                    ),
                    selectedIcon: Icon(
                      Icons.note_alt,
                      color: AppColors.accentColor,
                    ),
                    onPressed: () {
                      if (selectedContent != SelectedContent.workbooks) {
                        di<CompetenceManager>().setSelectedContent(
                          SelectedContent.workbooks,
                        );

                        return;
                      }
                    },
                  ),
                  Text(
                    'Arbeitshefte',
                    style: TextStyle(
                      color: selectedContent == SelectedContent.workbooks
                          ? AppColors.accentColor
                          : AppColors.interactiveColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  isSelected: selectedContent == SelectedContent.books,
                  icon: Icon(Icons.book, color: AppColors.interactiveColor),
                  selectedIcon: Icon(Icons.book, color: AppColors.accentColor),
                  onPressed: () {
                    if (selectedContent != SelectedContent.books) {
                      di<CompetenceManager>().setSelectedContent(
                        SelectedContent.books,
                      );

                      return;
                    }
                  },
                ),
                Text(
                  'Bücher',
                  style: TextStyle(
                    color: selectedContent == SelectedContent.books
                        ? AppColors.accentColor
                        : AppColors.interactiveColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
