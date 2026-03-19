import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/alert_popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';

void informationDialog(BuildContext context, String title, String text) =>
    AlertPopup.show(
      context: context,
      title: title,
      description: text,
      action: Button(
        label: 'OK',
        onPressed: () => Navigator.of(context).pop(),
        variant: ButtonVariant.primary,
      ),
    );
