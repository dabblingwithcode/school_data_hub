import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SchooldayEventEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<SchooldayEvent>> fetchSchooldayEvents(Session session) async {
    return SchooldayEvent.db.find(session,
        include: SchooldayEvent.include(
          schoolday: Schoolday.include(),
        ));
  }

  Future<SchooldayEvent> createSchooldayEvent(Session session,
      {required int pupilId,
      required int schooldayId,
      required SchooldayEventType type,
      required String reason,
      required String createdBy}) async {
    final eventId = Uuid().v4();

    final schooldayEvent = SchooldayEvent(
      eventId: eventId,
      pupilId: pupilId,
      schooldayId: schooldayId,
      eventType: type,
      eventReason: reason,
      createdBy: createdBy,
      processed: false,
    );

    final eventInDatabase = await session.db.insertRow(schooldayEvent);
    final eventWithSchoolday = await SchooldayEvent.db.findById(
      session,
      eventInDatabase.id!,
      include: SchooldayEvent.include(
        schoolday: Schoolday.include(),
      ),
    );
    return eventWithSchoolday!;
  }

  Future<SchooldayEvent> updateSchooldayEvent(
      Session session, SchooldayEvent schooldayEvent) async {
    await session.db.updateRow(schooldayEvent);
    final updatedSchooldayEvent = await SchooldayEvent.db.findById(
        session, schooldayEvent.id!,
        include: SchooldayEvent.include());
    return updatedSchooldayEvent!;
  }

  Future<bool> deleteSchooldayEvent(
      Session session, int schooldayEventId) async {
    final schooldayEvent = await SchooldayEvent.db.findById(
      session,
      schooldayEventId,
    );
    if (schooldayEvent == null) {
      throw Exception('Schoolday event not found');
    }
    await session.db.deleteRow(schooldayEvent);
    return true;
  }
}
