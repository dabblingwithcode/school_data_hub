import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/select_competence_page/select_competence_page.dart';
import 'package:watch_it/watch_it.dart';

class SelectCompetence extends WatchingStatefulWidget {
  const SelectCompetence({
    super.key,
  });

  @override
  SelectCompetenceViewModel createState() => SelectCompetenceViewModel();
}

class SelectCompetenceViewModel extends State<SelectCompetence> {
  int? selectedCompetenceId;
  Competence? selectedCompetence;
  List<Competence> competences = [];

  void selectCompetence(int id) {
    setState(() {
      selectedCompetenceId = id;
      selectedCompetence = di<CompetenceManager>().findCompetenceById(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    competences =
        watchValue((CompetenceFilterManager x) => x.filteredCompetences);
    return SelectCompetencePage(this);
  }
}
