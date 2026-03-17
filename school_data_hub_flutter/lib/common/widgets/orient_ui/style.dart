import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

// Light Theme — structural colors for light mode, dynamic palette from AppColors

ColorTokens get _colorsLight => ColorTokens(
  background: const Color(0xFFFFFFFF),
  border: const Color(0xFFE4E4E7),
  borderSubtle: const Color(0xFFF2F2F2),
  foreground: const Color(0xFF2A2A2A),
  mutedForeground: const Color(0xFFACAEAF),
  accent: AppColors.backgroundColor,
  accentForeground: const Color(0xFFFAFAFA),
  surfaceContainer: AppColors.cardInCardColor,
  button: ButtonColors(
    primary: AppColors.appStyleButtonColor,
    primaryForeground: const Color(0xFFFAFAFA),
    secondary: AppColors.secondaryButtonColor,
    secondaryForeground: const Color(0xFF18181B),
    destructive: AppColors.dangerButtonColor,
    destructiveForeground: const Color(0xFFFAFAFA),
    link: AppColors.interactiveColor,
    accent: const Color(0xFFF4F4F5),
  ),
  navigation: NavigationColors(
    railBackground: const Color(0xFFFAFAFA),
    railItemBackgroundActive: const Color(0xFFFFFFFF),
    railItemBackgroundHover: const Color(0xFFF2F2F2),
    railItemText: const Color(0xFF2A2A2A),
    bottomBarBackground: const Color(0xFFFFFFFF),
    bottomBarItemActive: const Color(0xFF121212),
    bottomBarItemInactive: const Color(0xFFBBBBBB),
  ),
  success: AppColors.successButtonColor,
  error: AppColors.dangerButtonColor,
  info: AppColors.snackBarInfoColor,
  warning: AppColors.warningButtonColor,
);

// Dark Theme — dark structural colors, same dynamic palette from AppColors

ColorTokens get _colorsDark => ColorTokens(
  background: const Color(0xFF303030),
  border: const Color(0xFF27272A),
  borderSubtle: const Color(0xFF303030),
  foreground: const Color(0xFFFAFAFA),
  mutedForeground: const Color(0xFFB2B2B2),
  accent: AppColors.backgroundColor,
  accentForeground: const Color(0xFF18181B),
  surfaceContainer: const Color(0xFF121212),
  button: ButtonColors(
    primary: AppColors.appStyleButtonColor,
    primaryForeground: const Color(0xFFFAFAFA),
    secondary: Color.lerp(
      const Color(0xFF27272A),
      AppColors.appStyleButtonColor,
      0.15,
    )!,
    secondaryForeground: const Color(0xFFFAFAFA),
    destructive: AppColors.dangerButtonColor,
    destructiveForeground: const Color(0xFFFAFAFA),
    link: AppColors.interactiveColor,
    accent: const Color(0xFF27272A),
  ),
  navigation: NavigationColors(
    railBackground: const Color(0xFF121212),
    railItemBackgroundActive: const Color(0xFF2A2A2A),
    railItemBackgroundHover: const Color(0xFF080808),
    railItemText: const Color(0xFFFAFAFA),
    bottomBarBackground: const Color(0xFF121212),
    bottomBarItemActive: const Color(0xFFFAFAFA),
    bottomBarItemInactive: const Color(0xFF71717A),
  ),
  success: AppColors.successButtonColor,
  error: AppColors.dangerButtonColor,
  info: AppColors.snackBarInfoColor,
  warning: AppColors.warningButtonColor,
);

// Tokens

final RadiusTokens _radii = const RadiusTokens(small: 8, medium: 12, large: 24);

final DurationTokens _durations = const DurationTokens(
  fast: Duration(milliseconds: 100),
  normal: Duration(milliseconds: 200),
  slow: Duration(milliseconds: 300),
);

final BreakpointTokens _breakpoints = const BreakpointTokens(desktop: 600);

// Typography

TypographyTokens _buildTypography(Color foreground) => TypographyTokens(
  display: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    color: foreground,
  ),
  heading: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 32 / 24,
    color: AppColors.backgroundColor,
  ),
  title: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 26 / 18,
    color: AppColors.backgroundColor,
  ),
  subtitle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    color: foreground,
  ),
  body: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: foreground,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: foreground,
  ),
  caption: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 15 / 11,
    color: foreground,
  ),
);

// Style

class Style extends InheritedWidget {
  final Brightness brightness;

  const Style({super.key, required this.brightness, required super.child});

  const Style._fallback(this.brightness)
    : super(child: const SizedBox.shrink());

  bool get isDark => brightness == Brightness.dark;
  ColorTokens get colors => isDark ? _colorsDark : _colorsLight;

  static RadiusTokens get radii => _radii;
  static DurationTokens get durations => _durations;
  static BreakpointTokens get breakpoints => _breakpoints;
  TypographyTokens get typography => _buildTypography(colors.foreground);

  static Style of(BuildContext context) {
    final Style? style = context.dependOnInheritedWidgetOfExactType<Style>();
    if (style != null) return style;

    final Brightness brightness = MediaQuery.platformBrightnessOf(context);

    return Style._fallback(brightness);
  }

  @override
  bool updateShouldNotify(Style oldWidget) {
    return brightness != oldWidget.brightness;
  }
}

// Token Definitions

class ColorTokens {
  final Color background;
  final Color border;
  final Color borderSubtle;
  final Color foreground;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color surfaceContainer;
  final ButtonColors button;
  final NavigationColors navigation;
  final Color success;
  final Color error;
  final Color info;
  final Color warning;

  const ColorTokens({
    required this.background,
    required this.border,
    required this.borderSubtle,
    required this.foreground,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.surfaceContainer,
    required this.button,
    required this.navigation,
    required this.success,
    required this.error,
    required this.info,
    required this.warning,
  });
}

class ButtonColors {
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color link;
  final Color accent;

  const ButtonColors({
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.link,
    required this.accent,
  });
}

class NavigationColors {
  final Color railBackground;
  final Color railItemBackgroundActive;
  final Color railItemBackgroundHover;
  final Color railItemText;
  final Color bottomBarBackground;
  final Color bottomBarItemActive;
  final Color bottomBarItemInactive;

  const NavigationColors({
    required this.railBackground,
    required this.railItemBackgroundActive,
    required this.railItemBackgroundHover,
    required this.railItemText,
    required this.bottomBarBackground,
    required this.bottomBarItemActive,
    required this.bottomBarItemInactive,
  });
}

class RadiusTokens {
  final double small;
  final double medium;
  final double large;

  const RadiusTokens({
    required this.small,
    required this.medium,
    required this.large,
  });
}

class DurationTokens {
  final Duration fast;
  final Duration normal;
  final Duration slow;

  const DurationTokens({
    required this.fast,
    required this.normal,
    required this.slow,
  });
}

class BreakpointTokens {
  final double desktop;

  const BreakpointTokens({required this.desktop});
}

class TypographyTokens {
  final TextStyle display;
  final TextStyle heading;
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle bodySmall;
  final TextStyle caption;

  const TypographyTokens({
    required this.display,
    required this.heading,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.bodySmall,
    required this.caption,
  });
}

// Extensions

extension StyleX on BuildContext {
  Style get style => Style.of(this);
  TypographyTokens get typography => Style.of(this).typography;
}

extension TextStyleX on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle muted(BuildContext context) {
    return copyWith(color: Style.of(context).colors.mutedForeground);
  }

  TextStyle withHeight(double pixels) {
    return copyWith(height: pixels / fontSize!);
  }

  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}
