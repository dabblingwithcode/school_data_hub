import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/set_bulk_support_categoies_status_page/manager/set_bulk_support_categories_status_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/set_bulk_support_categoies_status_page/widgets/scorable_support_category_tree.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// A page that allows scoring support categories for a pupil.
///
/// Categories that already have a status are indicated with a green dot.
/// Changes can be made using the GrowthDropdown for each category.
/// The FAB saves all pending changes at once.
class SetBulkSupportCategoriesStatusPage extends WatchingWidget {
  final PupilProxy pupil;

  const SetBulkSupportCategoriesStatusPage({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final manager = createOnce(
      () => SetBuldSupportCategoriesStatusManager(pupil: pupil),
    );
    final pendingScores = watch(manager.pendingScores).value;
    final hasPendingChanges = pendingScores.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Förderung - ${pupil.firstName}',
          style: AppStyles.appBarTextStyle,
        ),
        actions: [
          if (hasPendingChanges)
            IconButton(
              icon: const Icon(Icons.clear_all, color: Colors.white),
              tooltip: 'Alle Änderungen verwerfen',
              onPressed: () => manager.clearAllScores(),
            ),
        ],
      ),
      body: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Kategorien bewerten',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hasPendingChanges
                                    ? '${pendingScores.length} Änderung${pendingScores.length > 1 ? 'en' : ''} ausstehend'
                                    : 'Bewertungen mit dem Dropdown auswählen',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: hasPendingChanges
                                      ? AppColors.interactiveColor
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Legend
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Bereits bewertet',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ScorableSupportCategoryTree(pupil: pupil, manager: manager),
                  const SizedBox(height: 80), // Space for FAB
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: hasPendingChanges
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.backgroundColor,
              icon: const Icon(Icons.save, color: Colors.white),
              label: Text(
                'Speichern (${pendingScores.length})',
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () => _saveAllChanges(context, manager),
            )
          : null,
    );
  }

  Future<void> _saveAllChanges(
    BuildContext context,
    SetBuldSupportCategoriesStatusManager manager,
  ) async {
    final learningSupportManager = di<LearningSupportManager>();
    final pendingScores = manager.pendingScoresList;

    if (pendingScores.isEmpty) return;

    // Show loading indicator
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Process all pending scores
      for (final pending in pendingScores) {
        // For now, we always create a new status entry
        // The backend handles whether it's an update or create
        await learningSupportManager.postSupportCategoryStatus(
          pupilId: pupil.pupilId,
          supportCategoryId: pending.categoryId,
          status: pending.score,
          comment: '', // Empty comment for batch scoring
        );
      }

      // Clear pending changes after successful save
      manager.clearAllScores();

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Return to previous page
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Close loading dialog on error
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Speichern: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
