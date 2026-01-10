import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/widgets/learning_list_card/workbooks_competence_overview.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class WorkbooksInfoSwitch extends WatchingWidget {
  final PupilProxy pupil;
  const WorkbooksInfoSwitch({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    return WorkbooksCompetenceOverview(pupil: pupil);
  }
}
