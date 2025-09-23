import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/new_learning_support_plan_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

final _learningSupportPlanManager = di<LearningSupportManager>();
final _schoolCalendarManager = di<SchoolCalendarManager>();
final _hubSessionManager = di<HubSessionManager>();
final _notificationService = di<NotificationService>();
final _userManager = di<UserManager>();

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

  // Fixed support level - not selectable
  late final int fixedSupportLevel;
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

    // Initialize fixed support level from pupil's history
    fixedSupportLevel = pupil.supportLevelHistory?.last.level ?? 1;

    // Generate default plan ID
    final currentSemester = _schoolCalendarManager.currentSemester.value;
    if (currentSemester != null) {
      final semesterName =
          '${currentSemester.schoolYear}/${currentSemester.isFirst ? '1' : '2'}';
      planIdController.text =
          'Förderplan $semesterName - ${pupil.firstName} ${pupil.lastName}';
    }

    planIdController.addListener(validateForm);

    _updateSemesterInfo();
  }

  void validateForm() {
    final isValid = planIdController.text.trim().isNotEmpty;
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

  String? get groupTutorDisplayName {
    final groupTutorUsername = pupil.groupTutor;
    if (groupTutorUsername != null && groupTutorUsername.isNotEmpty) {
      // Find user by username in the UserManager's user list
      final users = _userManager.users.value;
      try {
        final user = users.firstWhere(
          (u) => u.userInfo?.userName == groupTutorUsername,
        );

        // Get the full name from userInfo
        final fullName = user.userInfo?.fullName;
        return fullName ?? groupTutorUsername;
      } catch (e) {
        // User not found, fall back to username
        return groupTutorUsername;
      }
    }
    return null;
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
    await PupilMutator().updatePupilSupportLevel(
      pupilId: pupil.pupilId,
      level: fixedSupportLevel,
      createdAt: DateTime.now().toUtc(),
      createdBy: _hubSessionManager.userName!,
      comment: 'Förderstufe $fixedSupportLevel für Förderplan',
    );

    // Create the learning support plan (plan object is created internally by the manager)

    await _learningSupportPlanManager.postNewLearningSupportPlan(
      pupilId: pupil.pupilId,
      planId: planIdController.text.trim(),
      supportLevelId: fixedSupportLevel,
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
    isValidNotifier.dispose();
    semesterInfoNotifier.dispose();
    super.dispose();
  }
}
