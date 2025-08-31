import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class TimetableSlotListPageBottomNavBar extends StatelessWidget {
  final VoidCallback onAddSlot;

  const TimetableSlotListPageBottomNavBar({
    super.key,
    required this.onAddSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onAddSlot,
                icon: const Icon(Icons.add),
                label: const Text('Neuen Zeitslot erstellen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.interactiveColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const Gap(16),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              tooltip: 'Zurück',
            ),
          ],
        ),
      ),
    );
  }
}
