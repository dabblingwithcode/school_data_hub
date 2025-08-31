import 'package:flex_color_picker/flex_color_picker.dart';
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
                GestureDetector(
                  onTap: () => _showColorPicker(context),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _parseColor(color),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.color_lens,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showColorPicker(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Farbe auswählen',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context) {
    Color currentColor = _parseColor(selectedColor.value);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Farbe auswählen'),
          content: SizedBox(
            width: 300,
            height: 400,
            child: ColorPicker(
              color: currentColor,
              onColorChanged: (Color color) {
                currentColor = color;
              },
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.wheel: true,
              },
              wheelDiameter: 200,
              wheelWidth: 20,
              enableOpacity: false,
              showMaterialName: false,
              showColorName: false,
              showColorCode: true,
              colorCodeHasColor: true,
              pickerTypeLabels: const <ColorPickerType, String>{
                ColorPickerType.wheel: 'Farbspektrum',
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () {
                selectedColor.value =
                    '#${currentColor.value.toRadixString(16).substring(2)}';
                Navigator.of(context).pop();
              },
              child: const Text('Bestätigen'),
            ),
          ],
        );
      },
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
