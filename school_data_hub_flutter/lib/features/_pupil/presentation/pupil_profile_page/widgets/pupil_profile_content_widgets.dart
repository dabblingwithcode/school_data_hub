import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final style = Style.of(context);
    return Row(
      children: [
        Gap(Style.spacing.md),
        Icon(icon, color: style.colors.groupColor, size: 28),
        Gap(Style.spacing.xs),
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
    final style = Style.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Style.radii.medium),
          color: style.colors.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(Style.spacing.xs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTitleTap,
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
                        Gap(Style.spacing.md),
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
            Gap(Style.spacing.md),
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
    final style = Style.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: style.colors.cardInCard,
          borderRadius: BorderRadius.circular(Style.radii.small),
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
                    color: style.colors.accent.withValues(alpha: 0.7),
                    size: 18,
                  ),
                  Gap(Style.spacing.sm),
                  Text(
                    '$label:',
                    style: context.typography.body.w500.withColor(
                      style.colors.accent,
                    ),
                  ),

                  const Gap(6),
                  Expanded(
                    child: GestureDetector(
                      onTap: onTap,
                      onLongPress: onLongPress,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Style.spacing.sm,
                          horizontal: Style.spacing.md,
                        ),
                        decoration: BoxDecoration(
                          color: onTap != null
                              ? const Color.fromARGB(255, 213, 219, 236)
                              : style.colors.background,

                          borderRadius: BorderRadius.circular(Style.radii.small),
                        ),
                        child:
                            valueWidget ??
                            Text(
                              value!,
                              style: context.typography.body.w600.withColor(
                                onTap != null
                                    ? style.colors.interactive
                                    : style.colors.foreground,
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

Widget _sectionRowContent(
  BuildContext context, {
  IconData? icon,
  required String label,
  String? value,
  Widget? valueWidget,
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  Widget? actionButton,
}) {
  final style = Style.of(context);
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      children: [
        Icon(
          icon,
          color: style.colors.accent.withValues(alpha: 0.7),
          size: 18,
        ),
        Gap(Style.spacing.sm),
        Text(
          '$label:',
          style: context.typography.body.w500.withColor(style.colors.accent),
        ),
        const Gap(6),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Style.spacing.sm,
                horizontal: Style.spacing.md,
              ),
              decoration: BoxDecoration(
                color: onTap != null
                    ? const Color.fromARGB(255, 255, 216, 137)
                    : style.colors.background,
                borderRadius: BorderRadius.circular(Style.radii.small),
              ),
              child:
                  valueWidget ??
                  Text(
                    value!,
                    style: context.typography.body.w600.withColor(
                      onTap != null
                          ? style.colors.interactive
                          : style.colors.foreground,
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

Widget _separator(BuildContext context) {
  final style = Style.of(context);
  return Container(
    margin: EdgeInsets.symmetric(horizontal: Style.spacing.md),
    height: 1,
    color: style.colors.accent.withValues(alpha: 0.08),
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
    final style = Style.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        decoration: BoxDecoration(
          color: style.colors.cardInCard,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Style.radii.small),
            topRight: Radius.circular(Style.radii.small),
          ),
        ),
        child: Column(
          children: [
            _sectionRowContent(
              context,
              icon: icon,
              label: label,
              value: value,
              valueWidget: valueWidget,
              onTap: onTap,
              onLongPress: onLongPress,
              actionButton: actionButton,
            ),
            Gap(Style.spacing.xs),
            _separator(context),
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
    final style = Style.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        color: style.colors.cardInCard,
        child: Column(
          children: [
            _sectionRowContent(
              context,
              icon: icon,
              label: label,
              value: value,
              valueWidget: valueWidget,
              onTap: onTap,
              onLongPress: onLongPress,
              actionButton: actionButton,
            ),
            Gap(Style.spacing.xs),
            _separator(context),
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
    final style = Style.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: style.colors.cardInCard,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Style.radii.small),
            bottomRight: Radius.circular(Style.radii.small),
          ),
        ),
        child: _sectionRowContent(
          context,
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
    final style = Style.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: style.colors.cardInCard,
          borderRadius: BorderRadius.circular(Style.radii.small),
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
                    color: style.colors.accent.withValues(alpha: 0.7),
                    size: 18,
                  ),
                  Gap(Style.spacing.sm),
                  Text(
                    '$label:',
                    style: context.typography.body.w500.withColor(
                      style.colors.accent,
                    ),
                  ),
                  if (actionButton != null) ...[const Spacer(), actionButton!],
                ],
              ),
            ),
            const Gap(6),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: GestureDetector(
                onTap: onTap,
                onLongPress: onLongPress,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: Style.spacing.sm,
                    horizontal: Style.spacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: onTap != null
                        ? style.colors.background
                        : const Color(0x00000000),
                    borderRadius: BorderRadius.circular(Style.radii.small),
                  ),
                  child:
                      valueWidget ??
                      Text(
                        value!,
                        style: context.typography.body.w600.withColor(
                          onTap != null
                              ? style.colors.interactive
                              : style.colors.foreground,
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
