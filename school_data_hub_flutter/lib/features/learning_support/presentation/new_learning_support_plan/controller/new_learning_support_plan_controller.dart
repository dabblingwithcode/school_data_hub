import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/new_learning_support_plan_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';

/// StatefulWidget for creating or editing a learning support plan for a pupil.
///
/// This widget provides a form interface for:
/// - Selecting the support level (1-3)
/// - Entering a plan ID/name
/// - Adding optional comments, strengths, problems, professionals, etc.
/// - Creating or updating the plan for the current semester
///
/// When [existingPlan] is provided, the widget operates in edit mode:
/// encrypted fields are decrypted once and pre-populated into the form.
class NewLearningSupportPlan extends StatefulWidget {
  final PupilProxy pupil;
  final LearningSupportPlan? existingPlan;

  const NewLearningSupportPlan({
    super.key,
    required this.pupil,
    this.existingPlan,
  });

  @override
  NewLearningSupportPlanController createState() =>
      NewLearningSupportPlanController();
}

class NewLearningSupportPlanController extends State<NewLearningSupportPlan> {
  late final TextEditingController planIdController;
  late final TextEditingController numberController;
  late final TextEditingController commentController;
  late final TextEditingController socialPedagogueController;
  late final TextEditingController specialNeedsTeacherController;
  late final TextEditingController proffesionalsInvolvedController;
  late final TextEditingController strengthsDescriptionController;
  late final TextEditingController problemsDescriptionController;

  late final int fixedSupportLevel;
  final ValueNotifier<bool> isValidNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String> semesterInfoNotifier = ValueNotifier<String>(
    'Lädt...',
  );

  PupilProxy get pupil => widget.pupil;
  bool get isEditing => widget.existingPlan != null;

  LearningSupportManager get _learningSupportPlanManager =>
      di<LearningSupportManager>();
  SchoolCalendarManager get _schoolCalendarManager =>
      di<SchoolCalendarManager>();

  NotificationService get _notificationService => di<NotificationService>();
  UserManager get _userManager => di<UserManager>();

  @override
  void initState() {
    super.initState();

    final existingPlan = widget.existingPlan;

    if (existingPlan != null) {
      // Edit mode: decrypt encrypted fields once and pre-populate controllers
      final decryptedComment = existingPlan.comment != null
          ? customEncrypter.decryptString(existingPlan.comment!)
          : '';
      final decryptedStrengths = existingPlan.strengthsDescription != null
          ? customEncrypter.decryptString(existingPlan.strengthsDescription!)
          : '';
      final decryptedProblems = existingPlan.problemsDescription != null
          ? customEncrypter.decryptString(existingPlan.problemsDescription!)
          : '';

      planIdController = TextEditingController(text: existingPlan.planId);
      numberController = TextEditingController(
        text: existingPlan.number.toString(),
      );
      commentController = TextEditingController(text: decryptedComment);
      socialPedagogueController = TextEditingController(
        text: existingPlan.socialPedagogue ?? '',
      );
      specialNeedsTeacherController = TextEditingController(
        text: existingPlan.specialNeedsTeacher ?? '',
      );
      proffesionalsInvolvedController = TextEditingController(
        text: existingPlan.proffesionalsInvolved ?? '',
      );
      strengthsDescriptionController = TextEditingController(
        text: decryptedStrengths,
      );
      problemsDescriptionController = TextEditingController(
        text: decryptedProblems,
      );

      fixedSupportLevel = existingPlan.learningSupportLevelId;
    } else {
      // Create mode
      planIdController = TextEditingController();
      numberController = TextEditingController();
      specialNeedsTeacherController = TextEditingController();
      commentController = TextEditingController();
      socialPedagogueController = TextEditingController();
      proffesionalsInvolvedController = TextEditingController();
      strengthsDescriptionController = TextEditingController();
      problemsDescriptionController = TextEditingController();

      fixedSupportLevel = pupil.supportLevelHistory?.last.level ?? 1;

      final currentSemester = _schoolCalendarManager.currentSemester.value;
      if (currentSemester != null) {
        final semesterName =
            '${currentSemester.schoolYear}/${currentSemester.isFirst ? '1' : '2'}';
        planIdController.text =
            'Förderplan $semesterName - ${pupil.firstName} ${pupil.lastName}';
      }
    }

    planIdController.addListener(validateForm);
    validateForm();

    _updateSemesterInfo();
  }

