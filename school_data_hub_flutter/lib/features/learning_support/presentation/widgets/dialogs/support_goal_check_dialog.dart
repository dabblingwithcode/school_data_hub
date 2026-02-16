import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

final GlobalKey<FormState> _goalCheckFormKey = GlobalKey<FormState>();

/// Shows a dialog to create a new support goal check.
/// Returns the created [SupportGoalCheck] or null if cancelled.
Future<SupportGoalCheck?> supportGoalCheckDialog({
  required BuildContext context,
  required SupportGoal goal,
}) async {
  return await showDialog<SupportGoalCheck?>(
    context: context,
    builder: (dialogContext) {
      int scoreValue = 1;
      final commentController = TextEditingController();

      return StatefulBuilder(
        builder: (statefulContext, setState) {
          return AlertDialog(
            title: const Text('Neuer Ziel-Check'),
            content: Form(
              key: _goalCheckFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Goal info header
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.cardInCardColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.cardInCardBorderColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Förderziel:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Gap(4),
                          Text(
                            goal.description,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),

                    // Score selection
                    const Text(
                      'Fortschritt bewerten:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ScoreButton(
                          score: 1,
                          isSelected: scoreValue == 1,
                          onTap: () => setState(() => scoreValue = 1),
                        ),
                        const Gap(8),
                        _ScoreButton(
                          score: 2,
                          isSelected: scoreValue == 2,
                          onTap: () => setState(() => scoreValue = 2),
                        ),
                        const Gap(8),
                        _ScoreButton(
                          score: 3,
                          isSelected: scoreValue == 3,
                          onTap: () => setState(() => scoreValue = 3),
                        ),
                        const Gap(8),
                        _ScoreButton(
                          score: 4,
                          isSelected: scoreValue == 4,
                          onTap: () => setState(() => scoreValue = 4),
                        ),
                      ],
                    ),
                    const Gap(16),

                    // Comment field
                    const Text(
                      'Kommentar:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.backgroundColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: commentController,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Beobachtungen und Anmerkungen...',
                          contentPadding: EdgeInsets.all(12),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Bitte einen Kommentar eingeben';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              // Cancel button
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    Navigator.of(dialogContext).pop(null);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),

              // Confirm button
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () {
                    if (_goalCheckFormKey.currentState!.validate()) {
                      final check = SupportGoalCheck(
                        checkId: '', // Will be generated by server/manager
                        createdBy: '', // Will be set by manager
                        createdAt: DateTime.now(),
                        score: scoreValue,
                        comment: commentController.text.trim(),
                        supportGoalId: goal.id!,
                      );
                      Navigator.of(dialogContext).pop(check);
                    }
                  },
                  child: const Text(
                    'SPEICHERN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

/// A button widget for selecting a score value.
class _ScoreButton extends StatelessWidget {
  final int score;
  final bool isSelected;
  final VoidCallback onTap;

  const _ScoreButton({
    required this.score,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppColors.successButtonColor
                : AppColors.cardInCardBorderColor,
            width: isSelected ? 3 : 1,
          ),
          color: isSelected
              ? AppColors.successButtonColor.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            'assets/images/growth_icons/growth_$score-4.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
