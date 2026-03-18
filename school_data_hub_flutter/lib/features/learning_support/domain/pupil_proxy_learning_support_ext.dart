import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';

extension PupilProxyLearningSupport on PupilProxy {
  List<SupportGoal> get supportGoals =>
      di<LearningSupportManager>().getSupportGoals(pupilId);
}
