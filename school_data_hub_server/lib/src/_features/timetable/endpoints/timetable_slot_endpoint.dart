import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TimetableSlotEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<TimetableSlot> createTimetableSlot(
      Session session, TimetableSlot timetableSlot) async {
    // Validate that the timetable exists
    final timetable =
        await Timetable.db.findById(session, timetableSlot.timetableId);
    if (timetable == null) {
      throw Exception(
          'Timetable with id ${timetableSlot.timetableId} does not exist.');
    }

    final timetableSlotInDatabase =
        await TimetableSlot.db.insertRow(session, timetableSlot);
    session.messages.postMessage('hub_events_stream', timetableSlotInDatabase);
    HubUpdatesTracker.instance.touch(HubObjectType.timetableData);
    return timetableSlotInDatabase;
  }

  //- read

  Future<List<TimetableSlot>> fetchTimetableSlots(Session session) async {
    final timetableSlots = await TimetableSlot.db.find(
      session,
      include: TimetableSlot.include(
        timetable: Timetable.include(),
      ),
    );
    return timetableSlots;
  }

  Future<TimetableSlot?> fetchTimetableSlotById(Session session, int id) async {
    final timetableSlot = await TimetableSlot.db.findById(
      session,
      id,
      include: TimetableSlot.include(
        timetable: Timetable.include(),
      ),
    );
    return timetableSlot;
  }

  Future<List<TimetableSlot>> fetchTimetableSlotsByTimetableId(
      Session session, int timetableId) async {
    final timetableSlots = await TimetableSlot.db.find(
      session,
      where: (t) => t.timetableId.equals(timetableId),
      include: TimetableSlot.include(
        timetable: Timetable.include(),
      ),
    );
    return timetableSlots;
  }

  Future<List<TimetableSlot>> fetchTimetableSlotsByDay(
      Session session, Weekday day) async {
    final timetableSlots = await TimetableSlot.db.find(
      session,
      where: (t) => t.day.equals(day),
      include: TimetableSlot.include(
        timetable: Timetable.include(),
      ),
    );
    return timetableSlots;
  }

  //- update

  Future<TimetableSlot> updateTimetableSlot(
      Session session, TimetableSlot timetableSlot) async {
    final updatedTimetableSlot =
        await TimetableSlot.db.updateRow(session, timetableSlot);
    session.messages.postMessage('hub_events_stream', updatedTimetableSlot);
    HubUpdatesTracker.instance.touch(HubObjectType.timetableData);
    return updatedTimetableSlot;
  }

  //- delete

  Future<bool> deleteTimetableSlot(Session session, int id) async {
    final timetableSlot = await TimetableSlot.db.findById(session, id);
    if (timetableSlot == null) {
      throw Exception('Timetable slot with id $id does not exist.');
    }

    // Check if slot has scheduled lessons
    final scheduledLessons = await ScheduledLesson.db.find(
      session,
      where: (t) => t.scheduledAtId.equals(id),
    );

    if (scheduledLessons.isNotEmpty) {
      throw Exception(
          'Cannot delete timetable slot with id $id because it has scheduled lessons.');
    }

    await TimetableSlot.db.deleteRow(session, timetableSlot);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(objectType: HubObjectType.timetableData, id: id),
    );
    HubUpdatesTracker.instance.touch(HubObjectType.timetableData);
    return true;
  }
}
