import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_books.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_competence_goals.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_competence_statuses.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/pupil_learning_content/pupil_learning_content_workbooks.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

enum SelectedContent {
  competenceStatuses,
  competenceGoals,
  workbooks,
  books,
  none,
}

class SelectedLearningContentNotifier extends ChangeNotifier {
  // Private constructor
  SelectedLearningContentNotifier._privateConstructor();

  // Static instance
  static final SelectedLearningContentNotifier _instance =
      SelectedLearningContentNotifier._privateConstructor();

  // Factory constructor
  factory SelectedLearningContentNotifier() {
    return _instance;
  }

  SelectedContent _selectedContent = SelectedContent.books;

  SelectedContent get selectedContent => _selectedContent;

  void select(SelectedContent content) {
    _selectedContent = content;
    notifyListeners();
  }
}

class PupilLearningContentExpansionTileNavBar extends WatchingWidget {
  final PupilProxy pupil;

  const PupilLearningContentExpansionTileNavBar({
    required this.pupil,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedContentNotifier = SelectedLearningContentNotifier();
    final selectedContent = watch(selectedContentNotifier).selectedContent;

    return Column(
      children: [
        const PupilLearningContentNavBar(),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: (selectedContent == SelectedContent.competenceStatuses)
              ? PupilLearningContentCompetenceStatuses(pupil: pupil)
              : (selectedContent == SelectedContent.competenceGoals)
              ? PupilLearningContentCompetenceGoals(pupil: pupil)
              : (selectedContent == SelectedContent.workbooks)
              ? PupilLearningContentWorkbooks(pupil: pupil)
              :
                //  (selectedContent == SelectedContent.books):
                PupilLearningContentBooks(pupil: pupil),
        ),
      ],
    );
  }
}

class PupilLearningContentNavBar extends WatchingWidget {
  //final PupilProxy pupil;

  const PupilLearningContentNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedContentNotifier = SelectedLearningContentNotifier();
    final selectedContent = watch(selectedContentNotifier).selectedContent;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (di<HubSessionManager>().isTester)
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
                        selectedContentNotifier.select(
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
                        selectedContentNotifier.select(
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
                        selectedContentNotifier.select(
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
                  icon: Icon(
                    Icons.book,
                    color: AppColors.interactiveColor,
                  ),
                  selectedIcon: Icon(
                    Icons.book,
                    color: AppColors.accentColor,
                  ),
                  onPressed: () {
                    if (selectedContent != SelectedContent.books) {
                      selectedContentNotifier.select(SelectedContent.books);

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
