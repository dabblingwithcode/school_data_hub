import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_filters_widget.dart';

Future<dynamic> showLearningSupportFilterBottomSheet(BuildContext context) {
  return showGenericFilterBottomSheet(
    context: context,
    filterList: const [
      CommonPupilFiltersWidget(),
      LearningSupportFiltersWidget(),
    ],
  );
}
