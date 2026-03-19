/// New Learning Support Plan Module
///
/// This module provides functionality to create new learning support plans for pupils.
///
/// Usage:
/// ```dart
/// import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/new_learning_support_plan.dart';
///
/// // Navigate to create a new learning support plan
/// Navigator.of(context, rootNavigator: true).push(
///   MaterialPageRoute(
///     builder: (context) => NewLearningSupportPlan(pupil: pupil),
///   ),
/// );
/// ```
library;

export 'controller/new_learning_support_plan_controller.dart';
export 'new_learning_support_plan.dart';
export 'new_learning_support_plan_screen.dart';
