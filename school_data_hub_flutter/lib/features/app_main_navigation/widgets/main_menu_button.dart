import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class MainMenuButton extends StatelessWidget {
  /// Route path for go_router navigation. Preferred over [destinationPage].
  final String? routePath;

  /// Legacy: widget to push via Navigator. Use [routePath] for new code.
  final Widget? destinationPage;
  final VoidCallback? onTap;
  final Widget buttonIcon;
  final String buttonText;
  final String? tooltipText;
  final double buttonSize;

  const MainMenuButton({
    this.routePath,
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
    final style = Style.of(context);
    final size = buttonSize;
    final borderRadius = BorderRadius.all(Radius.circular(Style.radii.medium));
    return Padding(
      padding: EdgeInsets.all(Style.spacing.xs),
      child: Tooltip(
        message: tooltipText ?? buttonText,
        waitDuration: const Duration(milliseconds: 500),
        preferBelow: true,
        verticalOffset: -100,
        child: Material(
          color: style.colors.accent,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            onTap: onTap ??
                (routePath != null
                    ? () => context.push(routePath!)
                    : destinationPage != null
                        ? () {
                            Navigator.of(context, rootNavigator: true)
                                .push<void>(
                              MaterialPageRoute<void>(
                                builder: (ctx) => destinationPage!,
                              ),
                            );
                          }
                        : null),
            child: MouseRegion(
              cursor: WidgetStateMouseCursor.clickable,
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
                      style: context.typography.body.bold.withColor(
                        style.colors.background,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
