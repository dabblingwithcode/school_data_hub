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
  surfaceContainer: AppColors.surfaceContainerColor,
  surfaceSecondaryContainer: AppColors.surfaceSecondaryContainerColor,
  surfaceWarningContainer: AppColors.surfaceWarningContainerColor,
  button: ButtonColors(
    primary: AppColors.appStyleButtonColor,
    primaryForeground: const Color(0xFFFAFAFA),
    secondary: AppColors.secondaryButtonColor,
    secondaryForeground: const Color(0xFFFAFAFA),
    destructive: AppColors.dangerButtonColor,
    destructiveForeground: const Color(0xFFFAFAFA),
    link: AppColors.interactiveColor,
    accent: const Color(0xFFF4F4F5),
  ),
  navigation: const NavigationColors(
    railBackground: Color(0xFFFAFAFA),
    railItemBackgroundActive: Color(0xFFFFFFFF),
    railItemBackgroundHover: Color(0xFFF2F2F2),
    railItemText: Color(0xFF2A2A2A),
    bottomBarBackground: Color(0xFFFFFFFF),
    bottomBarItemActive: Color(0xFF121212),
    bottomBarItemInactive: Color(0xFFBBBBBB),
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
  surfaceContainer: const Color(0xFF1E1E1E),
  surfaceSecondaryContainer: const Color(0xFF121212),
  surfaceWarningContainer: const Color(0xFF3D2800),
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
  navigation: const NavigationColors(
    railBackground: Color(0xFF121212),
    railItemBackgroundActive: Color(0xFF2A2A2A),
    railItemBackgroundHover: Color(0xFF080808),
    railItemText: Color(0xFFFAFAFA),
    bottomBarBackground: Color(0xFF121212),
    bottomBarItemActive: Color(0xFFFAFAFA),
    bottomBarItemInactive: Color(0xFF71717A),
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

const SpacingTokens _spacing = SpacingTokens(
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
);

// Typography

const _fontFamily = 'Roboto';

TypographyTokens _buildTypography(Color foreground) => TypographyTokens(
  display: TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    color: foreground,
  ),
  heading: TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 32 / 24,
    color: AppColors.backgroundColor,
  ),
  title: TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 26 / 18,
    color: AppColors.backgroundColor,
  ),
  subtitle: TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    color: foreground,
  ),
  body: TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: foreground,
  ),
  bodySmall: TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: foreground,
  ),
  caption: TextStyle(
    fontFamily: _fontFamily,
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
  static SpacingTokens get spacing => _spacing;
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
  final Color surfaceSecondaryContainer;
  final Color surfaceWarningContainer;
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
    required this.surfaceSecondaryContainer,
    required this.surfaceWarningContainer,
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

class SpacingTokens {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  /// Spacing between cards in a list (e.g. ContentSliverList items).
  final double listCardSpacing;

  /// Spacing between nested cards (card-in-card).
  final double cardInCardSpacing;

  const SpacingTokens({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    this.listCardSpacing = 5,
    this.cardInCardSpacing = 4,
  });

  /// Convenience: EdgeInsets.all from a spacing value
  EdgeInsets all(double value) => EdgeInsets.all(value);

  /// Convenience: symmetric EdgeInsets
  EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
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

extension DomainColorsX on ColorTokens {
  // Attendance
  Color get attendancePresent => AppColors.presentColor;
  Color get attendanceMissed => AppColors.missedColor;
  Color get attendanceLate => AppColors.lateColor;
  Color get attendanceHome => AppColors.homeColor;
  Color get attendanceUnexcused => AppColors.unexcusedCheckColor;
  Color get attendanceContactedQuestion => AppColors.contactedQuestionColor;
  Color get attendanceContactedSuccess => AppColors.contactedSuccessColor;
  Color get attendanceContactedCalledBack => AppColors.contactedCalledBackColor;
  Color get attendanceContactedFailed => AppColors.contactedFailedColor;
  Color get attendanceGoneHome => AppColors.goneHomeColor;

  // Competence subjects
  Color get subjectGerman => AppColors.germanColor;
  Color get subjectMath => AppColors.mathColor;
  Color get subjectScience => AppColors.scienceColor;
  Color get subjectEnglish => AppColors.englishColor;
  Color get subjectArt => AppColors.artColor;
  Color get subjectMusic => AppColors.musicColor;
  Color get subjectSport => AppColors.sportColor;
  Color get subjectReligion => AppColors.religionColor;
  Color get subjectWorkBehaviour => AppColors.workBehaviourColor;
  Color get subjectSocial => AppColors.socialColor;

  // Support categories
  Color get supportKoerperWahrnehmungMotorik =>
      AppColors.koerperWahrnehmungMotorikColor;
  Color get supportSozialEmotional => AppColors.sozialEmotionalColor;
  Color get supportMathematik => AppColors.mathematikColor;
  Color get supportLernenLeisten => AppColors.lernenLeistenColor;
  Color get supportDeutsch => AppColors.deutschColor;
  Color get supportSprache => AppColors.spracheSprechenColor;

  // Growth indicators
  Color get growth1 => AppColors.growthIconColor1;
  Color get growth2 => AppColors.growthIconColor2;
  Color get growth3 => AppColors.growthIconColor3;
  Color get growth4 => AppColors.growthIconColor4;

  // UI elements
  Color get cardBackground => AppColors.cardColor;
  Color get cardInCard => AppColors.cardInCardColor;
  Color get cardInCardBorder => AppColors.cardInCardBorderColor;
  Color get canvas => AppColors.canvasColor;
  Color get selectedCard => AppColors.selectedCardColor;
  Color get notProcessed => AppColors.notProcessedColor;
  Color get interactive => AppColors.interactiveColor;

  // Pupil-specific
  Color get familyLanguageLessons => AppColors.familyLanguageLessonsColor;
  Color get ogsColor => AppColors.afterSchoolCardeColor;
  Color get groupColor => AppColors.groupColor;
  Color get schoolGradeColor => AppColors.schoolGradeColor;

  // Filter chips
  Color get filterChipSelected => AppColors.filterChipSelectedColor;
  Color get filterChipUnselected => AppColors.filterChipUnselectedColor;
  Color get filterChipCheck => AppColors.filterChipSelectedCheckColor;
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
