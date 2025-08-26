import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/new_learning_support_plan_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

final _learningSupportPlanManager = di<LearningSupportManager>();
final _schoolCalendarManager = di<SchoolCalendarManager>();
final _hubSessionManager = di<HubSessionManager>();
final _notificationService = di<NotificationService>();

final _pupilManager = di<PupilManager>();

/// StatefulWidget for creating a new learning support plan for a pupil.
///
/// This widget provides a form interface for:
/// - Selecting the support level (1-3)
/// - Entering a plan ID/name
/// - Adding optional comments
/// - Creating the plan for the current semester
///
/// The plan is created with the pupil's support level history and
/// linked to the current school semester.
class NewLearningSupportPlan extends StatefulWidget {
  final PupilProxy pupil;

  const NewLearningSupportPlan({super.key, required this.pupil});

  @override
  NewLearningSupportPlanController createState() =>
      NewLearningSupportPlanController();
}

class NewLearningSupportPlanController extends State<NewLearningSupportPlan> {
  late final TextEditingController planIdController;
  late final TextEditingController commentController;

  final ValueNotifier<int?> selectedSupportLevelNotifier = ValueNotifier<int?>(
    null,
  );
  final ValueNotifier<bool> isValidNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String> semesterInfoNotifier = ValueNotifier<String>(
    'Lädt...',
  );

  PupilProxy get pupil => widget.pupil;

  @override
  void initState() {
    super.initState();
    planIdController = TextEditingController();
    commentController = TextEditingController();

    // Generate default plan ID
    final currentSemester = _schoolCalendarManager.currentSemester.value;
    if (currentSemester != null) {
      final semesterName =
          '${currentSemester.schoolYear}/${currentSemester.isFirst ? '1' : '2'}';
      planIdController.text =
          'Förderplan $semesterName - ${pupil.firstName} ${pupil.lastName}';
    }

    planIdController.addListener(validateForm);
    selectedSupportLevelNotifier.addListener(validateForm);

    _updateSemesterInfo();
  }

  void validateForm() {
    final isValid =
        planIdController.text.trim().isNotEmpty &&
        selectedSupportLevelNotifier.value != null;
    isValidNotifier.value = isValid;
  }

  void _updateSemesterInfo() {
    final currentSemester = _schoolCalendarManager.currentSemester.value;
    if (currentSemester != null) {
      final semesterName =
          currentSemester.isFirst ? '1. Halbjahr' : '2. Halbjahr';
      semesterInfoNotifier.value =
          'Der Förderplan wird für das $semesterName ${currentSemester.schoolYear} erstellt.';
    } else {
      semesterInfoNotifier.value =
          'Kein aktives Semester gefunden. Bitte wenden Sie sich an den Administrator.';
    }
  }

  void setSupportLevel(int? level) {
    selectedSupportLevelNotifier.value = level;
  }

  Future<void> createPlan() async {
    if (!isValidNotifier.value) return;

    final currentSemester = _schoolCalendarManager.currentSemester.value;
    if (currentSemester == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kein aktives Semester gefunden.',
      );
      return;
    }

    // First create a support level entry for this pupil
    await _pupilManager.updatePupilSupportLevel(
      pupilId: pupil.pupilId,
      level: selectedSupportLevelNotifier.value!,
      createdAt: DateTime.now(),
      createdBy: _hubSessionManager.userName!,
      comment:
          'Förderstufe ${selectedSupportLevelNotifier.value} für Förderplan',
    );

    // Now create the learning support plan
    final plan = LearningSupportPlan(
      planId: planIdController.text.trim(),
      createdBy: _hubSessionManager.userName!,
      learningSupportLevelId: selectedSupportLevelNotifier.value!,
      createdAt: DateTime.now(),
      comment:
          commentController.text.trim().isEmpty
              ? null
              : commentController.text.trim(),
      pupilId: pupil.pupilId,
      schoolSemesterId: currentSemester.id!,
    );

    await _learningSupportPlanManager.postNewLearningSupportPlan(
      pupilId: pupil.pupilId,
      planId: planIdController.text.trim(),
      supportLevelId:
          pupil.supportLevelHistory!.isNotEmpty
              ? pupil.supportLevelHistory!.last.level
              : selectedSupportLevelNotifier.value!,
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NewLearningSupportPlanPage(this);
  }

  @override
  void dispose() {
    planIdController.dispose();
    commentController.dispose();
    selectedSupportLevelNotifier.dispose();
    isValidNotifier.dispose();
    semesterInfoNotifier.dispose();
    super.dispose();
  }
}
