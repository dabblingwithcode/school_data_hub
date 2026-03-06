import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Represents a pending score change for a support category
class PendingCategoryScore {
  final int categoryId;
  final int score;
  final SupportCategoryStatus? existingStatus;

  const PendingCategoryScore({
    required this.categoryId,
    required this.score,
    this.existingStatus,
  });

  /// Whether this is an update to an existing status or a new one
  bool get isUpdate => existingStatus != null;
}

/// Manager for handling support category scoring state
/// in the ScoreSupportCategoryPage
class SetBuldSupportCategoriesStatusManager extends ChangeNotifier {
  final PupilProxy pupil;

  SetBuldSupportCategoriesStatusManager({required this.pupil});

  /// Map of categoryId -> pending score changes
  final _pendingScores = ValueNotifier<Map<int, PendingCategoryScore>>({});

  /// The pending score changes
  ValueListenable<Map<int, PendingCategoryScore>> get pendingScores =>
      _pendingScores;

  /// Get the current score for a category (pending or existing)
  int? getScoreForCategory(int categoryId) {
    // First check pending scores
    final pending = _pendingScores.value[categoryId];
    if (pending != null) {
      return pending.score;
    }

    // Then check existing statuses
    final existingStatus = _getExistingStatus(categoryId);
    if (existingStatus != null) {
      return existingStatus.score;
    }

    return null;
  }

  /// Get the existing status for a category if it exists
  SupportCategoryStatus? _getExistingStatus(int categoryId) {
    final statuses = pupil.supportCategoryStatuses;
    if (statuses == null || statuses.isEmpty) return null;

    // Find the most recent status for this category
    final categoryStatuses = statuses
        .where((s) => s.supportCategoryId == categoryId)
        .toList();
    if (categoryStatuses.isEmpty) return null;

    categoryStatuses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return categoryStatuses.first;
  }

  /// Check if a category has an existing status
  bool hasExistingStatus(int categoryId) {
    return _getExistingStatus(categoryId) != null;
  }

  /// Set a score for a category
  void setScore(int categoryId, int score) {
    final existingStatus = _getExistingStatus(categoryId);
    final currentPending = _pendingScores.value[categoryId];

    // If score is 0 (question mark) and there's no existing status,
    // remove from pending (no change needed)
    if (score == 0 && existingStatus == null) {
      if (currentPending != null) {
        final updated = Map<int, PendingCategoryScore>.from(
          _pendingScores.value,
        )..remove(categoryId);
        _pendingScores.value = updated;
      }
      return;
    }

    // If score matches existing status score and no pending change needed
    if (existingStatus != null && existingStatus.score == score) {
      // Remove from pending if it was there
      if (currentPending != null) {
        final updated = Map<int, PendingCategoryScore>.from(
          _pendingScores.value,
        )..remove(categoryId);
        _pendingScores.value = updated;
      }
      return;
    }

    // Add or update pending score
    final updated = Map<int, PendingCategoryScore>.from(_pendingScores.value);
    updated[categoryId] = PendingCategoryScore(
      categoryId: categoryId,
      score: score,
      existingStatus: existingStatus,
    );
    _pendingScores.value = updated;
  }

  /// Clear a pending score for a category
  void clearScore(int categoryId) {
    if (_pendingScores.value.containsKey(categoryId)) {
      final updated = Map<int, PendingCategoryScore>.from(_pendingScores.value)
        ..remove(categoryId);
      _pendingScores.value = updated;
    }
  }

  /// Clear all pending scores
  void clearAllScores() {
    _pendingScores.value = {};
  }

  /// Check if there are any pending changes
  bool get hasPendingChanges => _pendingScores.value.isNotEmpty;

  /// Get all pending scores as a list
  List<PendingCategoryScore> get pendingScoresList =>
      _pendingScores.value.values.toList();

  @override
  void dispose() {
    _pendingScores.dispose();
    super.dispose();
  }
}
