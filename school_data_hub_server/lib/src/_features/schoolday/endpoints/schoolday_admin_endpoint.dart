import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SchooldayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<SchoolSemester>> getSchoolSemesters(Session session) async {
    final schoolSemesters = await session.db.find<SchoolSemester>();

    return schoolSemesters;
  }

  Future<SchoolSemester?> getCurrentSchoolSemester(Session session) async {
    final now = DateTime.now();
    final schoolSemester = await SchoolSemester.db.findFirstRow(
      session,
      where: (t) => (t.startDate <= now) & (t.endDate >= now),
    );
    return schoolSemester;
  }

  Future<List<Schoolday>> getSchooldays(Session session) async {
    final schooldays = await session.db.find<Schoolday>();

    return schooldays;
  }
}
