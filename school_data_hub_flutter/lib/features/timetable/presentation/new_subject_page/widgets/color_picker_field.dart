import 'package:flutter/material.dart';

class ColorPickerField extends StatelessWidget {
  final ValueNotifier<String> selectedColor;

  const ColorPickerField({super.key, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Farbe',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<String>(
          valueListenable: selectedColor,
          builder: (context, color, child) {
            return Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _parseColor(color),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: color,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items:
                        [
                          {'name': 'Rot', 'value': '#FF5722'},
                          {'name': 'Blau', 'value': '#2196F3'},
                          {'name': 'Grün', 'value': '#4CAF50'},
                          {'name': 'Gelb', 'value': '#FFC107'},
                          {'name': 'Orange', 'value': '#FF9800'},
                          {'name': 'Lila', 'value': '#9C27B0'},
                          {'name': 'Pink', 'value': '#E91E63'},
                          {'name': 'Türkis', 'value': '#00BCD4'},
                          {'name': 'Braun', 'value': '#795548'},
                          {'name': 'Grau', 'value': '#607D8B'},
                        ].map((color) {
                          return DropdownMenuItem<String>(
                            value: color['value'],
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _parseColor(color['value']!),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(color['name']!),
                              ],
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedColor.value = newValue;
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
    } catch (e) {
      return Colors.grey;
    }
  }
}
