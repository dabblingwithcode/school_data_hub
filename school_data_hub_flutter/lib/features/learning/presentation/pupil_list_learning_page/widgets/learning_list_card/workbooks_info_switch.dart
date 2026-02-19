import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/learning_list_card/workbooks_competence_overview.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class WorkbooksInfoSwitch extends WatchingWidget {
  final PupilProxy pupil;
  const WorkbooksInfoSwitch({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);
    return WorkbooksOverview(pupil: pupil);
  }
}
