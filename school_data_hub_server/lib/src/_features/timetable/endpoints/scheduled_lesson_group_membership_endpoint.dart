import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ScheduledLessonGroupMembershipEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<ScheduledLessonGroupMembership> createScheduledLessonGroupMembership(
      Session session, ScheduledLessonGroupMembership membership) async {
    final membershipInDatabase =
        await ScheduledLessonGroupMembership.db.insertRow(session, membership);
    return membershipInDatabase;
  }

  //- read

  Future<List<ScheduledLessonGroupMembership>>
      fetchScheduledLessonGroupMemberships(Session session) async {
    final memberships = await ScheduledLessonGroupMembership.db.find(
      session,
      include: ScheduledLessonGroupMembership.include(
        lessonGroup: LessonGroup.include(),
        pupilData: PupilData.include(),
      ),
    );
    return memberships;
  }

  Future<ScheduledLessonGroupMembership?>
      fetchScheduledLessonGroupMembershipById(Session session, int id) async {
    final membership = await ScheduledLessonGroupMembership.db.findById(
      session,
      id,
      include: ScheduledLessonGroupMembership.include(
        lessonGroup: LessonGroup.include(),
        pupilData: PupilData.include(),
      ),
    );
    return membership;
  }

  Future<List<ScheduledLessonGroupMembership>> fetchMembershipsByLessonGroupId(
      Session session, int lessonGroupId) async {
    final memberships = await ScheduledLessonGroupMembership.db.find(
      session,
      where: (t) => t.lessonGroupId.equals(lessonGroupId),
      include: ScheduledLessonGroupMembership.include(
        lessonGroup: LessonGroup.include(),
        pupilData: PupilData.include(),
      ),
    );
    return memberships;
  }

  Future<List<ScheduledLessonGroupMembership>> fetchMembershipsByPupilDataId(
      Session session, int pupilDataId) async {
    final memberships = await ScheduledLessonGroupMembership.db.find(
      session,
      where: (t) => t.pupilDataId.equals(pupilDataId),
      include: ScheduledLessonGroupMembership.include(
        lessonGroup: LessonGroup.include(),
        pupilData: PupilData.include(),
      ),
    );
    return memberships;
  }

  Future<ScheduledLessonGroupMembership?> fetchMembershipByLessonGroupAndPupil(
      Session session, int lessonGroupId, int pupilDataId) async {
    final membership = await ScheduledLessonGroupMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.lessonGroupId.equals(lessonGroupId) &
          t.pupilDataId.equals(pupilDataId),
      include: ScheduledLessonGroupMembership.include(
        lessonGroup: LessonGroup.include(),
        pupilData: PupilData.include(),
      ),
    );
    return membership;
  }

  //- update

  Future<ScheduledLessonGroupMembership> updateScheduledLessonGroupMembership(
      Session session, ScheduledLessonGroupMembership membership) async {
    final updatedMembership =
        await ScheduledLessonGroupMembership.db.updateRow(session, membership);
    return updatedMembership;
  }

  //- delete

  Future<bool> deleteScheduledLessonGroupMembership(
      Session session, int id) async {
    final membership =
        await ScheduledLessonGroupMembership.db.findById(session, id);
    if (membership == null) {
      throw Exception(
          'Scheduled lesson group membership with id $id does not exist.');
    }

    await ScheduledLessonGroupMembership.db.deleteRow(session, membership);
    return true;
  }

  Future<bool> deletePupilFromLessonGroup(
      Session session, int lessonGroupId, int pupilDataId) async {
    final membership = await ScheduledLessonGroupMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.lessonGroupId.equals(lessonGroupId) &
          t.pupilDataId.equals(pupilDataId),
    );

    if (membership == null) {
      throw Exception(
          'Pupil with id $pupilDataId is not a member of lesson group with id $lessonGroupId.');
    }

    await ScheduledLessonGroupMembership.db.deleteRow(session, membership);
    return true;
  }

  Future<bool> updatePupilMembershipsForLessonGroup(
      Session session, int lessonGroupId, List<int> pupilDataIds) async {
    await session.db.transaction((transaction) async {
      // Remove existing memberships for this lesson group
      await ScheduledLessonGroupMembership.db.deleteWhere(
        session,
        where: (t) => t.lessonGroupId.equals(lessonGroupId),
        transaction: transaction,
      );

      // Create new memberships
      final newMemberships = pupilDataIds.map((pupilDataId) {
        return ScheduledLessonGroupMembership(
          lessonGroupId: lessonGroupId,
          pupilDataId: pupilDataId,
        );
      }).toList();

      await ScheduledLessonGroupMembership.db.insert(
        session,
        newMemberships,
        transaction: transaction,
      );
    });

    return true;
  }
}
