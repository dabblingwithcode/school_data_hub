import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

class NewScheduledLessonPage extends StatefulWidget {
  final TimetableManager timetableManager;
  final int? preselectedSlotId;
  final int? editingLessonId;

  const NewScheduledLessonPage({
    super.key,
    required this.timetableManager,
    this.preselectedSlotId,
    this.editingLessonId,
  });

  @override
  State<NewScheduledLessonPage> createState() => _NewScheduledLessonPageState();
}

class _NewScheduledLessonPageState extends State<NewScheduledLessonPage> {
  final _formKey = GlobalKey<FormState>();
  final _lessonIdController = TextEditingController();

  Subject? _selectedSubject;
  TimetableSlot? _selectedSlot;
  Classroom? _selectedClassroom;
  LessonGroup? _selectedLessonGroup;
  ScheduledLesson? _editingLesson;
  List<User> _selectedTeachers = [];
  int _dropdownKey = 0; // Key to force dropdown rebuild

  bool get _isEditing => widget.editingLessonId != null;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (_isEditing) {
      _editingLesson =
          widget.timetableManager.scheduledLessons.value
              .where((lesson) => lesson.id == widget.editingLessonId)
              .firstOrNull;

      if (_editingLesson != null) {
        _selectedSubject = widget.timetableManager.getSubjectById(
          _editingLesson!.subjectId,
        );
        _selectedSlot = widget.timetableManager.getTimetableSlotById(
          _editingLesson!.scheduledAtId,
        );
        _selectedClassroom = widget.timetableManager.getClassroomById(
          _editingLesson!.roomId,
        );
        _selectedLessonGroup = widget.timetableManager.getLessonGroupById(
          _editingLesson!.lessonGroupId,
        );
        _lessonIdController.text = _editingLesson!.lessonId;

        // TODO: Load selected teachers from ScheduledLessonTeacher relationships
        // When TimetableManager is extended with teacher relationships, load existing teachers like this:
        // _selectedTeachers = await TimetableManager.getTeachersForLesson(_editingLesson!.id!);
        _selectedTeachers = [];
      }
    } else {
      // Pre-select slot if provided
      if (widget.preselectedSlotId != null) {
        _selectedSlot = widget.timetableManager.getTimetableSlotById(
          widget.preselectedSlotId!,
        );
      }

      // Pre-select current lesson group
      _selectedLessonGroup = widget.timetableManager.selectedLessonGroup.value;

      // Initialize empty teacher list
      _selectedTeachers = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Stunde bearbeiten' : 'Neue Stunde'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteLesson,
              tooltip: 'Löschen',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Subject selection
            _buildSubjectDropdown(),
            const SizedBox(height: 16),

            // Time slot selection
            _buildTimeSlotDropdown(),
            const SizedBox(height: 16),

            // Classroom selection
            _buildClassroomDropdown(),
            const SizedBox(height: 16),

            // Lesson group selection
            _buildLessonGroupDropdown(),
            const SizedBox(height: 16),

            // Teacher selection
            _buildTeacherSelection(),
            const SizedBox(height: 16),

            // Lesson ID field
            _buildLessonIdField(),
            const SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveLesson,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(_isEditing ? 'Speichern' : 'Erstellen'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Abbrechen'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectDropdown() {
    return ValueListenableBuilder<List<Subject>>(
      valueListenable: widget.timetableManager.subjects,
      builder: (context, subjects, child) {
        return DropdownButtonFormField<Subject>(
          initialValue: _selectedSubject,
          decoration: const InputDecoration(
            labelText: 'Fach *',
            border: OutlineInputBorder(),
          ),
          items:
              subjects.map((subject) {
                return DropdownMenuItem<Subject>(
                  value: subject,
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _parseColor(subject.color),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(subject.name),
                    ],
                  ),
                );
              }).toList(),
          onChanged: (subject) {
            setState(() {
              _selectedSubject = subject;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Bitte wählen Sie ein Fach aus';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildTimeSlotDropdown() {
    return ValueListenableBuilder<List<TimetableSlot>>(
      valueListenable: widget.timetableManager.timetableSlots,
      builder: (context, slots, child) {
        return DropdownButtonFormField<TimetableSlot>(
          initialValue: _selectedSlot,
          decoration: const InputDecoration(
            labelText: 'Zeitslot *',
            border: OutlineInputBorder(),
          ),
          items:
              slots.map((slot) {
                return DropdownMenuItem<TimetableSlot>(
                  value: slot,
                  child: Text(
                    '${_getWeekdayName(slot.day)} ${slot.startTime} - ${slot.endTime}',
                  ),
                );
              }).toList(),
          onChanged: (slot) {
            setState(() {
              _selectedSlot = slot;

              // Reset lesson group if it conflicts with the new time slot
              if (_selectedLessonGroup != null &&
                  _hasLessonGroupConflict(_selectedLessonGroup!)) {
                _selectedLessonGroup = null;
              }

              // Reset classroom if it conflicts with the new time slot
              if (_selectedClassroom != null &&
                  _hasClassroomConflict(_selectedClassroom!)) {
                _selectedClassroom = null;
              }
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Bitte wählen Sie einen Zeitslot aus';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildClassroomDropdown() {
    return ValueListenableBuilder<List<Classroom>>(
      valueListenable: widget.timetableManager.classrooms,
      builder: (context, classrooms, child) {
        // Filter out classrooms that already have a lesson at the selected time slot
        final availableClassrooms =
            classrooms.where((classroom) {
              return !_hasClassroomConflict(classroom);
            }).toList();

        // Ensure the selected classroom is available in the filtered list
        final validInitialValue =
            _selectedClassroom != null &&
                    availableClassrooms.any(
                      (classroom) => classroom.id == _selectedClassroom!.id,
                    )
                ? _selectedClassroom
                : null;

        // Update state if the selected classroom is no longer valid
        if (_selectedClassroom != null && validInitialValue == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _selectedClassroom = null;
            });
          });
        }

        return DropdownButtonFormField<Classroom>(
          initialValue: validInitialValue,
          decoration: InputDecoration(
            labelText: 'Raum *',
            border: const OutlineInputBorder(),
            helperText:
                _selectedSlot != null
                    ? 'Nur verfügbare Räume für ${_getWeekdayName(_selectedSlot!.day)} ${_selectedSlot!.startTime}-${_selectedSlot!.endTime}'
                    : 'Wählen Sie zuerst einen Zeitslot aus',
          ),
          items:
              availableClassrooms.map((classroom) {
                return DropdownMenuItem<Classroom>(
                  value: classroom,
                  child: Text('${classroom.roomCode} - ${classroom.roomName}'),
                );
              }).toList(),
          onChanged: (classroom) {
            setState(() {
              _selectedClassroom = classroom;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Bitte wählen Sie einen Raum aus';
            }

            // Additional validation: check for conflicts
            if (_hasClassroomConflict(value)) {
              return 'Dieser Raum ist bereits zu dieser Zeit belegt';
            }

            return null;
          },
        );
      },
    );
  }

  Widget _buildLessonGroupDropdown() {
    return ValueListenableBuilder<List<LessonGroup>>(
      valueListenable: widget.timetableManager.lessonGroups,
      builder: (context, lessonGroups, child) {
        // Filter out lesson groups that already have a lesson at the selected time slot
        final availableLessonGroups =
            lessonGroups.where((group) {
              return !_hasLessonGroupConflict(group);
            }).toList();

        // Ensure the selected lesson group is available in the filtered list
        final validInitialValue =
            _selectedLessonGroup != null &&
                    availableLessonGroups.any(
                      (group) => group.id == _selectedLessonGroup!.id,
                    )
                ? _selectedLessonGroup
                : null;

        // Update state if the selected lesson group is no longer valid
        if (_selectedLessonGroup != null && validInitialValue == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _selectedLessonGroup = null;
            });
          });
        }

        return DropdownButtonFormField<LessonGroup>(
          initialValue: validInitialValue,
          decoration: InputDecoration(
            labelText: 'Klasse *',
            border: const OutlineInputBorder(),
            helperText:
                _selectedSlot != null
                    ? 'Nur verfügbare Klassen für ${_getWeekdayName(_selectedSlot!.day)} ${_selectedSlot!.startTime}-${_selectedSlot!.endTime}'
                    : 'Wählen Sie zuerst einen Zeitslot aus',
          ),
          items:
              availableLessonGroups.map((group) {
                return DropdownMenuItem<LessonGroup>(
                  value: group,
                  child: Text(group.name),
                );
              }).toList(),
          onChanged: (group) {
            setState(() {
              _selectedLessonGroup = group;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Bitte wählen Sie eine Klasse aus';
            }

            // Additional validation: check for conflicts
            if (_hasLessonGroupConflict(value)) {
              return 'Diese Klasse hat bereits eine Stunde zu dieser Zeit';
            }

            return null;
          },
        );
      },
    );
  }

  Widget _buildLessonIdField() {
    return TextFormField(
      controller: _lessonIdController,
      decoration: const InputDecoration(
        labelText: 'Stunden-ID',
        border: OutlineInputBorder(),
        hintText: 'z.B. L1_MONDAY',
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Bitte geben Sie eine Stunden-ID ein';
        }
        return null;
      },
    );
  }

  Widget _buildTeacherSelection() {
    final userManager = di<UserManager>();

    return ValueListenableBuilder<List<User>>(
      valueListenable: userManager.users,
      builder: (context, users, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lehrer *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  // Selected teachers
                  if (_selectedTeachers.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ausgewählte Lehrer:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                _selectedTeachers.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final teacher = entry.value;
                                  final isMainTeacher = index == 0;

                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          isMainTeacher
                                              ? Colors.orange.withValues(
                                                alpha: 0.1,
                                              )
                                              : Theme.of(
                                                context,
                                              ).chipTheme.backgroundColor,
                                      border: Border.all(
                                        color:
                                            isMainTeacher
                                                ? Colors.orange
                                                : Colors.grey.withValues(
                                                  alpha: 0.3,
                                                ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (isMainTeacher)
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Icon(
                                              Icons.star,
                                              size: 16,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: isMainTeacher ? 4.0 : 12.0,
                                            top: 8.0,
                                            bottom: 8.0,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                teacher.userInfo?.fullName ??
                                                    'Unbekannter Lehrer',
                                                style: TextStyle(
                                                  fontWeight:
                                                      isMainTeacher
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                ),
                                              ),
                                              if (isMainTeacher)
                                                const Text(
                                                  'Hauptlehrer',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        // Reorder buttons (only show if more than 1 teacher)
                                        if (_selectedTeachers.length > 1) ...[
                                          if (index > 0)
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  final temp =
                                                      _selectedTeachers[index];
                                                  _selectedTeachers[index] =
                                                      _selectedTeachers[index -
                                                          1];
                                                  _selectedTeachers[index - 1] =
                                                      temp;
                                                });
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          if (index <
                                              _selectedTeachers.length - 1)
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  final temp =
                                                      _selectedTeachers[index];
                                                  _selectedTeachers[index] =
                                                      _selectedTeachers[index +
                                                          1];
                                                  _selectedTeachers[index + 1] =
                                                      temp;
                                                });
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                        ],
                                        // Delete button
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedTeachers.remove(teacher);
                                            });
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.close, size: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                          if (_selectedTeachers.length > 1)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Tipp: Der erste Lehrer wird als Hauptlehrer gesetzt. Verwenden Sie ↑↓ um die Reihenfolge zu ändern.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  // Teacher dropdown
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField<int>(
                      key: Key(
                        'teacher_dropdown_$_dropdownKey',
                      ), // Force rebuild with key
                      initialValue:
                          null, // Always null since this is for adding new teachers
                      decoration: InputDecoration(
                        labelText: 'Lehrer hinzufügen',
                        border: const OutlineInputBorder(),
                        hintText:
                            users
                                    .where(
                                      (user) =>
                                          user.id != null &&
                                          _isUserAvailableAsTeacher(user) &&
                                          !_selectedTeachers.any(
                                            (selected) =>
                                                selected.id == user.id,
                                          ),
                                    )
                                    .isEmpty
                                ? 'Kein Personal mehr verfügbar!'
                                : 'Wählen Sie einen Lehrer aus...',
                      ),
                      items:
                          users
                              .where(
                                (user) =>
                                    user.id != null &&
                                    _isUserAvailableAsTeacher(user) &&
                                    !_selectedTeachers.any(
                                      (selected) => selected.id == user.id,
                                    ),
                              )
                              .toSet() // Remove any duplicates
                              .map((user) {
                                return DropdownMenuItem<int>(
                                  value: user.id!,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        child: Text(
                                          (user.userInfo?.fullName ?? 'U')[0]
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              user.userInfo?.fullName ??
                                                  'Unbekannter Lehrer',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              user.userInfo?.email ?? '',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                              .toList(),
                      onChanged: (userId) {
                        if (userId != null) {
                          final user =
                              users.where((u) => u.id == userId).firstOrNull;
                          if (user != null &&
                              !_selectedTeachers.any(
                                (selected) => selected.id == user.id,
                              )) {
                            setState(() {
                              _selectedTeachers.add(user);
                              _dropdownKey++; // Force dropdown rebuild to reset selection
                            });
                          }
                        }
                      },
                      validator: (value) {
                        if (_selectedTeachers.isEmpty) {
                          return 'Bitte wählen Sie mindestens einen Lehrer aus';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveLesson() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedSubject == null ||
        _selectedSlot == null ||
        _selectedClassroom == null ||
        _selectedLessonGroup == null ||
        _selectedTeachers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte füllen Sie alle Pflichtfelder aus'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final now = DateTime.now();

    if (_isEditing && _editingLesson != null) {
      // Update existing lesson
      final updatedLesson = _editingLesson!.copyWith(
        subjectId: _selectedSubject!.id!,
        subject: _selectedSubject,
        scheduledAtId: _selectedSlot!.id!,
        scheduledAt: _selectedSlot,
        lessonId: _lessonIdController.text.trim(),
        roomId: _selectedClassroom!.id!,
        room: _selectedClassroom,
        lessonGroupId: _selectedLessonGroup!.id!,
        lessonGroup: _selectedLessonGroup,
        mainTeacherId:
            _selectedTeachers
                .first
                .id!, // Use first selected teacher as main teacher
        modifiedBy: 'user', // TODO: Get actual user
        modifiedAt: now,
      );

      widget.timetableManager.updateScheduledLesson(updatedLesson);

      // TODO: Update ScheduledLessonTeacher relationships
      // When TimetableManager supports teacher relationships, implement:
      // await TimetableManager.updateTeachersForLesson(updatedLesson.id!, _selectedTeachers);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Stunde erfolgreich aktualisiert mit ${_selectedTeachers.length} Lehrer(n)',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Create new lesson
      // Determine the next available order for the selected time slot
      final nextAvailableOrder = widget.timetableManager
          .getNextAvailableOrderForSlot(_selectedSlot!.id!);

      final newLesson = ScheduledLesson(
        active: true,
        publicId: 'LESSON_${now.millisecondsSinceEpoch}',
        subjectId: _selectedSubject!.id!,
        subject: _selectedSubject,
        scheduledAtId: _selectedSlot!.id!,
        scheduledAt: _selectedSlot,
        timetableId: 1, // TODO: Get from TimetableManager.timetable.id
        lessonId: _lessonIdController.text.trim(),
        roomId: _selectedClassroom!.id!,
        room: _selectedClassroom,
        lessonGroupId: _selectedLessonGroup!.id!,
        lessonGroup: _selectedLessonGroup,
        timetableSlotOrder:
            nextAvailableOrder, // Set order as next available position
        mainTeacherId:
            _selectedTeachers
                .first
                .id!, // Use first selected teacher as main teacher
        createdBy: 'user', // TODO: Get actual user
        createdAt: now,
        modifiedBy: 'user',
        modifiedAt: now,
      );

      widget.timetableManager.addScheduledLesson(newLesson);

      // TODO: Create ScheduledLessonTeacher entries for all selected teachers
      // When TimetableManager supports teacher relationships, implement:
      // for (final teacher in _selectedTeachers) {
      //   await TimetableManager.addTeacherToLesson(newLesson.id!, teacher.id!);
      // }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Stunde erfolgreich erstellt mit ${_selectedTeachers.length} Lehrer(n)',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }

    Navigator.of(context).pop();
  }

  void _deleteLesson() {
    if (_editingLesson?.id == null) return;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Stunde löschen'),
            content: const Text(
              'Sind Sie sicher, dass Sie diese Stunde löschen möchten?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Abbrechen'),
              ),
              TextButton(
                onPressed: () {
                  widget.timetableManager.removeScheduledLesson(
                    _editingLesson!.id!,
                  );
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Close page

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Stunde erfolgreich gelöscht'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                child: const Text('Löschen'),
              ),
            ],
          ),
    );
  }

  int _getScheduledLessonsCountForUser(int userId) {
    // Count how many lessons this user is assigned to as main teacher
    return widget.timetableManager.scheduledLessons.value
        .where((lesson) => lesson.mainTeacherId == userId)
        .length;
  }

  bool _isUserAvailableAsTeacher(User user) {
    // Check if user is a teacher
    if (user.role != Role.teacher) return false;

    // Check if user has available time units (timeUnits - scheduled lessons > 1)
    if (user.id == null) return false;

    final scheduledLessonsCount = _getScheduledLessonsCountForUser(user.id!);
    final availableUnits =
        user.timeUnits - user.reliefTimeUnits - scheduledLessonsCount;

    return availableUnits > 1;
  }

  bool _hasClassroomConflict(Classroom classroom) {
    // If no time slot is selected, we can't check for conflicts
    if (_selectedSlot == null || classroom.id == null) return false;

    // If we're editing a lesson, exclude the current lesson from conflict check
    final currentLessonId = _isEditing ? _editingLesson?.id : null;

    // Get all lessons for the selected time slot
    final lessonsInSlot = widget.timetableManager.getAllLessonsForSlot(
      _selectedSlot!.id!,
    );

    // Check if any lesson in this slot uses the same classroom
    return lessonsInSlot.any(
      (lesson) =>
          lesson.roomId == classroom.id &&
          lesson.id != currentLessonId, // Exclude current lesson when editing
    );
  }

  bool _hasLessonGroupConflict(LessonGroup lessonGroup) {
    // If no time slot is selected, we can't check for conflicts
    if (_selectedSlot == null || lessonGroup.id == null) return false;

    // If we're editing a lesson, exclude the current lesson from conflict check
    final currentLessonId = _isEditing ? _editingLesson?.id : null;

    // Get all lessons for the selected time slot
    final lessonsInSlot = widget.timetableManager.getAllLessonsForSlot(
      _selectedSlot!.id!,
    );

    // Check if any lesson in this slot uses the same lesson group
    return lessonsInSlot.any(
      (lesson) =>
          lesson.lessonGroupId == lessonGroup.id &&
          lesson.id != currentLessonId, // Exclude current lesson when editing
    );
  }

  Color? _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return Colors.grey;

    try {
      String hexColor = colorString;
      if (!hexColor.startsWith('#')) {
        hexColor = '#$hexColor';
      }

      if (hexColor.length == 7) {
        return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
      }
    } catch (e) {
      // Return grey if color parsing fails
    }
    return Colors.grey;
  }

  String _getWeekdayName(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return 'Mo';
      case Weekday.tuesday:
        return 'Di';
      case Weekday.wednesday:
        return 'Mi';
      case Weekday.thursday:
        return 'Do';
      case Weekday.friday:
        return 'Fr';
    }
  }

  @override
  void dispose() {
    _lessonIdController.dispose();
    super.dispose();
  }
}
