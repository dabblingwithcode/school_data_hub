import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/room_drag_snap_validator.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_screen/new_scheduled_lesson_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_screen/widgets/lesson_cell/lesson_cell.dart';

/// Main widget that renders a scrollable room × time grid for the
/// currently selected weekday, with experimental drag & drop behaviour.
class TimetableGridWidget extends WatchingStatefulWidget {
  const TimetableGridWidget({super.key});

  @override
  State<TimetableGridWidget> createState() => _RoomTimetableGridWidgetState();
}

class _RoomTimetableGridWidgetState extends State<TimetableGridWidget> {
  static const double _roomWidth = 160;
  static const double _timeColumnWidth = 64;
  static const double _roomHeaderHeight = 48;
  static const double _minSlotHeight = 12;
  static const double _maxSlotHeight = 20;

  double _slotHeight = 12;
  double _slotHeightAtScaleStart = 12;

  // Separate controllers for header/time vs grid, kept in sync.
  final ScrollController _headerHorizontal = ScrollController();
  final ScrollController _gridHorizontal = ScrollController();
  final ScrollController _timeVertical = ScrollController();
  final ScrollController _gridVertical = ScrollController();

  static const Duration _longPressDuration = Duration(milliseconds: 300);

  // Drag overlay state
  OverlayEntry? _dragOverlay;
  Offset? _dragGlobalPosition;

  /// Offset from finger (in grid local coords) to the dragged card's top-left.
  /// Keeps the card under the finger instead of jumping to snap cell center.
  Offset? _dragFingerToCardOffset;
  ScheduledLesson? _draggingLesson;
  TimetableSlot? _dragSlot;
  Timer? _snapTimer;
  int _dragDurationSlots = 1;
  int _dragRoomsCount = 1;

  /// When non-null, the requested snap cell is invalid (group/teacher conflict).
  /// Orange overlay is drawn at this cell; card snaps to suggested position.
  int? _conflictRoomIndex;
  int? _conflictStartSlotIndex;
  String? _conflictMessage;

  /// Start slot index of the current snap cell (for badge on dragged card).
  int? _dragSnapStartSlotIndex;

  /// Room index of the current snap cell (so overlay can draw at snapped position).
  int? _snapRoomIndex;

  final GlobalKey _gridKey = GlobalKey();
  static const _snapDelayMs = 0;

  // Convenience: 07:00–18:00 in 15-minute steps (can be adjusted later).
  static const int _dayStartMinutes = (7 * 60) + 50;
  static const int _dayEndMinutes = (16 * 60) + 5;
  static const int _slotMinutes = 5;

  int get _slotsPerDay =>
      ((_dayEndMinutes - _dayStartMinutes) / _slotMinutes).round();

  @override
  void initState() {
    super.initState();

    // Keep header in sync with grid horizontal scroll.
    _gridHorizontal.addListener(() {
      if (_headerHorizontal.hasClients &&
          _headerHorizontal.offset != _gridHorizontal.offset) {
        _headerHorizontal.jumpTo(_gridHorizontal.offset);
      }
    });

    // Keep time column in sync with grid vertical scroll.
    _gridVertical.addListener(() {
      if (_timeVertical.hasClients &&
          _timeVertical.offset != _gridVertical.offset) {
        _timeVertical.jumpTo(_gridVertical.offset);
      }
    });
  }

