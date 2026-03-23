/// New Learning Support Plan Module
///
/// This module provides functionality to create new learning support plans for pupils.
///
/// Usage:
/// ```dart
/// import 'package:go_router/go_router.dart';
/// import 'package:school_data_hub_flutter/core/router/route_paths.dart';
///
/// // Navigate to create a new learning support plan
/// context.push(RoutePaths.learningSupportNewPlan, extra: {
///   'pupil': pupil,
///   'existingPlan': null,
/// });
/// ```
library;

export 'controller/new_learning_support_plan_controller.dart';
export 'new_learning_support_plan.dart';
export 'new_learning_support_plan_screen.dart';
