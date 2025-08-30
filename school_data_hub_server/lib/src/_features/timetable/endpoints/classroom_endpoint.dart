import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ClassroomEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<Classroom> createClassroom(
      Session session, Classroom classroom) async {
    final classroomInDatabase =
        await Classroom.db.insertRow(session, classroom);
    return classroomInDatabase;
  }

  //- read

  Future<List<Classroom>> fetchClassrooms(Session session) async {
    final classrooms = await Classroom.db.find(
      session,
      include: Classroom.include(
        scheduledLessons: ScheduledLesson.includeList(),
      ),
    );
    return classrooms;
  }

  Future<Classroom?> fetchClassroomById(Session session, int id) async {
    final classroom = await Classroom.db.findById(
      session,
      id,
      include: Classroom.include(
        scheduledLessons: ScheduledLesson.includeList(),
      ),
    );
    return classroom;
  }

  Future<Classroom?> fetchClassroomByRoomCode(
      Session session, String roomCode) async {
    final classroom = await Classroom.db.findFirstRow(
      session,
      where: (t) => t.roomCode.equals(roomCode),
      include: Classroom.include(
        scheduledLessons: ScheduledLesson.includeList(),
      ),
    );
    return classroom;
  }

  Future<List<Classroom>> fetchClassroomsByRoomName(
      Session session, String roomName) async {
    final classrooms = await Classroom.db.find(
      session,
      where: (t) => t.roomName.equals(roomName),
      include: Classroom.include(
        scheduledLessons: ScheduledLesson.includeList(),
      ),
    );
    return classrooms;
  }

  //- update

  Future<Classroom> updateClassroom(
      Session session, Classroom classroom) async {
    final updatedClassroom = await Classroom.db.updateRow(session, classroom);
    return updatedClassroom;
  }

  //- delete

  Future<bool> deleteClassroom(Session session, int id) async {
    final classroom = await Classroom.db.findById(session, id);
    if (classroom == null) {
      throw Exception('Classroom with id $id does not exist.');
    }

    // Check if classroom has scheduled lessons
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.roomId.equals(id),
    );

    if (scheduledLessons.isNotEmpty) {
      throw Exception(
          'Cannot delete classroom with id $id because it has scheduled lessons.');
    }

    await Classroom.db.deleteRow(session, classroom);
    return true;
  }
}
