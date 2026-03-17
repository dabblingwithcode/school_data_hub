import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class PupilProfileContentSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const PupilProfileContentSectionHeader({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        Icon(icon, color: AppColors.groupColor, size: 28),
        const Gap(5),
        Text(title, style: context.style.typography.title),
      ],
    );
  }
}

/// Plain holder for the minimum height that short content pages should fill.
/// Set once during layout, never changes — not a listenable.
class ProfileMinHeight {
  double value = 0;
}

class PupilProfileContentCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;
  final VoidCallback? onTitleTap;
  final Widget? headerTrailing;

  const PupilProfileContentCard({
    required this.icon,
    required this.title,
    required this.child,
    required this.iconColor,
    this.onTitleTap,
    this.headerTrailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onTitleTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 4.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(icon, color: iconColor, size: 30),
                        const Gap(10),
                        Text(
                          title,
                          style: context.style.typography.heading.copyWith(
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (headerTrailing != null) ...[
                  const Spacer(),
                  headerTrailing!,
                ],
              ],
            ),
            const Gap(12),
            child,
          ],
        ),
      ),
    );
  }
}

class PupilProfileContentRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? actionButton;

  const PupilProfileContentRow({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.onTap,
    this.onLongPress,
    this.actionButton,
    super.key,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: AppColors.cardInCardColor,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: AppColors.cardInCardBorderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.backgroundColor.withValues(alpha: 0.7),
                    size: 18,
                  ),
                  const Gap(8),
                  Text(
                    '$label:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.backgroundColor,
                    ),
                  ),

                  const Gap(6),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      onLongPress: onLongPress,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: onTap != null
                              ? const Color.fromARGB(255, 213, 219, 236)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            valueWidget ??
                            Text(
                              value!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: onTap != null
                                    ? AppColors.interactiveColor
                                    : Colors.black87,
                              ),
                            ),
                      ),
                    ),
                  ),
                  if (actionButton != null) actionButton!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section row widgets: use Start / Inside / End consecutively to build a
// grouped section with rounded top, separators between rows, and rounded
// bottom.  Each widget mirrors PupilProfileContentRow's inner layout.
// ---------------------------------------------------------------------------

Widget _sectionRowContent({
  IconData? icon,
  required String label,
  String? value,
  Widget? valueWidget,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  Widget? actionButton,
}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      children: [
        Icon(
          icon,
          color: AppColors.backgroundColor.withValues(alpha: 0.7),
          size: 18,
        ),
        const Gap(8),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.backgroundColor,
          ),
        ),
        const Gap(6),
        Expanded(
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: onTap != null
                    ? const Color.fromARGB(255, 255, 216, 137)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  valueWidget ??
                  Text(
                    value!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: onTap != null
                          ? AppColors.interactiveColor
                          : Colors.black87,
                    ),
                  ),
            ),
          ),
        ),
        if (actionButton != null) actionButton,
      ],
    ),
  );
}

Widget _separator() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: 1,
    color: AppColors.backgroundColor.withValues(alpha: 0.08),
  );
}

class PupilProfileContentSectionStart extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? actionButton;

  const PupilProfileContentSectionStart({
    this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.onTap,
    this.onLongPress,
    this.actionButton,
    super.key,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        decoration: BoxDecoration(
          color: AppColors.cardInCardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            _sectionRowContent(
              icon: icon,
              label: label,
              value: value,
              valueWidget: valueWidget,
              onTap: onTap,
              onLongPress: onLongPress,
              actionButton: actionButton,
            ),
            const Gap(5),
            _separator(),
          ],
        ),
      ),
    );
  }
}

class PupilProfileContentSectionInside extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? actionButton;

  const PupilProfileContentSectionInside({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.onTap,
    this.onLongPress,
    this.actionButton,
    super.key,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        color: AppColors.cardInCardColor,
        child: Column(
          children: [
            _sectionRowContent(
              icon: icon,
              label: label,
              value: value,
              valueWidget: valueWidget,
              onTap: onTap,
              onLongPress: onLongPress,
              actionButton: actionButton,
            ),
            const Gap(5),
            _separator(),
          ],
        ),
      ),
    );
  }
}

class PupilProfileContentSectionEnd extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? actionButton;

  const PupilProfileContentSectionEnd({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.onTap,
    this.onLongPress,
    this.actionButton,
    super.key,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.cardInCardColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: _sectionRowContent(
          icon: icon,
          label: label,
          value: value,
          valueWidget: valueWidget,
          onTap: onTap,
          onLongPress: onLongPress,
          actionButton: actionButton,
        ),
      ),
    );
  }
}

class PupilProfileContentTwoRows extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? actionButton;

  const PupilProfileContentTwoRows({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.onTap,
    this.onLongPress,
    this.actionButton,
    super.key,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: AppColors.cardInCardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.backgroundColor.withValues(alpha: 0.7),
                    size: 18,
                  ),
                  const Gap(8),
                  Text(
                    '$label:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  if (actionButton != null) ...[const Spacer(), actionButton!],
                ],
              ),
            ),
            const Gap(6),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: onTap != null ? Colors.white : Colors.transparent,

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      valueWidget ??
                      Text(
                        value!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: onTap != null
                              ? AppColors.interactiveColor
                              : Colors.black87,
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
