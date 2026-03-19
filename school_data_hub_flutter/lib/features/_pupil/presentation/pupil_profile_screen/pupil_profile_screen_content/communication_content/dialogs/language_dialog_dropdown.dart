import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/picker.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class LanguageDialogDropdown extends StatelessWidget {
  final int value;
  final ValueChanged<int?> onChanged;
  final String label;
  final IconData icon;

  const LanguageDialogDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.icon,
  });

  static const _items = [0, 1, 2, 3, 4];

  static String _labelFor(int value) {
    return switch (value) {
      0 => 'nicht',
      1 => 'einfache Anliegen',
      2 => 'komplexere Informationen',
      3 => 'ohne Probleme',
      4 => 'unbekannt',
      _ => 'unbekannt',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              const Gap(5),
              Text(
                "$label: ",
                textAlign: TextAlign.center,
                style: context.typography.title.bold.withColor(
                  Style.of(context).colors.foreground,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Picker<int>(
                  items: _items,
                  value: value,
                  onChanged: (newValue) => onChanged(newValue),
                  itemLabel: _labelFor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
