import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan_screen/controller/new_learning_support_plan_controller.dart';

/// Entry point widget for creating or editing a learning support plan.
///
/// Pass [existingPlan] to open the form in edit mode with pre-populated
/// (and decrypted) field values.
class NewLearningSupportPlanEntry extends StatelessWidget {
  final PupilProxy pupil;
  final LearningSupportPlan? existingPlan;

  const NewLearningSupportPlanEntry({
    super.key,
    required this.pupil,
    this.existingPlan,
  });

  @override
  Widget build(BuildContext context) {
    return NewLearningSupportPlan(pupil: pupil, existingPlan: existingPlan);
  }
}
