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
        include: SchoolList.include(pupilLists: PupilList.includeList()));
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
      // Create PupilList objects from the pupil IDs
      List<PupilList> pupilLists = pupilIds
          .map((pupilId) => PupilList(
                pupilId: pupilId,
                schoolListId: schoolListInDatabase.id!,
              ))
          .toList();

      // Bulk insert the PupilList objects
      var createdPupilLists = await PupilList.db
          .insert(session, pupilLists, transaction: transaction);
      // Attach all the PupilLists to the SchoolList
      await SchoolList.db.attach.pupilLists(
          session, schoolListInDatabase, createdPupilLists,
          transaction: transaction);
      // recall the schoollist with the pupil lists
      return schoolListInDatabase;
    });

    final schoolListWithPupilLists = await SchoolList.db.findFirstRow(
      session,
      where: (t) => t.id.equals(schoolListInDatabase.id!),
      include: SchoolList.include(pupilLists: PupilList.includeList()),
    );
    return schoolListWithPupilLists!;
  }

  Future<SchoolList> updateSchoolList(
      Session session,
      String schoolListId,
      String? name,
      String? description,
      bool? public,
      ({List<int> pupilIds, String operation})? updateMembers) async {
    final schoolList = await SchoolList.db.findFirstRow(session,
        where: (t) => t.listId.equals(schoolListId),
        include: SchoolList.include(pupilLists: PupilList.includeList()));
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
    if (updateMembers != null) {
      if (updateMembers.operation == 'add') {
        // Add new pupils to the list
        List<PupilList> pupilLists = updateMembers.pupilIds
            .map((pupilId) => PupilList(
                  pupilId: pupilId,
                  schoolListId: schoolList.id!,
                ))
            .toList();
        var createdPupilLists = await PupilList.db.insert(session, pupilLists);
        await SchoolList.db.attach
            .pupilLists(session, schoolList, createdPupilLists);
      } else if (updateMembers.operation == 'remove') {
        // Remove pupils from the list
        for (var pupilId in updateMembers.pupilIds) {
          final pupilList = await PupilList.db.findFirstRow(
            session,
            where: (t) =>
                t.pupilId.equals(pupilId) &
                t.schoolListId.equals(schoolList.id!),
          );
          if (pupilList != null) {
            // Detach the PupilList from the SchoolList

            await PupilList.db.deleteRow(session, pupilList);
          }
        }
      }
    }
    return await SchoolList.db.updateRow(session, schoolList);
  }
}
