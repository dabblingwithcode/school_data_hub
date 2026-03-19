import 'package:flutter/widgets.dart';

import 'style.dart';

/// Surface variant determines the background color.
enum SurfaceVariant { filled, filledSecondary, filledWarning }

/// Resolves [SurfaceVariant] to a color from [ColorTokens].
Color _surfaceColor(ColorTokens colors, SurfaceVariant variant) {
  return switch (variant) {
    SurfaceVariant.filled => colors.surfaceContainer,
    SurfaceVariant.filledSecondary => colors.surfaceSecondaryContainer,
    SurfaceVariant.filledWarning => colors.surfaceWarningContainer,
  };
}

/// A plain surface container with uniform rounded corners.
///
/// Use for information panels that don't represent items.
/// For item cards with elevation semantics, use [CardBox].
class Surface extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final SurfaceVariant variant;

  const Surface({
    super.key,
    required this.child,
    this.padding,
    this.variant = SurfaceVariant.filled,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Style.of(context).colors;
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor(colors, variant),
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
      child: child,
    );
  }
}

/// First row of a composable surface section — rounded top corners, no bottom.
///
/// Stack [SurfaceSectionStart], one or more [SurfaceSectionInside],
/// and [SurfaceSectionEnd] consecutively to build a grouped surface.
/// An optional [separator] divider is drawn at the bottom.
class SurfaceSectionStart extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final SurfaceVariant variant;
  final bool separator;

  const SurfaceSectionStart({
    super.key,
    required this.child,
    this.padding,
    this.variant = SurfaceVariant.filledSecondary,
    this.separator = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Style.of(context).colors;
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.only(left: 16, right: 16, top: 12),
      decoration: BoxDecoration(
        color: _surfaceColor(colors, variant),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (separator) _SurfaceSeparator(color: colors.accent),
        ],
      ),
    );
  }
}

/// Middle row of a composable surface section — no rounded corners.
///
/// Place between [SurfaceSectionStart] and [SurfaceSectionEnd].
class SurfaceSectionInside extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final SurfaceVariant variant;
  final bool separator;

  const SurfaceSectionInside({
    super.key,
    required this.child,
    this.padding,
    this.variant = SurfaceVariant.filledSecondary,
    this.separator = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Style.of(context).colors;
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      color: _surfaceColor(colors, variant),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (separator) _SurfaceSeparator(color: colors.accent),
        ],
      ),
    );
  }
}

/// Last row of a composable surface section — rounded bottom corners.
///
/// Closes a section started by [SurfaceSectionStart].
class SurfaceSectionEnd extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final SurfaceVariant variant;

  const SurfaceSectionEnd({
    super.key,
    required this.child,
    this.padding,
    this.variant = SurfaceVariant.filledSecondary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Style.of(context).colors;
    return Container(
      width: double.infinity,
      padding:
          padding ?? const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      decoration: BoxDecoration(
        color: _surfaceColor(colors, variant),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: child,
    );
  }
}

class _SurfaceSeparator extends StatelessWidget {
  final Color color;
  const _SurfaceSeparator({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 1,
      color: color.withValues(alpha: 0.08),
    );
  }
}
