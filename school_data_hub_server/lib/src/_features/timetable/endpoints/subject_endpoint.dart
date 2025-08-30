import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SubjectEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<Subject> createSubject(Session session, Subject subject) async {
    final subjectInDatabase = await Subject.db.insertRow(session, subject);
    return subjectInDatabase;
  }

  //- read

  Future<List<Subject>> fetchSubjects(Session session) async {
    final subjects = await Subject.db.find(
      session,
      include: Subject.include(
        scheduledLessons: ScheduledLesson.includeList(),
        lessons: Lesson.includeList(),
      ),
    );
    return subjects;
  }

  Future<Subject?> fetchSubjectById(Session session, int id) async {
    final subject = await Subject.db.findById(
      session,
      id,
      include: Subject.include(
        scheduledLessons: ScheduledLesson.includeList(),
        lessons: Lesson.includeList(),
      ),
    );
    return subject;
  }

  Future<Subject?> fetchSubjectByPublicId(
      Session session, String publicId) async {
    final subject = await Subject.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
      include: Subject.include(
        scheduledLessons: ScheduledLesson.includeList(),
        lessons: Lesson.includeList(),
      ),
    );
    return subject;
  }

  Future<List<Subject>> fetchSubjectsByName(
      Session session, String name) async {
    final subjects = await Subject.db.find(
      session,
      where: (t) => t.name.equals(name),
      include: Subject.include(
        scheduledLessons: ScheduledLesson.includeList(),
        lessons: Lesson.includeList(),
      ),
    );
    return subjects;
  }

  Future<List<Subject>> fetchSubjectsByCreator(
      Session session, String createdBy) async {
    final subjects = await Subject.db.find(
      session,
      where: (t) => t.createdBy.equals(createdBy),
      include: Subject.include(
        scheduledLessons: ScheduledLesson.includeList(),
        lessons: Lesson.includeList(),
      ),
    );
    return subjects;
  }

  //- update

  Future<Subject> updateSubject(Session session, Subject subject) async {
    final updatedSubject = await Subject.db.updateRow(session, subject);
    return updatedSubject;
  }

  //- delete

  Future<bool> deleteSubject(Session session, int id) async {
    final subject = await Subject.db.findById(session, id);
    if (subject == null) {
      throw Exception('Subject with id $id does not exist.');
    }

    // Check if subject has scheduled lessons
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.subjectId.equals(id),
    );

    if (scheduledLessons.isNotEmpty) {
      throw Exception(
          'Cannot delete subject with id $id because it has scheduled lessons.');
    }

    // Check if subject has lessons
    final lessons = await Lesson.db.find(
      session,
      where: (t) => t.subjectId.equals(id),
    );

    if (lessons.isNotEmpty) {
      throw Exception(
          'Cannot delete subject with id $id because it has lessons.');
    }

    await Subject.db.deleteRow(session, subject);
    return true;
  }
}
