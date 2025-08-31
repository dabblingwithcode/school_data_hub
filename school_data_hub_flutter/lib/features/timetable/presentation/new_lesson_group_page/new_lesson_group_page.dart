import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/action_buttons.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/color_picker_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/name_field.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/widgets/pupil_management_section.dart';
import 'package:watch_it/watch_it.dart';

class NewLessonGroupPage extends StatefulWidget {
  final LessonGroup? lessonGroup; // For editing existing lesson group

  const NewLessonGroupPage({super.key, this.lessonGroup});

  @override
  State<NewLessonGroupPage> createState() => _NewLessonGroupPageState();
}

class _NewLessonGroupPageState extends State<NewLessonGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedColor = '#2196F3'; // Default blue color
  List<int> _selectedPupilIds = [];

  late final TimetableManager _timetableManager;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _timetableManager = di<TimetableManager>();
    _isEditing = widget.lessonGroup != null;
    _initializeForm();
  }

  void _initializeForm() {
    if (_isEditing && widget.lessonGroup != null) {
      _nameController.text = widget.lessonGroup!.name;
      _selectedColor = widget.lessonGroup!.color ?? '#2196F3';

      // Load existing pupil memberships for this lesson group
      if (widget.lessonGroup!.id != null) {
        _selectedPupilIds = _timetableManager.getPupilIdsForLessonGroup(
          widget.lessonGroup!.id!,
        );
      } else {
        _selectedPupilIds = [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Klasse bearbeiten' : 'Neue Klasse'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            NameField(controller: _nameController),
            const SizedBox(height: 16),
            ColorPickerField(
              selectedColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
            const SizedBox(height: 16),
            // Pupil Management Section
            PupilManagementSection(
              timetableManager: _timetableManager,
              lessonGroupId: widget.lessonGroup?.id,
              selectedPupilIds: _selectedPupilIds,
              onPupilIdsChanged: (pupilIds) {
                setState(() {
                  _selectedPupilIds = pupilIds;
                });
              },
            ),
            const SizedBox(height: 24),
            ActionButtons(
              isEditing: _isEditing,
              onSave: _saveLessonGroup,
              onCancel: () => Navigator.of(context).pop(),
              onDelete: _isEditing ? _deleteLessonGroup : null,
            ),
          ],
        ),
      ),
    );
  }

  void _saveLessonGroup() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final currentTimetable = _timetableManager.timetable.value;

      if (currentTimetable?.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fehler: Kein Stundenplan ausgewählt'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final lessonGroup = LessonGroup(
        id: widget.lessonGroup?.id,
        publicId:
            widget.lessonGroup?.publicId ??
            'GROUP_${now.millisecondsSinceEpoch}',
        name: _nameController.text.trim(),
        color: _selectedColor,
        timetableId: currentTimetable!.id!,
        createdBy: widget.lessonGroup?.createdBy ?? 'user',
        createdAt: widget.lessonGroup?.createdAt ?? now,
        modifiedBy: 'user',
        modifiedAt: now,
      );

      if (_isEditing) {
        _timetableManager.updateLessonGroup(lessonGroup);
        // Update pupil memberships for existing lesson group
        if (widget.lessonGroup?.id != null) {
          _timetableManager.updatePupilMembershipsForLessonGroup(
            widget.lessonGroup!.id!,
            _selectedPupilIds,
          );
        }
      } else {
        _timetableManager.addLessonGroup(lessonGroup);
        // Add pupil memberships for new lesson group
        if (lessonGroup.id != null && _selectedPupilIds.isNotEmpty) {
          _timetableManager.updatePupilMembershipsForLessonGroup(
            lessonGroup.id!,
            _selectedPupilIds,
          );
        }
      }

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditing ? 'Klasse aktualisiert' : 'Klasse erstellt'),
        ),
      );
    }
  }

  void _deleteLessonGroup() {
    if (widget.lessonGroup?.id != null) {
      // Check if the lesson group is used in any scheduled lessons
      final scheduledLessons =
          _timetableManager.scheduledLessons.value
              .where((lesson) => lesson.lessonGroupId == widget.lessonGroup!.id)
              .toList();

      if (scheduledLessons.isNotEmpty) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Klasse kann nicht gelöscht werden'),
                content: Text(
                  'Diese Klasse wird in ${scheduledLessons.length} geplanten Stunden verwendet und kann nicht gelöscht werden.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
        return;
      }

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Klasse löschen'),
              content: const Text(
                'Sind Sie sicher, dass Sie diese Klasse löschen möchten?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Abbrechen'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _timetableManager.removeLessonGroup(
                      widget.lessonGroup!.id!,
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Klasse gelöscht')),
                    );
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Löschen'),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
