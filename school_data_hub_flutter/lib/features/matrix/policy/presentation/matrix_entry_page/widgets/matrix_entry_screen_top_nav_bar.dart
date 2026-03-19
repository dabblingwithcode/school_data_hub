import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/matrix_event_reports_screen/matrix_event_reports_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/matrix_rooms_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_screen.dart';

enum SelectedMatrixContent { rooms, users, reports, compulsoryRooms, settings }

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

class MatrixEntryScreenTopNavBar extends WatchingWidget {
  const MatrixEntryScreenTopNavBar({super.key});

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
              ? const MatrixRoomsListScreen()
              : (selectedContent == SelectedMatrixContent.users)
              ? const MatrixUsersListScreen()
              : (selectedContent == SelectedMatrixContent.reports)
              ? const MatrixEventReportsScreen()
              : (selectedContent == SelectedMatrixContent.compulsoryRooms)
              ? const SizedBox() // Placeholder widget
              : const SizedBox(), // Default case
        ),
      ],
    );
  }
}

class MatrixContentNavBar extends WatchingWidget {
  //final PupilProxy pupil;

  const MatrixContentNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final selectedContentNotifier = SelectedMatrixContentNotifier();
    final selectedContent = watch(selectedContentNotifier).selectedContent;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              isSelected: selectedContent == SelectedMatrixContent.rooms,
              icon: Icon(
                Icons.meeting_room_rounded,
                size: 30,
                color: style.colors.accent,
              ),
              selectedIcon: Icon(
                Icons.meeting_room_rounded,
                size: 30,
                color: style.colors.accent,
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
              icon: Icon(
                Icons.people_alt_rounded,
                size: 30,
                color: style.colors.accent,
              ),
              selectedIcon: Icon(
                Icons.people_alt_rounded,
                size: 30,
                color: style.colors.accent,
              ),
              onPressed: () {
                if (selectedContent != SelectedMatrixContent.users) {
                  selectedContentNotifier.select(SelectedMatrixContent.users);

                  return;
                }
              },
            ),
            IconButton(
              isSelected: selectedContent == SelectedMatrixContent.reports,
              icon: Icon(
                Icons.flag_circle_rounded,
                size: 30,
                color: style.colors.accent,
              ),
              selectedIcon: Icon(
                Icons.flag_circle_rounded,
                size: 30,
                color: style.colors.accent,
              ),
              onPressed: () {
                if (selectedContent != SelectedMatrixContent.reports) {
                  selectedContentNotifier.select(SelectedMatrixContent.reports);

                  return;
                }
              },
            ),
            // IconButton(
            //   isSelected:
            //       selectedContent == SelectedMatrixContent.compulsoryRooms,
            //   icon: const Icon(
            //     Icons.note_alt,
            //     color: style.colors.accent,
            //   ),
            //   selectedIcon: const Icon(
            //     Icons.note_alt,
            //     color: style.colors.accent,
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
            //     color: style.colors.accent,
            //   ),
            //   selectedIcon: const Icon(
            //     Icons.book,
            //     color: style.colors.accent,
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