  void validateForm() {
    final isValid = planIdController.text.trim().isNotEmpty;
    isValidNotifier.value = isValid;
  }

  void _updateSemesterInfo() {
    final currentSemester = _schoolCalendarManager.currentSemester.value;
    if (currentSemester != null) {
      final semesterName = currentSemester.isFirst
          ? '1. Halbjahr'
          : '2. Halbjahr';
      semesterInfoNotifier.value = isEditing
          ? 'Förderplan für $semesterName ${currentSemester.schoolYear}'
          : 'Der Förderplan wird für das $semesterName ${currentSemester.schoolYear} erstellt.';
    } else {
      semesterInfoNotifier.value =
          'Kein aktives Semester gefunden. Bitte wenden Sie sich an den Administrator.';
    }
  }

  String? get groupTutorDisplayName {
    final groupTutorUsername = pupil.groupTutor;
    if (groupTutorUsername != null && groupTutorUsername.isNotEmpty) {
      final users = _userManager.users.value;
      try {
        final user = users.firstWhere(
          (u) => u.userInfo?.userName == groupTutorUsername,
        );
        final fullName = user.userInfo?.fullName;
        return fullName ?? groupTutorUsername;
      } catch (e) {
        return groupTutorUsername;
      }
    }
    return null;
  }

  String? _trimOrNull(String text) {
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> savePlan() async {
    if (!isValidNotifier.value) return;

    if (isEditing) {
      await _updatePlan();
    } else {
      await _createPlan();
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _createPlan() async {
    final currentSemester = _schoolCalendarManager.currentSemester.value;
    if (currentSemester == null) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kein aktives Semester gefunden.',
      );
      return;
    }

    // await PupilMutator().updatePupilSupportLevel(
    //   pupilId: pupil.pupilId,
    //   level: fixedSupportLevel,
    //   createdAt: DateTime.now().toUtc(),
    //   createdBy: _hubSessionManager.userName!,
    //   comment: 'Förderstufe $fixedSupportLevel für Förderplan',
    // );

    await _learningSupportPlanManager.postNewLearningSupportPlan(
      pupilId: pupil.pupilId,

      supportLevelId: fixedSupportLevel,
      number: int.tryParse(numberController.text.trim()) ?? 1,
      specialNeedsTeacher: _trimOrNull(specialNeedsTeacherController.text),
      comment: _trimOrNull(commentController.text),
      socialPedagogue: _trimOrNull(socialPedagogueController.text),
      proffesionalsInvolved: _trimOrNull(proffesionalsInvolvedController.text),
      strengthsDescription: _trimOrNull(strengthsDescriptionController.text),
      problemsDescription: _trimOrNull(problemsDescriptionController.text),
    );
  }

  Future<void> _updatePlan() async {
    await _learningSupportPlanManager.updateLearningSupportPlan(
      plan: widget.existingPlan!,
      number: int.tryParse(numberController.text.trim()) ?? 1,
      specialNeedsTeacher: _trimOrNull(specialNeedsTeacherController.text),
      comment: _trimOrNull(commentController.text),
      socialPedagogue: _trimOrNull(socialPedagogueController.text),
      proffesionalsInvolved: _trimOrNull(proffesionalsInvolvedController.text),
      strengthsDescription: _trimOrNull(strengthsDescriptionController.text),
      problemsDescription: _trimOrNull(problemsDescriptionController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewLearningSupportPlanPage(this);
  }

  @override
  void dispose() {
    planIdController.dispose();
    commentController.dispose();
    socialPedagogueController.dispose();
    proffesionalsInvolvedController.dispose();
    strengthsDescriptionController.dispose();
    problemsDescriptionController.dispose();
    isValidNotifier.dispose();
    semesterInfoNotifier.dispose();
    super.dispose();
  }
}
