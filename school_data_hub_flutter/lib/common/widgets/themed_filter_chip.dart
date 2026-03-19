import 'package:flutter/widgets.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class ThemedFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const ThemedFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final colors = style.colors;
    final bgColor = selected
        ? colors.filterChipSelected
        : colors.filterChipUnselected;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => onSelected(!selected),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Icon(
                  const IconData(0xe156, fontFamily: 'MaterialIcons'),
                  size: 18,
                  color: colors.filterChipCheck,
                ),
                const SizedBox(width: 4),
              ] else ...[
                const SizedBox(
                  width: 22,
                  height: 18,
                ), // Placeholder for check icon
              ],
              Text(
                label,
                style: context.typography.bodySmall.copyWith(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
