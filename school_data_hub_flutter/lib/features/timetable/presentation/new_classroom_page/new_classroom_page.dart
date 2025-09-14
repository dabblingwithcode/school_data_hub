import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_classroom_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_classroom_page/widgets/room_code_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_classroom_page/widgets/room_name_field.dart';
import 'package:watch_it/watch_it.dart';

// Barrel exports
export 'widgets/action_buttons.dart';
export 'widgets/room_code_field.dart';
export 'widgets/room_name_field.dart';

class NewClassroomPage extends WatchingWidget {
  final Classroom? classroom;

  const NewClassroomPage({super.key, this.classroom});

  bool get _isEditing => classroom != null;

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    // Create form key using createOnce
    final formKey = createOnce<GlobalKey<FormState>>(
      () => GlobalKey<FormState>(),
    );

    // Create text editing controllers using createOnce
    final roomCodeController = createOnce<TextEditingController>(() {
      final controller = TextEditingController();
      if (_isEditing && classroom != null) {
        controller.text = classroom!.roomCode;
      }
      return controller;
    });

    final roomNameController = createOnce<TextEditingController>(() {
      final controller = TextEditingController();
      if (_isEditing && classroom != null) {
        controller.text = classroom!.roomName;
      }
      return controller;
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.meeting_room, size: 25, color: Colors.white),
            const Gap(10),
            Text(
              _isEditing ? 'Raum bearbeiten' : 'Neuer Raum',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Room code field
                  RoomCodeField(controller: roomCodeController),
                  const Gap(20),

                  // Room name field
                  RoomNameField(controller: roomNameController),
                  const Gap(32),

                  // Action buttons
                  ActionButtons(
                    isEditing: _isEditing,
                    onSave: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      final roomCode = roomCodeController.text.trim();
                      final roomName = roomNameController.text.trim();

                      if (roomCode.isEmpty || roomName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Bitte füllen Sie alle Pflichtfelder aus',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (_isEditing && classroom != null) {
                        // Update existing classroom
                        final updatedClassroom = classroom!.copyWith(
                          roomCode: roomCode,
                          roomName: roomName,
                        );

                        timetableManager.updateClassroom(updatedClassroom);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Raum erfolgreich aktualisiert'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.of(context).pop();
                      } else {
                        // Create new classroom
                        final newClassroom = Classroom(
                          roomCode: roomCode,
                          roomName: roomName,
                        );

                        timetableManager.addClassroom(newClassroom);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Raum erfolgreich erstellt'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.of(context).pop(newClassroom);
                      }
                    },
                    onCancel: () => Navigator.of(context).pop(),
                    onDelete:
                        _isEditing
                            ? () {
                              if (classroom?.id == null) return;

                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text('Raum löschen'),
                                      content: Text(
                                        'Sind Sie sicher, dass Sie den Raum "${classroom!.roomCode} - ${classroom!.roomName}" löschen möchten?\n\n'
                                        'Diese Aktion kann nicht rückgängig gemacht werden.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(context).pop(),
                                          child: const Text('Abbrechen'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            timetableManager.removeClassroom(
                                              classroom!.id!,
                                            );
                                            Navigator.of(
                                              context,
                                            ).pop(); // Close dialog
                                            Navigator.of(
                                              context,
                                            ).pop(); // Close page

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Raum "${classroom!.roomCode} - ${classroom!.roomName}" wurde gelöscht',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('Löschen'),
                                        ),
                                      ],
                                    ),
                              );
                            }
                            : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
