import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/matrix_rooms_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:watch_it/watch_it.dart';

enum SelectedMatrixContent {
  rooms,
  users,
  compulsoryRooms,
  settings,
}

class SelectedMatrixContentNotifier extends ChangeNotifier {
  // Private constructor
  SelectedMatrixContentNotifier._privateConstructor();

  // Static instance
  static final SelectedMatrixContentNotifier _instance =
      SelectedMatrixContentNotifier._privateConstructor();

  // Factory constructor
  factory SelectedMatrixContentNotifier() {
    return _instance;
  }

  SelectedMatrixContent _selectedContent = SelectedMatrixContent.rooms;

  SelectedMatrixContent get selectedContent => _selectedContent;

  void select(SelectedMatrixContent content) {
    _selectedContent = content;
    notifyListeners();
  }
}

class MatrixEntryPageTopNavBar extends WatchingWidget {
  const MatrixEntryPageTopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedContentNotifier = SelectedMatrixContentNotifier();
    final selectedContent = watch(selectedContentNotifier).selectedContent;

    return Column(
      children: [
        const MatrixContentNavBar(),
        Padding(
            padding: const EdgeInsets.only(top: 5),
            child: (selectedContent == SelectedMatrixContent.rooms)
                ? const MatrixRoomsListPage()
                : (selectedContent == SelectedMatrixContent.users)
                    ? const MatrixUsersListPage()
                    : (selectedContent == SelectedMatrixContent.compulsoryRooms)
                        ? const SizedBox() // Placeholder widget
                        : const SizedBox() // Default case
            )
      ],
    );
  }
}

class MatrixContentNavBar extends WatchingWidget {
  //final PupilProxy pupil;

  const MatrixContentNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedContentNotifier = SelectedMatrixContentNotifier();
    final selectedContent = watch(selectedContentNotifier).selectedContent;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              isSelected: selectedContent == SelectedMatrixContent.rooms,
              icon: const Icon(
                Icons.meeting_room_rounded,
                size: 30,
                color: AppColors.interactiveColor,
              ),
              selectedIcon: const Icon(
                Icons.meeting_room_rounded,
                size: 30,
                color: AppColors.accentColor,
              ),
              onPressed: () {
                if (selectedContent != SelectedMatrixContent.rooms) {
                  selectedContentNotifier.select(SelectedMatrixContent.rooms);

                  return;
                }
              },
            ),
            IconButton(
              isSelected: selectedContent == SelectedMatrixContent.users,
              icon: const Icon(
                Icons.people_alt_rounded,
                size: 30,
                color: AppColors.interactiveColor,
              ),
              selectedIcon: const Icon(
                Icons.people_alt_rounded,
                size: 30,
                color: AppColors.accentColor,
              ),
              onPressed: () {
                if (selectedContent != SelectedMatrixContent.users) {
                  selectedContentNotifier.select(SelectedMatrixContent.users);

                  return;
                }
              },
            ),
            // IconButton(
            //   isSelected:
            //       selectedContent == SelectedMatrixContent.compulsoryRooms,
            //   icon: const Icon(
            //     Icons.note_alt,
            //     color: AppColors.interactiveColor,
            //   ),
            //   selectedIcon: const Icon(
            //     Icons.note_alt,
            //     color: AppColors.accentColor,
            //   ),
            //   onPressed: () {
            //     if (selectedContent != SelectedMatrixContent.compulsoryRooms) {
            //       selectedContentNotifier
            //           .select(SelectedMatrixContent.compulsoryRooms);

            //       return;
            //     }
            //   },
            // ),
            // IconButton(
            //   isSelected: selectedContent == SelectedMatrixContent.settings,
            //   icon: const Icon(
            //     Icons.book,
            //     color: AppColors.interactiveColor,
            //   ),
            //   selectedIcon: const Icon(
            //     Icons.book,
            //     color: AppColors.accentColor,
            //   ),
            //   onPressed: () {
            //     if (selectedContent != SelectedMatrixContent.settings) {
            //       selectedContentNotifier
            //           .select(SelectedMatrixContent.settings);

            //       return;
            //     }
            //   },
            // ),
          ],
        ),
      ],
    );
  }
}
