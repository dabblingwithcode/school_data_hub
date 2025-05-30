import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

Widget getCompetenceCheckSymbol(
    {required PupilProxy pupil,
    required int competenceId,
    required String checkId}) {
  if (pupil.supportCategoryStatuses!.isNotEmpty) {
    final CompetenceCheck competenceCheck = pupil.competenceChecks!.firstWhere(
        (element) =>
            element.competenceId == competenceId && element.checkId == checkId);

    switch (competenceCheck.score) {
      case 1:
        return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
      case 4:
        return SizedBox(width: 50, child: Image.asset('assets/growth_4-4.png'));
      case 3:
        return SizedBox(width: 50, child: Image.asset('assets/growth_3-4.png'));
      case 2:
        return SizedBox(width: 50, child: Image.asset('assets/growth_2-4.png'));
    }
    return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
  }

  return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
}

Widget getLastCompetenceCheckSymbol(PupilProxy pupil, int competenceId) {
  if (pupil.competenceChecks!.isNotEmpty) {
    final CompetenceCheck? competenceCheck = pupil.competenceChecks!
        .lastWhereOrNull((element) => element.competenceId == competenceId);

    switch (competenceCheck?.score) {
      case 1:
        return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
      case 4:
        return SizedBox(width: 50, child: Image.asset('assets/growth_4-4.png'));
      case 3:
        return SizedBox(width: 50, child: Image.asset('assets/growth_3-4.png'));
      case 2:
        return SizedBox(width: 50, child: Image.asset('assets/growth_2-4.png'));
    }
    return const SizedBox(width: 50, child: Icon(Icons.question_mark_rounded));
  }

  return const SizedBox(
      width: 50,
      child: Icon(Icons.question_mark_rounded, color: Colors.purple));
}

Widget getCompetenceReportCheckSymbol(PupilProxy pupil, int competenceId) {
  if (pupil.competenceChecks!.isNotEmpty) {
    final CompetenceCheck? competenceCheck = pupil.competenceChecks!
        .lastWhereOrNull((element) => element.competenceId == competenceId);

    switch (competenceCheck?.score) {
      case 1:
        return SizedBox(width: 50, child: Image.asset('assets/growth_1-4.png'));
      case 2:
        return SizedBox(width: 50, child: Image.asset('assets/growth_2-4.png'));

      case 3:
        return SizedBox(width: 50, child: Image.asset('assets/growth_3-4.png'));
      case 4:
        return SizedBox(width: 50, child: Image.asset('assets/growth_4-4.png'));
    }
    return const SizedBox(
        width: 50,
        child: Icon(Icons.question_mark_rounded, color: Colors.black));
  }

  return const SizedBox(
      width: 50, child: Icon(Icons.question_mark_rounded, color: Colors.black));
}
