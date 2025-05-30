import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/generate_uuid.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/competence/presentation/multi_pupil_competence_check_page/multi_pupil_competence_check_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class MultiPupilCompetenceCheck extends WatchingStatefulWidget {
  final Competence competence;
  const MultiPupilCompetenceCheck({required this.competence, super.key});

  @override
  State<MultiPupilCompetenceCheck> createState() =>
      MultiPupilCompetenceCheckViewModel();
}

class MultiPupilCompetenceCheckViewModel
    extends State<MultiPupilCompetenceCheck> {
  late String groupId = generateCustomUuid();

  List<PupilProxy> competenceFilteredPupils = [];

  // We filter the pupils based on the competence after the pupils have gone through the other filters
  List<PupilProxy> getFilteredPupilsWithCompetence(
      {required Competence competence,
      required List<PupilProxy> pupilsToBeFiltered}) {
    List<PupilProxy> pupils = [];

    for (PupilProxy pupil in pupilsToBeFiltered) {
      if (pupil.specialNeeds != null && pupil.specialNeeds!.contains('LE')) {
        pupils.add(pupil);

        continue;
      } else {
        final allowedCompetences =
            CompetenceHelper.getAllowedCompetencesForThisPupil(pupil);

        if (allowedCompetences.contains(competence)) {
          pupils.add(pupil);

          continue;
        }
      }
    }
    return pupils;
  }

  @override
  Widget build(BuildContext context) {
    List<PupilProxy> filteredPupils =
        watchValue((PupilsFilter x) => x.filteredPupils);

    competenceFilteredPupils = getFilteredPupilsWithCompetence(
        competence: widget.competence, pupilsToBeFiltered: filteredPupils);

    return MultiPupilCompetenceCheckPage(viewModel: this);
  }
}
