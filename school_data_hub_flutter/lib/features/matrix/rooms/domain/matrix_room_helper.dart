import 'package:collection/collection.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();

class MatrixRoomHelper {
  static List<MatrixUser> usersInRoom(String roomId) {
    final List<MatrixUser> users = List.from(
      _matrixPolicyManager.matrixUsers.value,
    );
    final usersInRoom =
        users
            .where((user) => user.matrixRooms.any((room) => room.id == roomId))
            .toList();
    return usersInRoom;
  }

  static int? powerLevelInRoom({
    required MatrixRoom room,
    required String userId,
  }) {
    if (room.roomAdmins != null) {
      final RoomAdmin? userAsRoomAdmin = room.roomAdmins!.firstWhereOrNull(
        (admin) => admin.id == userId,
      );
      if (userAsRoomAdmin != null) {
        return userAsRoomAdmin.powerLevel;
      } else {
        return null;
      }
    }

    return room.powerLevelReactions;
  }

  static List<MatrixRoom> roomsFromRoomJoinedRooms(
    List<JoinedRoom> joinedRooms,
  ) {
    final List<MatrixRoom> rooms = List.from(
      _matrixPolicyManager.matrixRooms.value,
    );
    final roomsFromRoomIds =
        rooms
            .where(
              (room) => joinedRooms.any((element) => element.roomId == room.id),
            )
            .toList();
    return roomsFromRoomIds;
  }

  static List<MatrixRoom> roomsFromRoomIds(List<String> roomIds) {
    final List<MatrixRoom> rooms = List.from(
      _matrixPolicyManager.matrixRooms.value,
    );
    final roomsFromRoomIds =
        rooms.where((room) => roomIds.contains(room.id)).toList();
    return roomsFromRoomIds;
  }

  static List<String> restOfRooms(List<String> roomIds) {
    List<String> restOfRooms = [];
    final rooms = _matrixPolicyManager.matrixRooms.value;
    for (MatrixRoom room in rooms) {
      if (!roomIds.contains(room.id)) {
        restOfRooms.add(room.id);
      }
    }
    return restOfRooms;
  }

  /// This one is very hacky!
  static Set<String> setOfSchoolAssignedRoomIdsForPupilOrParent({
    required String matrixUserDisplayName,

    bool? isParent,
  }) {
    Set<String> roomIds = {};

    final allRooms = _matrixPolicyManager.matrixRooms.value;

    // Helper functions to manipulate the display name
    String getSubstringAfterCharacter(String input, String character) {
      int index = input.indexOf(character);

      if (index == -1 || index == input.length - 1) {
        // Character not found or it's the last character in the string
        return '';
      }
      return input.substring(index + 1);
    }

    Set<String> splitIntoPairs(String input) {
      Set<String> pairs = {};
      for (int i = 0; i < input.length; i += 2) {
        if (i + 2 <= input.length) {
          pairs.add(input.substring(i, i + 2));
        }
      }
      return pairs;
    }

    // TODO: This is hard coded for now

    // first the common rooms
    final contactsRoom = allRooms.firstWhereOrNull(
      (room) => room.name!.contains('Kontakte'),
    );
    if (contactsRoom != null) {
      roomIds.add(contactsRoom.id);
    }

    final hermannkinderRoom = allRooms.firstWhereOrNull(
      (room) => room.name!.contains('Hermannkinder'),
    );
    if (hermannkinderRoom != null) {
      roomIds.add(hermannkinderRoom.id);
    }

    // Now the group rooms, parents get to see both parent and pupil rooms

    // First we extract the group part from the display name
    // This is a workaround to tackle the complexity of managing family accounts
    //- TODO: For now, we are using the group between brackets, like for example "Examplename (B3)"
    final String groupStringPart = getSubstringAfterCharacter(
      matrixUserDisplayName,
      ')',
    ).replaceAll(' ', '');

    Set<String> groups = splitIntoPairs(groupStringPart);
    for (MatrixRoom room in allRooms) {
      // these
      for (String group in groups) {
        if (room.name!.contains(group)) {
          roomIds.add(room.id);
          break; // No need to check other groups if one matches
        }
      }
    }
    // Now the rooms for either pupil or parent
    if (isParent == true) {
      // This room is common for all parents
      final fgzRoom = allRooms.firstWhereOrNull(
        (room) => room.name!.contains('Familien-Grundschul-Zentrum'),
      );

      if (fgzRoom != null) {
        roomIds.add(fgzRoom.id);
      }
      final globalParentsRoom = allRooms.firstWhereOrNull(
        (room) => room.name!.contains('Hermanneltern'),
      );
      if (globalParentsRoom != null) {
        roomIds.add(globalParentsRoom.id);
      }
    } else {
      //-HACKY: For now, we identify pupil rooms by the group part in the display name
      // because the group name is between brackets in the room name
      final group = getSubstringAfterCharacter(
        matrixUserDisplayName,
        '(',
      ).substring(0, 2);
      // We look for a room with the group name and not containing the word "Eltern"
      final pupilRoom = allRooms.firstWhereOrNull(
        (room) => room.name!.contains(group) && !room.name!.contains('Eltern'),
      );
      if (pupilRoom != null) {
        roomIds.add(pupilRoom.id);
      }
    }
    return roomIds;
  }
}
