import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class MainMenuButton extends StatelessWidget {
  final Widget? destinationPage;
  final VoidCallback? onTap;
  final Widget buttonIcon;
  final String buttonText;
  final String? tooltipText;
  final double buttonSize;

  const MainMenuButton({
    this.destinationPage,
    this.onTap,
    required this.buttonIcon,
    required this.buttonText,
    this.buttonSize = 140,
    this.tooltipText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = buttonSize;
    const borderRadius = BorderRadius.all(Radius.circular(15.0));
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Tooltip(
        message: tooltipText ?? buttonText,
        waitDuration: const Duration(milliseconds: 500),
        preferBelow: true,
        verticalOffset: -100,
        child: Material(
          color: AppColors.backgroundColor,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap:
                onTap ??
                (destinationPage != null
                    ? () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (ctx) => destinationPage!,
                          ),
                        );
                      }
                    : null),
            mouseCursor: WidgetStateMouseCursor.clickable,
            borderRadius: borderRadius,
            child: SizedBox(
              width: size,
              height: size,
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
