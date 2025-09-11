import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

/// Manages lesson group membership operations
class TimetableMembershipManager extends ChangeNotifier {
  TimetableMembershipManager();

  /// Get all memberships for a specific lesson group
  List<ScheduledLessonGroupMembership> getMembershipsForLessonGroup(
    int lessonGroupId,
    List<ScheduledLessonGroupMembership> memberships,
  ) {
    return memberships.where((membership) => membership.lessonGroupId == lessonGroupId).toList();
  }

  /// Get all pupil IDs for a specific lesson group
  List<int> getPupilIdsForLessonGroup(
    int lessonGroupId,
    List<ScheduledLessonGroupMembership> memberships,
  ) {
    return getMembershipsForLessonGroup(lessonGroupId, memberships)
        .map((membership) => membership.pupilDataId)
        .toList();
  }

  /// Add a pupil to a lesson group
  void addPupilToLessonGroup(
    int lessonGroupId,
    int pupilDataId,
    List<ScheduledLessonGroupMembership> memberships,
    Function(List<ScheduledLessonGroupMembership>) updateMembershipsCallback,
  ) {
    // Check if membership already exists
    final existingMembership = memberships
        .where((membership) =>
            membership.lessonGroupId == lessonGroupId && membership.pupilDataId == pupilDataId)
        .firstOrNull;

    if (existingMembership != null) {
      return; // Already exists
    }

    final newId = memberships.isEmpty
        ? 1
        : memberships.map((m) => m.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;

    final newMembership = ScheduledLessonGroupMembership(
      id: newId,
      lessonGroupId: lessonGroupId,
      pupilDataId: pupilDataId,
    );

    final updatedMemberships = List<ScheduledLessonGroupMembership>.from(memberships)..add(newMembership);
    updateMembershipsCallback(updatedMemberships);
  }

  /// Remove a pupil from a lesson group
  void removePupilFromLessonGroup(
    int lessonGroupId,
    int pupilDataId,
    List<ScheduledLessonGroupMembership> memberships,
    Function(List<ScheduledLessonGroupMembership>) updateMembershipsCallback,
  ) {
    final updatedMemberships = memberships
        .where((membership) =>
            !(membership.lessonGroupId == lessonGroupId && membership.pupilDataId == pupilDataId))
        .toList();

    updateMembershipsCallback(updatedMemberships);
  }

  /// Update pupil memberships for a lesson group
  void updatePupilMembershipsForLessonGroup(
    int lessonGroupId,
    List<int> pupilDataIds,
    List<ScheduledLessonGroupMembership> memberships,
    Function(List<ScheduledLessonGroupMembership>) updateMembershipsCallback,
  ) {
    // Remove existing memberships for this lesson group
    final otherMemberships = memberships.where((membership) => membership.lessonGroupId != lessonGroupId).toList();

    // Create new memberships for the provided pupil IDs
    final newMemberships = <ScheduledLessonGroupMembership>[];
    int nextId = memberships.isEmpty
        ? 1
        : memberships.map((m) => m.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;

    for (final pupilDataId in pupilDataIds) {
      newMemberships.add(
        ScheduledLessonGroupMembership(
          id: nextId++,
          lessonGroupId: lessonGroupId,
          pupilDataId: pupilDataId,
        ),
      );
    }

    updateMembershipsCallback([...otherMemberships, ...newMemberships]);
  }

  /// Check if a pupil is a member of a lesson group
  bool isPupilMemberOfLessonGroup(
    int lessonGroupId,
    int pupilDataId,
    List<ScheduledLessonGroupMembership> memberships,
  ) {
    return memberships.any((membership) =>
        membership.lessonGroupId == lessonGroupId && membership.pupilDataId == pupilDataId);
  }
}
