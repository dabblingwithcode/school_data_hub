import 'package:collection/collection.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MatrixEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<CompulsoryRoom>?> getCompulsoryRooms(Session session) async {
    final compulsoryRooms = await CompulsoryRoom.db.find(
      session,
    );

    return compulsoryRooms;
  }

  Future<List<CompulsoryRoom>> setCompulsoryRooms(
      Session session, List<CompulsoryRoom> compulsoryRooms) async {
    var oldCompulsoryRooms = await CompulsoryRoom.db.find(session);
    if (oldCompulsoryRooms.isEmpty) {
      for (var room in compulsoryRooms) {
        await CompulsoryRoom.db.insertRow(session, room);
      }
      return compulsoryRooms;
    }
    for (var room in compulsoryRooms) {
      var existingRoom = oldCompulsoryRooms.firstWhereOrNull(
        (r) => r.roomId == room.roomId,
      );
      if (existingRoom == null) {
        await CompulsoryRoom.db.insertRow(session, room);
      } else {
        existingRoom.roomId = room.roomId;
        existingRoom.roomType = room.roomType;
        await CompulsoryRoom.db.updateRow(session, room);
      }
    }
    return compulsoryRooms;
  }

  Future<void> deleteCompulsoryRoom(Session session, String roomId) async {
    var room = await CompulsoryRoom.db
        .findFirstRow(session, where: (r) => r.roomId.equals(roomId));
    if (room != null) {
      await CompulsoryRoom.db.deleteRow(session, room);
    }
  }
}
