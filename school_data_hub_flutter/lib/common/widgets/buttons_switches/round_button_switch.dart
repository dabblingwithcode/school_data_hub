import 'package:flutter/material.dart';

/// A reusable round button that behaves like a switch with active/inactive states.
///
/// Displays an icon in a circular container with different colors based on
/// the [isActive] state. Supports both tap and long press interactions.
class RoundButtonSwitch extends StatelessWidget {
  const RoundButtonSwitch({
    super.key,
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.onLongPress,
    required this.activeBackgroundColor,
    required this.inactiveBackgroundColor,
    required this.activeIconColor,
    required this.inactiveIconColor,
    this.iconSize = 16,
    this.padding = const EdgeInsets.all(8),
  });

  /// The icon to display in the button.
  final IconData icon;

  /// Whether the button is in active state.
  final bool isActive;

  /// Callback executed when the button is tapped.
  final VoidCallback onTap;

  /// Optional callback executed when the button is long pressed.
  final VoidCallback? onLongPress;

  /// Background color when the button is active.
  final Color activeBackgroundColor;

  /// Background color when the button is inactive.
  final Color inactiveBackgroundColor;

  /// Icon color when the button is active.
  final Color activeIconColor;

  /// Icon color when the button is inactive.
  final Color inactiveIconColor;

  /// Size of the icon. Defaults to 16.
  final double iconSize;

  /// Padding inside the button. Defaults to EdgeInsets.all(8).
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: isActive ? activeBackgroundColor : inactiveBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: isActive ? activeIconColor : inactiveIconColor,
        ),
      ),
    );
  }
}
