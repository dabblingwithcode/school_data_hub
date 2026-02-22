import 'package:flutter/material.dart';

class CustomCheckboxEitherOr extends StatelessWidget {
  /// Determines the color and behavior of the checkbox
  /// true = green/positive, false = red/negative
  final bool representedBoolValue;

  /// The current status value (can be null, true, or false)
  final bool? currentStatus;

  /// Callback function when checkbox value changes
  /// Returns the new status value (null, true, or false)
  final Function(bool?) onStatusChanged;

  const CustomCheckboxEitherOr({
    required this.representedBoolValue,
    required this.currentStatus,
    required this.onStatusChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if this checkbox should be checked
    bool isChecked = currentStatus == representedBoolValue;

    return SizedBox(
      width: 25,
      height: 25,
      child: Checkbox(
        activeColor: representedBoolValue ? Colors.green : Colors.red,
        value: isChecked,
        onChanged: (value) {
          bool? newStatus;

          if (value == true) {
            // User checked this box - set to the represented value
            newStatus = representedBoolValue;
          } else {
            // User unchecked this box
            if (currentStatus == representedBoolValue) {
              // If it was previously set to this value, clear it (set to null)
              newStatus = null;
            } else {
              // This shouldn't happen in normal usage, but handle it
              newStatus = null;
            }
          }

          onStatusChanged(newStatus);
        },
      ),
    );
  }
}
