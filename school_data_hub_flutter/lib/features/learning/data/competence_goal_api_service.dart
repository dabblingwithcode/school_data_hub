import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/client_helper.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:watch_it/watch_it.dart';

class CompetenceGoalApiService {
  // Private constructor
  CompetenceGoalApiService._internal();
  // Singleton instance
  static final CompetenceGoalApiService _instance =
      CompetenceGoalApiService._internal();
  // Factory constructor to return the singleton instance
  factory CompetenceGoalApiService() {
    return _instance;
  }
  Client get _client => di<Client>();

  HubSessionManager get _hubSessionManager => di<HubSessionManager>();
  // - post a competence goal
  Future<PupilData?> postCompetenceGoal({
    required int pupilId,
    required int competenceId,
    required String description,
    required List<String> strategies,
  }) async {
    final response = ClientHelper.apiCall(
      call: () => _client.competenceGoal.postCompetenceGoal(
        competenceId: competenceId,
        pupilId: pupilId,
        description: description,
        strategies: strategies,
        createdBy: _hubSessionManager.userName!,
      ),
    );
    return response;
  }
}
