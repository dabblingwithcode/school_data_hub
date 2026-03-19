import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';

extension PupilProxyCompetence on PupilProxy {
  List<CompetenceGoal> get competenceGoals =>
      di<CompetenceManager>().getCompetenceGoals(pupilId);

  Map<int, int> get competenceBadgeCounts =>
      di<CompetenceManager>().computeBadgeCounts(competenceChecks ?? []);
}
