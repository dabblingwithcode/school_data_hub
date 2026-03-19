import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/widgets/competence_check_icon.dart';

Widget getCompetenceCheckSymbol({
  required PupilProxy pupil,
  required int competenceId,
  required String checkId,
}) {
  final competenceCheck = pupil.competenceChecks?.firstWhereOrNull(
    (element) =>
        element.competenceId == competenceId && element.checkId == checkId,
  );
  return CompetenceCheckIcon(score: competenceCheck?.score);
}

Widget getLastCompetenceCheckSymbol(PupilProxy pupil, int competenceId) {
  final competenceCheck = pupil.competenceChecks?.lastWhereOrNull(
    (element) => element.competenceId == competenceId,
  );
  return CompetenceCheckIcon(score: competenceCheck?.score);
}

Widget getCompetenceReportCheckSymbol(PupilProxy pupil, int competenceId) {
  final competenceCheck = pupil.competenceChecks?.lastWhereOrNull(
    (element) => element.competenceId == competenceId,
  );
  return CompetenceCheckIcon(score: competenceCheck?.score);
}
