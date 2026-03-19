import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

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
          final style = Style.of(statefulContext);
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
                      padding: EdgeInsets.all(Style.spacing.md),
                      decoration: BoxDecoration(
                        color: style.colors.cardInCard,
                        borderRadius: BorderRadius.circular(Style.radii.small),
                        border: Border.all(
                          color: style.colors.cardInCardBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Förderziel:',
                            style: statefulContext.typography.bodySmall
                                .withColor(style.colors.mutedForeground),
                          ),
                          Gap(Style.spacing.xs),
                          Text(
                            goal.description,
                            style: statefulContext.typography.body.bold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Gap(Style.spacing.lg),

                    // Score selection
                    Text(
                      'Fortschritt bewerten:',
                      style: statefulContext.typography.body.bold,
                    ),
                    Gap(Style.spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ScoreButton(
                          score: 1,
                          isSelected: scoreValue == 1,
                          onTap: () => setState(() => scoreValue = 1),
                        ),
                        Gap(Style.spacing.sm),
                        _ScoreButton(
                          score: 2,
                          isSelected: scoreValue == 2,
                          onTap: () => setState(() => scoreValue = 2),
                        ),
                        Gap(Style.spacing.sm),
                        _ScoreButton(
                          score: 3,
                          isSelected: scoreValue == 3,
                          onTap: () => setState(() => scoreValue = 3),
                        ),
                        Gap(Style.spacing.sm),
                        _ScoreButton(
                          score: 4,
                          isSelected: scoreValue == 4,
                          onTap: () => setState(() => scoreValue = 4),
                        ),
                      ],
                    ),
                    Gap(Style.spacing.lg),

                    // Comment field
                    Text(
                      'Kommentar:',
                      style: statefulContext.typography.body.bold,
                    ),
                    Gap(Style.spacing.sm),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: style.colors.accent),
                        borderRadius: BorderRadius.circular(Style.radii.small),
                      ),
                      child: TextFormField(
                        controller: commentController,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: statefulContext.typography.subtitle,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Beobachtungen und Anmerkungen...',
                          contentPadding: EdgeInsets.all(Style.spacing.md),
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
                padding: EdgeInsets.only(
                  left: Style.spacing.lg,
                  right: Style.spacing.lg,
                  bottom: Style.spacing.md,
                ),
                child: Button(
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    Navigator.of(dialogContext).pop(null);
                  },
                  label: 'ABBRECHEN',
                ),
              ),

              // Confirm button
              Padding(
                padding: EdgeInsets.only(
                  left: Style.spacing.lg,
                  right: Style.spacing.lg,
                  bottom: Style.spacing.md,
                ),
                child: Button(
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
                  label: 'SPEICHERN',
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
    final style = Style.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Style.radii.small),
          border: Border.all(
            color: isSelected
                ? style.colors.success
                : style.colors.cardInCardBorder,
            width: isSelected ? 3 : 1,
          ),
          color: isSelected
              ? style.colors.success.withValues(alpha: 0.1)
              : const Color(0x00000000),
        ),
        child: Padding(
          padding: EdgeInsets.all(Style.spacing.xs),
          child: Image.asset(
            'assets/images/growth_icons/growth_$score-4.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
