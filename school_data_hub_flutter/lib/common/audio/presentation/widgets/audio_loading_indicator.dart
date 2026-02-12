import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

/// A loading indicator displayed while audio is being loaded.
class AudioLoadingIndicator extends StatelessWidget {
  const AudioLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.interactiveColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.interactiveColor.withValues(alpha: 0.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.interactiveColor,
            ),
          ),
          const SizedBox(width: 8),
          const Text('Lädt Audio...', style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
