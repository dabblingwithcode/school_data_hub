import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

/// Color picker widget for selecting lesson group colors
class ColorPickerField extends StatelessWidget {
  final String selectedColor;
  final ValueChanged<String> onColorChanged;

  const ColorPickerField({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  static const List<String> _predefinedColors = [
    '#3B82F6', // Blue
    '#EF4444', // Red
    '#10B981', // Green
    '#F59E0B', // Yellow
    '#8B5CF6', // Purple
    '#F97316', // Orange
    '#06B6D4', // Cyan
    '#EC4899', // Pink
    '#84CC16', // Lime
    '#6366F1', // Indigo
    '#14B8A6', // Teal
    '#F43F5E', // Rose
  ];

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Farbe',
          style: context.typography.subtitle,
        ),
        Gap(Style.spacing.sm),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: style.colors.borderSubtle),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              // Current color display
              Container(
                padding: EdgeInsets.all(Style.spacing.lg),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _parseColor(selectedColor),
                        borderRadius: BorderRadius.circular(Style.radii.small),
                        border: Border.all(color: style.colors.borderSubtle),
                      ),
                    ),
                    Gap(Style.spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aktuelle Farbe',
                            style: context.typography.bodySmall.withColor(style.colors.mutedForeground),
                          ),
                          Text(
                            selectedColor.toUpperCase(),
                            style: context.typography.body.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Color grid
              Padding(
                padding: EdgeInsets.all(Style.spacing.lg),
                child: Wrap(
                  spacing: Style.spacing.sm,
                  runSpacing: Style.spacing.sm,
                  children:
                      _predefinedColors.map((color) {
                        final isSelected = color == selectedColor;
                        return GestureDetector(
                          onTap: () => onColorChanged(color),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _parseColor(color),
                              borderRadius: BorderRadius.circular(Style.radii.small),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? style.colors.accent
                                        : style.colors.borderSubtle,
                                width: isSelected ? 3 : 1,
                              ),
                            ),
                            child:
                                isSelected
                                    ? Icon(
                                      Icons.check,
                                      color: style.colors.background,
                                      size: 20,
                                    )
                                    : null,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _parseColor(String colorString) {
    try {
      String hexColor = colorString;
      if (!hexColor.startsWith('#')) {
        hexColor = '#$hexColor';
      }

      if (hexColor.length == 7) {
        return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
      }
    } catch (e) {
      // Return default color if parsing fails
    }
    return Colors.grey;
  }
}
