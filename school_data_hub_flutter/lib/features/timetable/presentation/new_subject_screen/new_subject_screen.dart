import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/color_picker_field.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_screen/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_screen/widgets/description_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_screen/widgets/name_field.dart';

class NewSubjectScreen extends WatchingWidget {
  final Subject? subject;

  const NewSubjectScreen({super.key, this.subject});

  bool get _isEditing => subject != null;

  @override
  Widget build(BuildContext context) {
    final nameController = createOnce<TextEditingController>(() {
      return TextEditingController(text: subject?.name ?? '');
    });

    final descriptionController = createOnce<TextEditingController>(() {
      return TextEditingController(text: subject?.description ?? '');
    });

    final selectedColor = createOnce<ValueNotifier<String>>(() {
      return ValueNotifier<String>(subject?.color ?? '#FF5722');
    });

    final timetableManager = di<TimetableManager>();

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: AppHeader(
        iconData: Icons.subject,
        title: _isEditing ? 'Fach bearbeiten' : 'Neues Fach',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fachdetails', style: context.typography.title),
            Gap(Style.spacing.lg),
            NameField(controller: nameController),
            Gap(Style.spacing.lg),
            DescriptionField(controller: descriptionController),
            Gap(Style.spacing.lg),
            ColorPickerField(selectedColor: selectedColor),
            Gap(Style.spacing.xxl),
            ActionButtons(
              onSave: () async {
                if (nameController.text.trim().isEmpty) {
                  di<NotificationManager>().showSnackBar(
                    NotificationType.warning,
                    'Bitte geben Sie einen Namen ein',
                  );
                  return;
                }

                final publicId = _isEditing
                    ? subject!.publicId
                    : 'SUB-${DateTime.now().millisecondsSinceEpoch}';

                final newSubject = Subject(
                  id: subject?.id,
                  publicId: publicId,
                  name: nameController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  color: selectedColor.value,
                  createdBy: subject?.createdBy ?? 'user',
                  createdAt: subject?.createdAt ?? DateTime.now().toUtc(),
                  modifiedBy: 'user',
                );

                if (_isEditing) {
                  await timetableManager.updateSubject(newSubject);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  await timetableManager.addSubject(newSubject);
                  if (context.mounted) {
                    Navigator.pop(context, newSubject);
                  }
                }
              },
              onCancel: () {
                Navigator.pop(context);
              },
              onDelete: _isEditing
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
