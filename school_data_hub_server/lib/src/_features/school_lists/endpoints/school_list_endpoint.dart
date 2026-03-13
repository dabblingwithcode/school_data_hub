import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SchoolListEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<SchoolList>> fetchSchoolLists(
      Session session, String userName) async {
    final schoolList = await SchoolList.db.find(session,
        where: (t) =>
            t.archived.equals(false) &
            (t.public.equals(true) |
                t.createdBy.equals(userName) |
                t.authorizedUsers.ilike('%$userName%')),
        include:
            SchoolList.include(pupilEntries: PupilListEntry.includeList()));
    return schoolList;
  }

  Future<SchoolList> postSchoolList(
      Session session,
      String name,
      String description,
      List<int> pupilIds,
      bool public,
      String createdBy) async {
    final listId = Uuid().v4();
    final schoolList = SchoolList(
      listId: listId,
      name: name,
      description: description,
      archived: false,
      createdBy: createdBy,
      public: public,
    );
    // use a transaction
    // to ensure that all operations are atomic
    // and rollback if any operation fails
    var schoolListInDatabase =
        await session.db.transaction((transaction) async {
      final schoolListInDatabase =
          await session.db.insertRow(schoolList, transaction: transaction);
      // Create PupilListEntry objects from the pupil IDs
      List<PupilListEntry> pupilEntries = pupilIds
          .map((pupilId) => PupilListEntry(
                pupilId: pupilId,
                schoolListId: schoolListInDatabase.id!,
              ))
          .toList();

      // Bulk insert the PupilListEntry objects
      var createdPupilListEntrys = await PupilListEntry.db
          .insert(session, pupilEntries, transaction: transaction);
      // Attach all the PupilListEntrys to the SchoolList
      await SchoolList.db.attach.pupilEntries(
          session, schoolListInDatabase, createdPupilListEntrys,
          transaction: transaction);
      // recall the schoollist with the pupil lists
      return schoolListInDatabase;
    });

    final schoolListWithPupilEntries = await SchoolList.db.findFirstRow(
      session,
      where: (t) => t.id.equals(schoolListInDatabase.id!),
      include: SchoolList.include(pupilEntries: PupilListEntry.includeList()),
    );
    session.messages.postMessage('hub_events_stream', schoolListWithPupilEntries!);
    HubUpdatesTracker.instance.touch(HubObjectType.schoolList);
    return schoolListWithPupilEntries;
  }

  Future<SchoolList> updateSchoolList(
      Session session,
      int listId,
      String? name,
      String? description,
      ({String? value})? authorizedUsers,
      bool? public,
      ({List<int> pupilIds, MemberOperation operation})? updateMembers) async {
    final schoolList = await SchoolList.db.findById(session, listId,
        include:
            SchoolList.include(pupilEntries: PupilListEntry.includeList()));
    if (schoolList == null) {
      throw Exception('SchoolList not found');
    }
    if (name != null) {
      schoolList.name = name;
    }
    if (description != null) {
      schoolList.description = description;
    }
    if (public != null) {
      schoolList.public = public;
    }
    if (authorizedUsers != null) {
      schoolList.authorizedUsers = authorizedUsers.value;
    }
    return await session.db.transaction((transaction) async {
      if (updateMembers != null) {
        if (updateMembers.operation == MemberOperation.add) {
          // Add new pupils to the list
          List<PupilListEntry> pupilEntries = updateMembers.pupilIds
              .map((pupilId) => PupilListEntry(
                    pupilId: pupilId,
                    schoolListId: schoolList.id!,
                  ))
              .toList();
          var createdPupilListEntrys = await PupilListEntry.db
              .insert(session, pupilEntries, transaction: transaction);
          await SchoolList.db.attach.pupilEntries(
              session, schoolList, createdPupilListEntrys,
              transaction: transaction);
        } else if (updateMembers.operation == MemberOperation.remove) {
          // Remove pupils from the list
          for (var pupilId in updateMembers.pupilIds) {
            final pupilEntry = await PupilListEntry.db.findFirstRow(
              session,
              where: (t) =>
                  t.pupilId.equals(pupilId) &
                  t.schoolListId.equals(schoolList.id!),
              transaction: transaction,
            );
            if (pupilEntry != null) {
              await PupilListEntry.db
                  .deleteRow(session, pupilEntry, transaction: transaction);
            }
          }
        }
      }
      await SchoolList.db
          .updateRow(session, schoolList, transaction: transaction);
      // Fetch the updated SchoolList with PupilListEntry relations
      final updatedSchoolList = await SchoolList.db.findFirstRow(
        session,
        where: (t) => t.id.equals(schoolList.id!),
        include: SchoolList.include(pupilEntries: PupilListEntry.includeList()),
        transaction: transaction,
      );
      if (updatedSchoolList == null) {
        throw Exception('Failed to update SchoolList');
      }
      session.messages.postMessage('hub_events_stream', updatedSchoolList);
      HubUpdatesTracker.instance.touch(HubObjectType.schoolList);
      return updatedSchoolList;
    });
  }

  Future<bool> deleteSchoolList(Session session, int listId) async {
    final schoolList = await SchoolList.db.findById(session, listId);
    if (schoolList == null) {
      throw Exception('SchoolList not found');
    }

    await SchoolList.db.deleteRow(session, schoolList);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(objectType: HubObjectType.schoolList, id: listId),
    );
    return true;
  }

  Future<PupilListEntry> updatePupilListEntry(
      Session session, PupilListEntry entry) async {
    final updatedEntry = await session.db.updateRow(entry);
    final schoolList = await SchoolList.db.findById(
      session,
      entry.schoolListId,
      include: SchoolList.include(pupilEntries: PupilListEntry.includeList()),
    );
    if (schoolList != null) {
      session.messages.postMessage('hub_events_stream', schoolList);
      HubUpdatesTracker.instance.touch(HubObjectType.schoolList);
    }
    return updatedEntry;
  }
}
