import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/widgets/color_picker_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/widgets/description_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/widgets/name_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/widgets/public_id_field.dart';
import 'package:watch_it/watch_it.dart';

class NewSubjectPage extends WatchingWidget {
  final Subject? subject;

  const NewSubjectPage({super.key, this.subject});

  bool get _isEditing => subject != null;

  @override
  Widget build(BuildContext context) {
    final nameController = createOnce<TextEditingController>(() {
      return TextEditingController(text: subject?.name ?? '');
    });

    final publicIdController = createOnce<TextEditingController>(() {
      return TextEditingController(text: subject?.publicId ?? '');
    });

    final descriptionController = createOnce<TextEditingController>(() {
      return TextEditingController(text: subject?.description ?? '');
    });

    final selectedColor = createOnce<ValueNotifier<String>>(() {
      return ValueNotifier<String>(subject?.color ?? '#FF5722');
    });

    final timetableManager = di<TimetableManager>();

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(
        iconData: Icons.subject,
        title: _isEditing ? 'Fach bearbeiten' : 'Neues Fach',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fachdetails',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            NameField(controller: nameController),
            const SizedBox(height: 16),
            PublicIdField(controller: publicIdController),
            const SizedBox(height: 16),
            DescriptionField(controller: descriptionController),
            const SizedBox(height: 16),
            ColorPickerField(selectedColor: selectedColor),
            const SizedBox(height: 32),
            ActionButtons(
              onSave: () async {
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bitte geben Sie einen Namen ein'),
                    ),
                  );
                  return;
                }

                if (publicIdController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bitte geben Sie eine öffentliche ID ein'),
                    ),
                  );
                  return;
                }

                final newSubject = Subject(
                  id: subject?.id,
                  publicId: publicIdController.text.trim(),
                  name: nameController.text.trim(),
                  description:
                      descriptionController.text.trim().isEmpty
                          ? null
                          : descriptionController.text.trim(),
                  color: selectedColor.value,
                  createdBy: subject?.createdBy ?? 'user',
                  createdAt: subject?.createdAt ?? DateTime.now().toUtc(),
                  modifiedBy: 'user',
                );

                if (_isEditing) {
                  await timetableManager.updateSubject(newSubject);
                } else {
                  await timetableManager.addSubject(newSubject);
                }

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              onCancel: () {
                Navigator.pop(context);
              },
              onDelete:
                  _isEditing
                      ? () async {
                        if (subject?.id != null) {
                          await timetableManager.removeSubject(subject!.id!);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      }
                      : null,
              isEditing: _isEditing,
            ),
          ],
        ),
      ),
    );
  }
}
