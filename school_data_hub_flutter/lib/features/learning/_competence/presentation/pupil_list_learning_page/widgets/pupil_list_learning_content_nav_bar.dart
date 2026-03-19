import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/env/models/enums.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/learning_content_selection.dart';

class PupilListLearningContentNavBar extends WatchingWidget {
  const PupilListLearningContentNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final selectedContent = watchValue(
      (LearningContentSelection s) => s.selectedContent,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (di<EnvManager>().activeEnv!.runMode != HubRunMode.production)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    isSelected:
                        selectedContent == SelectedContent.competenceStatuses,
                    icon: Icon(
                      Icons.lightbulb,
                      color: style.colors.interactive,
                    ),
                    selectedIcon: Icon(
                      Icons.lightbulb,
                      color: style.colors.accent,
                    ),
                    onPressed: () {
                      if (selectedContent !=
                          SelectedContent.competenceStatuses) {
                        di<LearningContentSelection>().setSelectedContent(
                          SelectedContent.competenceStatuses,
                        );

                        return;
                      }
                    },
                  ),
                  Text(
                    'Lernspuren',
                    style: context.typography.bodySmall.withColor(
                      selectedContent == SelectedContent.competenceStatuses
                          ? style.colors.accent
                          : style.colors.interactive,
                    ),
                  ),
                ],
              ),
            if (di<EnvManager>().activeEnv!.runMode != HubRunMode.production)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    isSelected:
                        selectedContent == SelectedContent.competenceGoals,
                    icon: Icon(
                      Icons.emoji_nature_rounded,
                      color: style.colors.interactive,
                    ),
                    selectedIcon: Icon(
                      Icons.emoji_nature_rounded,
                      color: style.colors.accent,
                    ),
                    onPressed: () {
                      if (selectedContent != SelectedContent.competenceGoals) {
                        di<LearningContentSelection>().setSelectedContent(
                          SelectedContent.competenceGoals,
                        );

                        return;
                      }
                    },
                  ),
                  Text(
                    'Ziele',
                    style: context.typography.bodySmall.withColor(
                      selectedContent == SelectedContent.competenceGoals
                          ? style.colors.accent
                          : style.colors.interactive,
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
                      color: style.colors.interactive,
                    ),
                    selectedIcon: Icon(
                      Icons.note_alt,
                      color: style.colors.accent,
                    ),
                    onPressed: () {
                      if (selectedContent != SelectedContent.workbooks) {
                        di<LearningContentSelection>().setSelectedContent(
                          SelectedContent.workbooks,
                        );

                        return;
                      }
                    },
                  ),
                  Text(
                    'Arbeitshefte',
                    style: context.typography.bodySmall.withColor(
                      selectedContent == SelectedContent.workbooks
                          ? style.colors.accent
                          : style.colors.interactive,
                    ),
                  ),
                ],
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  isSelected: selectedContent == SelectedContent.books,
                  icon: Icon(Icons.book, color: style.colors.interactive),
                  selectedIcon: Icon(Icons.book, color: style.colors.accent),
                  onPressed: () {
                    if (selectedContent != SelectedContent.books) {
                      di<LearningContentSelection>().setSelectedContent(
                        SelectedContent.books,
                      );

                      return;
                    }
                  },
                ),
                Text(
                  'Buecher',
                  style: context.typography.bodySmall.withColor(
                    selectedContent == SelectedContent.books
                        ? style.colors.accent
                        : style.colors.interactive,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  isSelected:
                      selectedContent == SelectedContent.competenceReports,
                  icon: Icon(
                    Icons.assignment,
                    color: style.colors.interactive,
                  ),
                  selectedIcon: Icon(
                    Icons.assignment,
                    color: style.colors.accent,
                  ),
                  onPressed: () {
                    if (selectedContent != SelectedContent.competenceReports) {
                      di<LearningContentSelection>().setSelectedContent(
                        SelectedContent.competenceReports,
                      );

                      return;
                    }
                  },
                ),
                Text(
                  'Zeugnisse',
                  style: context.typography.bodySmall.withColor(
                    selectedContent == SelectedContent.competenceReports
                        ? style.colors.accent
                        : style.colors.interactive,
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
