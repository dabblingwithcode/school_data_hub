import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

enum ButtonType { action, accept, reject }

extension ButtonTypeExtension on ButtonType {
  ButtonStyle get buttonStyle {
    switch (this) {
      case ButtonType.action:
        return AppStyles.actionButtonStyle;
      case ButtonType.accept:
        return AppStyles.successButtonStyle;
      case ButtonType.reject:
        return AppStyles.cancelButtonStyle;
    }
  }
}

class GenericAsyncActionButton extends StatelessWidget {
  final IconData? icon;
  final Future<void> Function() onPressed;
  final String title;
  final ButtonType buttonType;
  const GenericAsyncActionButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.buttonType,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        child: ElevatedButton(
          style: buttonType.buttonStyle,
          onPressed: () async {
            await onPressed();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon!, size: 18, color: AppStyles.buttonTextStyle.color),
                const Gap(10),
              ],
              Text(title, style: AppStyles.buttonTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
