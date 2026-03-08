import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class MainMenuButton extends StatelessWidget {
  final Widget? destinationPage;
  final Widget buttonIcon;
  final String buttonText;
  const MainMenuButton({
    this.destinationPage,
    required this.buttonIcon,
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 150;
    const borderRadius = BorderRadius.all(Radius.circular(15.0));
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Tooltip(
        message: buttonText,
        waitDuration: const Duration(milliseconds: 500),
        preferBelow: false,
        child: Material(
          color: AppColors.backgroundColor,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: destinationPage != null
                ? () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (ctx) => destinationPage!,
                      ),
                    );
                  }
                : null,
            mouseCursor: WidgetStateMouseCursor.clickable,
            borderRadius: borderRadius,
            child: SizedBox(
              width: buttonSize,
              height: buttonSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonIcon,
                  const Gap(10),
                  Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
