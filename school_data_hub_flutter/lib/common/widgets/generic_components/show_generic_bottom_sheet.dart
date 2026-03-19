export 'package:school_data_hub_flutter/common/widgets/generic_components/show_sheet.dart';

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_sheet.dart';

@Deprecated('Use showSheet instead')
Future<void> showGenericBottomSheet(
    BuildContext parentContext, Widget bottomSheet) =>
    showSheet(parentContext, bottomSheet);
