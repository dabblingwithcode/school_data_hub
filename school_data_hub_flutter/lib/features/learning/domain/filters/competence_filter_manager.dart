import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/enums.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('CompetenceFilterManager');

class CompetenceFilterManager {
  CompetenceManager get _competenceManager => di<CompetenceManager>();
  final _filterState = ValueNotifier<Map<CompetenceFilter, bool>>(
    initialCompetenceFilterValues,
  );
  ValueListenable<Map<CompetenceFilter, bool>> get filterState => _filterState;

  final _filteredCompetences = ValueNotifier<List<Competence>>([]);
  ValueListenable<List<Competence>> get filteredCompetences =>
      _filteredCompetences;

  final _filtersOn = ValueNotifier<bool>(false);
  ValueListenable<bool> get filtersOn => _filtersOn;

  CompetenceFilterManager() {
    _filteredCompetences.value = _competenceManager.competences.value;
  }

  void dispose() {
    _filterState.dispose();
    _filteredCompetences.dispose();
    _filtersOn.dispose();
    return;
  }

  refreshFilteredCompetences(List<Competence> competences) {
    _filteredCompetences.value = competences;
    _log.info('refreshed filtered competences');
  }

  resetFilters() {
    _filteredCompetences.value = _competenceManager.competences.value;

    _filterState.value = {...initialCompetenceFilterValues};

    _filtersOn.value = false;
  }

  void setFilter(CompetenceFilter filter, bool isActive) {
    _filterState.value = {..._filterState.value, filter: isActive};

    filterCompetences();
  }

  void filterCompetences() {
    List<Competence> competences = _competenceManager.competences.value;

    List<Competence> filteredCompetences = [];

    final activeFilters = _filterState.value;

    for (Competence competence in competences) {
      if (competence.level != null) {
        if ((activeFilters[CompetenceFilter.E1]! &&
                !competence.level!.contains('E1')) ||
            (activeFilters[CompetenceFilter.E2]! &&
                !competence.level!.contains('E2')) ||
            (activeFilters[CompetenceFilter.S3]! &&
                !competence.level!.contains('K3')) ||
            (activeFilters[CompetenceFilter.S4]! &&
                !competence.level!.contains('K4'))) {
          continue;
        }
      }

      filteredCompetences.add(competence);

      _filteredCompetences.value = filteredCompetences;
    }
  }
}