  @override
  void dispose() {
    _snapTimer?.cancel();
    _snapTimer = null;
    _headerHorizontal.dispose();
    _gridHorizontal.dispose();
    _timeVertical.dispose();
    _gridVertical.dispose();
    _dragOverlay?.remove();
    super.dispose();
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;

    final pressed = HardwareKeyboard.instance.logicalKeysPressed;
    final ctrlPressed =
        pressed.contains(LogicalKeyboardKey.controlLeft) ||
        pressed.contains(LogicalKeyboardKey.controlRight) ||
        pressed.contains(LogicalKeyboardKey.metaLeft) ||
        pressed.contains(LogicalKeyboardKey.metaRight);

    if (!ctrlPressed) return;

    // Scroll up (negative dy) -> zoom in, down -> zoom out.
    final delta = event.scrollDelta.dy;
    if (delta == 0) return;

    const zoomStep = 0.1;
    final factor = delta < 0 ? 1 + zoomStep : 1 - zoomStep;

    setState(() {
      _slotHeight = (_slotHeight * factor).clamp(
        _minSlotHeight,
        _maxSlotHeight,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();
    final selectedWeekday = watchValue(
      (TimetableManager m) => m.ui.selectedWeekday,
    );
    final classrooms = watchValue((TimetableManager m) => m.data.classrooms);
    final timetable = watchValue((TimetableManager m) => m.data.timetable);

    final dayLessons = timetableManager.getScheduledLessonsForWeekday(
      selectedWeekday,
    );

    if (classrooms.isEmpty || timetable == null) {
      return const Center(
        child: Text('Keine Räume oder Stundenpläne verfügbar'),
      );
    }

    final roomsCount = classrooms.length;
    final width = roomsCount * _roomWidth;
    final height = _slotsPerDay * _slotHeight;

    return Column(
      children: [
        _buildRoomHeaders(classrooms),
        Expanded(
          child: Row(
            children: [
              _buildTimeColumn(),
              Expanded(
                child: Listener(
                  onPointerSignal: _handlePointerSignal,
                  child: GestureDetector(
                    onScaleStart: (details) {
                      _slotHeightAtScaleStart = _slotHeight;
                    },
                    onScaleUpdate: (details) {
                      if (details.scale != 1.0) {
                        setState(() {
                          _slotHeight =
                              (_slotHeightAtScaleStart * details.scale).clamp(
                                _minSlotHeight,
                                _maxSlotHeight,
                              );
                        });
                      }
                    },
                    onLongPressStart: (details) =>
                        _handleLongPressCreate(details, selectedWeekday),
                    child: SingleChildScrollView(
                      controller: _gridHorizontal,
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        controller: _gridVertical,
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          key: _gridKey,
                          width: width,
                          height: height,
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size(width, height),
                                painter: _GridPainter(
                                  rooms: roomsCount,
                                  slots: _slotsPerDay,
                                  roomWidth: _roomWidth,
                                  slotHeight: _slotHeight,
                                  dayStartMinutes: _dayStartMinutes,
                                  slotMinutes: _slotMinutes,
                                ),
                              ),
                              // Booking layer
                              ...dayLessons.map(
                                (lesson) => _buildLessonPositioned(
                                  lesson: lesson,
                                  classrooms: classrooms,
                                ),
                              ),
                              // Conflict overlay: invalid snap cell (group/teacher in 2 places)
                              if (_conflictRoomIndex != null &&
                                  _conflictStartSlotIndex != null &&
                                  _conflictMessage != null)
                                Positioned(
                                  left: _conflictRoomIndex! * _roomWidth,
                                  top: _conflictStartSlotIndex! * _slotHeight,
                                  width: _roomWidth,
                                  height: _dragDurationSlots * _slotHeight,
                                  child: Material(
                                    elevation: 4,
                                    color: Colors.orange.withValues(
                                      alpha: 0.85,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.warning_rounded,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Sticky room headers sharing the horizontal scroll controller.
  Widget _buildRoomHeaders(List<Classroom> classrooms) {
    return SizedBox(
      height: _roomHeaderHeight,
      child: Row(
        children: [
          const SizedBox(width: _timeColumnWidth),
          Expanded(
            child: SingleChildScrollView(
              controller: _headerHorizontal,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: classrooms.map((room) {
                  return Container(
                    width: _roomWidth,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${room.roomCode} ${room.roomName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sticky time column sharing the vertical scroll controller.
  Widget _buildTimeColumn() {
    return Listener(
      onPointerSignal: _handlePointerSignal,
      child: GestureDetector(
        onScaleStart: (_) {
          _slotHeightAtScaleStart = _slotHeight;
        },
        onScaleUpdate: (details) {
          if (details.scale != 1.0) {
            setState(() {
              _slotHeight = (_slotHeightAtScaleStart * details.scale).clamp(
                _minSlotHeight,
                _maxSlotHeight,
              );
            });
          }
        },
        child: SizedBox(
          width: _timeColumnWidth,
          child: SingleChildScrollView(
            controller: _timeVertical,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: List.generate(_slotsPerDay, (index) {
                final minutes = _dayStartMinutes + index * _slotMinutes;
                final minuteOfHour = minutes % 60;
                final showLabel = minuteOfHour % 15 == 0;
                final hour = minutes ~/ 60;
                final label =
                    '${hour.toString().padLeft(2, '0')}:'
                    '${minuteOfHour.toString().padLeft(2, '0')}';
                return Container(
                  height: _slotHeight,
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(right: 4),
                  child: showLabel
                      ? Text(label, style: const TextStyle(fontSize: 11))
                      : const SizedBox.shrink(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  /// Build a positioned card for a lesson based on its room and timetable slot.
  Widget _buildLessonPositioned({
    required ScheduledLesson lesson,
    required List<Classroom> classrooms,
  }) {
    final timetableManager = di<TimetableManager>();
    final slots = timetableManager.data.timetableSlots.value;
    final slot = slots.firstWhere(
      (s) => s.id == lesson.scheduledAtId,
      orElse: () => slots.first,
    );

    final roomIndex = classrooms.indexWhere((r) => r.id == lesson.roomId);
    if (roomIndex < 0) {
      return const SizedBox.shrink();
    }
    final startIndex = _timeToIndex(slot.startTime);
    final endIndex = _timeToIndex(slot.endTime);
    final durationSlots = (endIndex - startIndex).clamp(1, _slotsPerDay);

    final left = roomIndex * _roomWidth;
    final top = startIndex * _slotHeight;

    final isDragging = lesson.id == _draggingLesson?.id;

    return Positioned(
      left: left,
      top: top,
      width: _roomWidth,
      height: durationSlots * _slotHeight,
      child: ClipRect(
        child: RawGestureDetector(
          gestures: {
            LongPressGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                  LongPressGestureRecognizer
                >(
                  () =>
                      LongPressGestureRecognizer(duration: _longPressDuration),
                  (recognizer) {
                    recognizer.onLongPressStart = (details) => _startDrag(
                      lesson,
                      slot,
                      durationSlots,
                      classrooms.length,
                      details,
                    );
                    recognizer.onLongPressMoveUpdate = _updateDrag;
                    recognizer.onLongPressEnd = (LongPressEndDetails details) {
                      _endDrag(details, classrooms.length, durationSlots);
                    };
                  },
                ),
          },
          child: isDragging
              ? AnimatedScale(
                  scale: 0.92,
                  duration: const Duration(milliseconds: 200),
                  child: Opacity(
                    opacity: 0.4,
                    child: LessonCell(
                      lesson: lesson,
                      slot: slot,
                      enableReorder: false,
                      onTap: () {},
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => _editLesson(lesson),
                  child: LessonCell(
                    lesson: lesson,
                    slot: slot,
                    enableReorder: false,
                    onTap: () => _editLesson(lesson),
                  ),
                ),
        ),
      ),
    );
  }

  /// Long-press in empty grid area creates a new ScheduledLesson at that cell.
  Future<void> _handleLongPressCreate(
    LongPressStartDetails details,
    Weekday weekday,
  ) async {
    final timetableManager = di<TimetableManager>();
    final timetable = timetableManager.data.timetable.value;
    final classrooms = timetableManager.data.classrooms.value;
    if (timetable == null || classrooms.isEmpty) return;

    final localDx = details.localPosition.dx + _gridHorizontal.offset;
    final localDy = details.localPosition.dy + _gridVertical.offset;

    final roomIndex = (localDx / _roomWidth).floor().clamp(
      0,
      classrooms.length - 1,
    );
    final slotIndex = (localDy / _slotHeight).floor().clamp(
      0,
      _slotsPerDay - 1,
    );
    final startTime = _indexToTime(slotIndex);
    final classroom = classrooms[roomIndex];

    // Open the standard lesson editor with the preselected start time.
    // The user will choose duration, classroom, group, etc. before
    // a ScheduledLesson is created server-side.
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NewScheduledLessonScreen(
          timetableManager: timetableManager,
          initialWeekday: weekday,
          initialStartTime: startTime,
          initialClassroom: classroom,
        ),
      ),
    );
  }

  // --- Drag & overlay -------------------------------------------------

  void _editLesson(ScheduledLesson lesson) {
    final timetableManager = di<TimetableManager>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NewScheduledLessonScreen(
          timetableManager: timetableManager,
          editingLessonId: lesson.id,
        ),
      ),
    );
  }

  void _startDrag(
    ScheduledLesson lesson,
    TimetableSlot slot,
    int durationSlots,
    int roomsCount,
    LongPressStartDetails details,
  ) {
    HapticFeedback.mediumImpact();
    _snapTimer?.cancel();
    _snapTimer = null;
    _conflictRoomIndex = null;
    _conflictStartSlotIndex = null;
    _conflictMessage = null;
    _dragSnapStartSlotIndex = null;
    _snapRoomIndex = null;
    _draggingLesson = lesson;
    _dragSlot = slot;
    _dragDurationSlots = durationSlots;
    _dragRoomsCount = roomsCount;
    _dragGlobalPosition = details.globalPosition;

    // Keep card under finger: offset from finger (grid local) to card top-left.
    if (_gridKey.currentContext != null) {
      final box = _gridKey.currentContext!.findRenderObject() as RenderBox;
      final local = box.globalToLocal(details.globalPosition);
      final timetableManager = di<TimetableManager>();
      final classrooms = timetableManager.data.classrooms.value;
      final roomIndex = classrooms.indexWhere((r) => r.id == lesson.roomId);
      final startIndex = _timeToIndex(slot.startTime);
      if (roomIndex >= 0) {
        final left = roomIndex * _roomWidth;
        final top = startIndex * _slotHeight;
        _dragFingerToCardOffset = Offset(left - local.dx, top - local.dy);
      } else {
        _dragFingerToCardOffset = Offset.zero;
      }
    } else {
      _dragFingerToCardOffset = Offset.zero;
    }

    // Compute initial snap (for validation and badge).
    _applySnapWithValidation();

    _dragOverlay = OverlayEntry(
      builder: (context) {
        if (_dragSlot == null || _dragGlobalPosition == null) {
          return const SizedBox.shrink();
        }
        final gridContext = _gridKey.currentContext;
        if (gridContext == null) {
          return const SizedBox.shrink();
        }
        final box = gridContext.findRenderObject() as RenderBox?;
        if (box == null) {
          return const SizedBox.shrink();
        }
        // Position overlay at snapped cell so the card visually snaps to the grid.
        Offset overlayTopLeftGlobal;
        if (_snapRoomIndex != null && _dragSnapStartSlotIndex != null) {
          overlayTopLeftGlobal = box.localToGlobal(
            Offset(
              _snapRoomIndex! * _roomWidth,
              _dragSnapStartSlotIndex! * _slotHeight,
            ),
          );
        } else {
          // Fallback: under finger (e.g. before first _applySnapWithValidation).
          final offset = _dragFingerToCardOffset ?? Offset.zero;
          final local = box.globalToLocal(_dragGlobalPosition!);
          overlayTopLeftGlobal = box.localToGlobal(local + offset);
        }

        final hasConflict = _conflictMessage != null;
        final snapStartTime = _dragSnapStartSlotIndex != null
            ? _indexToTime(_dragSnapStartSlotIndex!)
            : null;
        final snapEndTime = _dragSnapStartSlotIndex != null
            ? _indexToTime(_dragSnapStartSlotIndex! + _dragDurationSlots)
            : null;

        return Positioned(
          left: overlayTopLeftGlobal.dx,
          top: overlayTopLeftGlobal.dy,
          child: Material(
            type: MaterialType.transparency,
            elevation: 12,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: _roomWidth,
                  height: _dragDurationSlots * _slotHeight,
                  decoration: hasConflict
                      ? BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 3),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LessonCell(
                      lesson: lesson,
                      slot: _dragSlot!,
                      enableReorder: false,
                      onTap: () {},
                    ),
                  ),
                ),
                // Start time badge (top-right)
                if (snapStartTime != null)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: _timeBadge(context, snapStartTime),
                  ),
                // End time badge (bottom-right)
                if (snapEndTime != null)
                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: _timeBadge(context, snapEndTime),
                  ),
                // Conflict message badge (above the card)
                if (hasConflict)
                  Positioned(
                    bottom: _dragDurationSlots * _slotHeight + 4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.orange,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            _conflictMessage!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_dragOverlay!);
  }

  void _updateDrag(LongPressMoveUpdateDetails details) {
    if (_dragOverlay == null) return;
    _dragGlobalPosition = details.globalPosition;
    _snapTimer?.cancel();
    _snapTimer = Timer(const Duration(milliseconds: _snapDelayMs), _applySnap);
    _autoScrollWhileDragging(details.globalPosition);
    _dragOverlay!.markNeedsBuild();
  }

  void _applySnap() {
    if (_dragOverlay == null || _dragGlobalPosition == null || !mounted) {
      return;
    }
    _applySnapWithValidation();
    _dragOverlay!.markNeedsBuild();
  }

  void _applySnapWithValidation() {
    if (_gridKey.currentContext == null ||
        _dragGlobalPosition == null ||
        _draggingLesson == null) {
      return;
    }
    final box = _gridKey.currentContext!.findRenderObject() as RenderBox;
    final local = box.globalToLocal(_dragGlobalPosition!);
    // Snap target = cell under the card's top-left (LessonCell top); fallback to finger.
    final cardTopLeft = local + (_dragFingerToCardOffset ?? Offset.zero);
    final x = cardTopLeft.dx;
    final y = cardTopLeft.dy;
    final roomIndex = (x / _roomWidth).floor().clamp(0, _dragRoomsCount - 1);
    final startSlotIndex = (y / _slotHeight).floor().clamp(
      0,
      _slotsPerDay - _dragDurationSlots,
    );

    final timetableManager = di<TimetableManager>();
    final classrooms = timetableManager.data.classrooms.value;
    final weekday = timetableManager.ui.selectedWeekday.value;
    if (classrooms.isEmpty) return;

    final targetRoomId = classrooms[roomIndex].id!;
    final allLessons = timetableManager.getAllScheduledLessonsForWeekday(
      weekday,
    );
    final slotIdMap = timetableManager.data.slotIdMap;

    final validator = RoomDragSnapValidator(
      dayStartMinutes: _dayStartMinutes,
      dayEndMinutes: _dayEndMinutes,
      slotMinutes: _slotMinutes,
    );
    final result = validator.validate(
      draggedLesson: _draggingLesson!,
      targetRoomId: targetRoomId,
      startSlotIndex: startSlotIndex,
      durationSlots: _dragDurationSlots,
      weekday: weekday,
      weekdayLessons: allLessons,
      slotIdMap: slotIdMap,
    );

    final useStartSlotIndex = result.suggestedStartSlotIndex;
    _dragSnapStartSlotIndex = useStartSlotIndex;
    _snapRoomIndex = roomIndex;

    if (result is RoomDragSnapConflict) {
      _conflictRoomIndex = roomIndex;
      _conflictStartSlotIndex = startSlotIndex;
      _conflictMessage =
          '${result.conflictEntityLabel} kann nicht gleichzeitig in 2 Orten sein';
    } else if (result is RoomDragSnapRoomOccupied) {
      _conflictRoomIndex = roomIndex;
      _conflictStartSlotIndex = startSlotIndex;
      _conflictMessage = 'Zeitslot in diesem Raum ist belegt';
    } else {
      _conflictRoomIndex = null;
      _conflictStartSlotIndex = null;
      _conflictMessage = null;
    }
    setState(() {});
  }

  Future<void> _endDrag(
    LongPressEndDetails details,
    int roomsCount,
    int durationSlots,
  ) async {
    _snapTimer?.cancel();
    _snapTimer = null;
    _conflictRoomIndex = null;
    _conflictStartSlotIndex = null;
    _conflictMessage = null;

    final timetableManager = di<TimetableManager>();
    final timetable = timetableManager.data.timetable.value;
    final classrooms = timetableManager.data.classrooms.value;
    if (timetable == null ||
        classrooms.isEmpty ||
        _gridKey.currentContext == null ||
        _draggingLesson == null) {
      _dragFingerToCardOffset = null;
      _dragSnapStartSlotIndex = null;
      _snapRoomIndex = null;
      _removeOverlayAndClearDrag();
      return;
    }

    final box = _gridKey.currentContext!.findRenderObject() as RenderBox;
    final local = box.globalToLocal(
      _dragGlobalPosition ?? details.globalPosition,
    );
    // Drop target = cell under the card's top (LessonCell top), not the finger.
    final cardTopLeft = local + (_dragFingerToCardOffset ?? Offset.zero);
    _dragFingerToCardOffset = null;

    final x = cardTopLeft.dx;
    final y = cardTopLeft.dy;

    final roomIndex = (x / _roomWidth).floor().clamp(0, roomsCount - 1);
    final requestedStartSlotIndex = (y / _slotHeight).floor().clamp(
      0,
      _slotsPerDay - durationSlots,
    );

    final weekday = timetableManager.ui.selectedWeekday.value;
    final allLessons = timetableManager.getAllScheduledLessonsForWeekday(
      weekday,
    );
    final slotIdMap = timetableManager.data.slotIdMap;
    final targetRoomId = classrooms[roomIndex].id!;

    final validator = RoomDragSnapValidator(
      dayStartMinutes: _dayStartMinutes,
      dayEndMinutes: _dayEndMinutes,
      slotMinutes: _slotMinutes,
    );
    final result = validator.validate(
      draggedLesson: _draggingLesson!,
      targetRoomId: targetRoomId,
      startSlotIndex: requestedStartSlotIndex,
      durationSlots: durationSlots,
      weekday: weekday,
      weekdayLessons: allLessons,
      slotIdMap: slotIdMap,
    );

    final startSlotIndex = result.suggestedStartSlotIndex;
    final startTime = _indexToTime(startSlotIndex);
    final durationMinutes = durationSlots * _slotMinutes;

    final newSlot = await timetableManager.findOrCreateSlotFor(
      weekday,
      startTime,
      durationMinutes,
    );
    final newClassroom = classrooms[roomIndex];

    final lesson = _draggingLesson!;

    // If nothing actually changed, skip the update but still clear drag state and rebuild.
    if (lesson.roomId == newClassroom.id &&
        lesson.scheduledAtId == newSlot.id) {
      _removeOverlayAndClearDrag();
      return;
    }

    final updatedLesson = lesson.copyWith(
      roomId: newClassroom.id!,
      room: newClassroom,
      scheduledAtId: newSlot.id!,
      scheduledAt: newSlot,
    );

    await timetableManager.updateScheduledLesson(updatedLesson);
    _removeOverlayAndClearDrag();
  }

  void _removeOverlayAndClearDrag() {
    _dragOverlay?.remove();
    _dragOverlay = null;
    _draggingLesson = null;
    _dragSnapStartSlotIndex = null;
    _snapRoomIndex = null;
    if (mounted) setState(() {});
  }

  void _autoScrollWhileDragging(Offset globalPosition) {
    if (_gridKey.currentContext == null) return;
    final box = _gridKey.currentContext!.findRenderObject() as RenderBox;
    final local = box.globalToLocal(globalPosition);
    final viewportWidth = _gridHorizontal.hasClients
        ? _gridHorizontal.position.viewportDimension
        : 0.0;
    final viewportHeight = _gridVertical.hasClients
        ? _gridVertical.position.viewportDimension
        : 0.0;
    final visibleX = local.dx - _gridHorizontal.offset;
    final visibleY = local.dy - _gridVertical.offset;

    const edgeMargin = 40.0;
    const scrollStep = 20.0;

    double dx = 0;
    double dy = 0;

    if (visibleX < edgeMargin) {
      dx = -scrollStep;
    } else if (viewportWidth > 0 && visibleX > viewportWidth - edgeMargin) {
      dx = scrollStep;
    }

    if (visibleY < edgeMargin) {
      dy = -scrollStep;
    } else if (viewportHeight > 0 && visibleY > viewportHeight - edgeMargin) {
      dy = scrollStep;
    }

    if (dx != 0 &&
        _gridHorizontal.hasClients &&
        _gridHorizontal.position.maxScrollExtent > 0) {
      final target = (_gridHorizontal.offset + dx).clamp(
        0.0,
        _gridHorizontal.position.maxScrollExtent,
      );
      _gridHorizontal.jumpTo(target);
    }

    if (dy != 0 &&
        _gridVertical.hasClients &&
        _gridVertical.position.maxScrollExtent > 0) {
      final target = (_gridVertical.offset + dy).clamp(
        0.0,
        _gridVertical.position.maxScrollExtent,
      );
      _gridVertical.jumpTo(target);
    }
  }

  Widget _timeBadge(BuildContext context, String time) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(6),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  int _timeToIndex(String hhmm) {
    // Expect "HH:MM"
    final parts = hhmm.split(':');
    if (parts.length != 2) return 0;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    final totalMinutes = hour * 60 + minute;
    return ((totalMinutes - _dayStartMinutes) / _slotMinutes).floor().clamp(
      0,
      _slotsPerDay - 1,
    );
  }

  String _indexToTime(int index) {
    final minutes = _dayStartMinutes + index * _slotMinutes;
    final hour = minutes ~/ 60;
    final minute = minutes % 60;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

class _GridPainter extends CustomPainter {
  final int rooms;
  final int slots;
  final double roomWidth;
  final double slotHeight;
  final int dayStartMinutes;
  final int slotMinutes;

  _GridPainter({
    required this.rooms,
    required this.slots,
    required this.roomWidth,
    required this.slotHeight,
    required this.dayStartMinutes,
    required this.slotMinutes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final verticalPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    for (var r = 0; r <= rooms; r++) {
      final x = r * roomWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), verticalPaint);
    }

    final majorLinePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    final minorLinePaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    for (var s = 0; s <= slots; s++) {
      final y = s * slotHeight;
      final minutes = dayStartMinutes + s * slotMinutes;
      final minuteOfHour = minutes % 60;
      final isFifteenMinuteStep = minuteOfHour % 15 == 0;
      final paint = isFifteenMinuteStep ? majorLinePaint : minorLinePaint;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
