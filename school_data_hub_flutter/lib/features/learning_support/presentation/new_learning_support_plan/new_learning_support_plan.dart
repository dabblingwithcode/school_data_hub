import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

/// Entry point widget for creating a new learning support plan
/// Usage:
/// ```dart
/// Navigator.of(context).push(
///   MaterialPageRoute(
///     builder: (context) => NewLearningSupportPlan(pupil: pupil),
///   ),
/// );
/// ```
class NewLearningSupportPlanEntry extends StatelessWidget {
  final PupilProxy pupil;

  const NewLearningSupportPlanEntry({super.key, required this.pupil});

  @override
  Widget build(BuildContext context) {
    return NewLearningSupportPlan(pupil: pupil);
  }
}
