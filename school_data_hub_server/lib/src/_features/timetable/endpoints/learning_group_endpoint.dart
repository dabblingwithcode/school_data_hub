import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class LearningGroupEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<LessonGroup> createLessonGroup(
      Session session, LessonGroup lessonGroup) async {
    final lessonGroupInDatabase =
        await LessonGroup.db.insertRow(session, lessonGroup);
    return lessonGroupInDatabase;
  }

  //- read

  Future<List<LessonGroup>> fetchLessonGroups(Session session) async {
    final lessonGroups = await LessonGroup.db.find(
      session,
      include: LessonGroup.include(
        scheduledLessons: ScheduledLesson.includeList(),
        memberships: ScheduledLessonGroupMembership.includeList(),
      ),
    );
    return lessonGroups;
  }

  Future<LessonGroup?> fetchLessonGroupById(Session session, int id) async {
    final lessonGroup = await LessonGroup.db.findById(
      session,
      id,
      include: LessonGroup.include(
        scheduledLessons: ScheduledLesson.includeList(),
        memberships: ScheduledLessonGroupMembership.includeList(),
      ),
    );
    return lessonGroup;
  }

  Future<LessonGroup?> fetchLessonGroupByPublicId(
      Session session, String publicId) async {
    final lessonGroup = await LessonGroup.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
      include: LessonGroup.include(
        scheduledLessons: ScheduledLesson.includeList(),
        memberships: ScheduledLessonGroupMembership.includeList(),
      ),
    );
    return lessonGroup;
  }

  Future<List<LessonGroup>> fetchLessonGroupsByName(
      Session session, String name) async {
    final lessonGroups = await LessonGroup.db.find(
      session,
      where: (t) => t.name.equals(name),
      include: LessonGroup.include(
        scheduledLessons: ScheduledLesson.includeList(),
        memberships: ScheduledLessonGroupMembership.includeList(),
      ),
    );
    return lessonGroups;
  }

  Future<List<LessonGroup>> fetchLessonGroupsByCreator(
      Session session, String createdBy) async {
    final lessonGroups = await LessonGroup.db.find(
      session,
      where: (t) => t.createdBy.equals(createdBy),
      include: LessonGroup.include(
        scheduledLessons: ScheduledLesson.includeList(),
        memberships: ScheduledLessonGroupMembership.includeList(),
      ),
    );
    return lessonGroups;
  }

  //- update

  Future<LessonGroup> updateLessonGroup(
      Session session, LessonGroup lessonGroup) async {
    final updatedLessonGroup =
        await LessonGroup.db.updateRow(session, lessonGroup);
    return updatedLessonGroup;
  }

  //- delete

  Future<bool> deleteLessonGroup(Session session, int id) async {
    final lessonGroup = await LessonGroup.db.findById(session, id);
    if (lessonGroup == null) {
      throw Exception('Lesson group with id $id does not exist.');
    }

    // Check if lesson group has scheduled lessons
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.lessonGroupId.equals(id),
    );

    if (scheduledLessons.isNotEmpty) {
      throw Exception(
          'Cannot delete lesson group with id $id because it has scheduled lessons.');
    }

    // Check if lesson group has memberships
    final memberships = await ScheduledLessonGroupMembership.db.find(
      session,
      where: (t) => t.lessonGroupId.equals(id),
    );

    if (memberships.isNotEmpty) {
      throw Exception(
          'Cannot delete lesson group with id $id because it has memberships.');
    }

    await LessonGroup.db.deleteRow(session, lessonGroup);
    return true;
  }
}
