export 'package:school_data_hub_flutter/common/widgets/generic_components/filter_sheet.dart';

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_sheet.dart';

@Deprecated('Use FilterSheet instead')
typedef GenericFilterBottomSheet = FilterSheet;

@Deprecated('Use showFilterSheet instead')
Future<dynamic> showGenericFilterBottomSheet({
  required BuildContext context,
  required List<Widget> filterList,
}) =>
    showFilterSheet(context: context, filterList: filterList);
