import 'package:collection/collection.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();

class MatrixRoomHelper {
  static List<MatrixUser> usersInRoom(String roomId) {
    final List<MatrixUser> users =
        List.from(_matrixPolicyManager.matrixUsers.value);
    final usersInRoom = users
        .where((user) => user.matrixRooms.any((room) => room.id == roomId))
        .toList();
    return usersInRoom;
  }

  static int? powerLevelInRoom(
      {required MatrixRoom room, required String userId}) {
    if (room.roomAdmins != null) {
      final RoomAdmin? userAsRoomAdmin =
          room.roomAdmins!.firstWhereOrNull((admin) => admin.id == userId);
      if (userAsRoomAdmin != null) {
        return userAsRoomAdmin.powerLevel;
      } else {
        return null;
      }
    }

    return room.powerLevelReactions;
  }

  static List<MatrixRoom> roomsFromRoomIds(List<String> roomIds) {
    final List<MatrixRoom> rooms =
        List.from(_matrixPolicyManager.matrixRooms.value);
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

  static Set<String> roomIdsForPupilOrParent(
      String displayName, bool? isParent) {
    Set<String> roomIds = {};
    final allRooms = _matrixPolicyManager.matrixRooms.value;
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
    roomIds
        .add(allRooms.firstWhere((room) => room.name!.contains('Kontakte')).id);
    roomIds.add(allRooms
        .firstWhere((room) => room.name!.contains('Hermannkinder 2024-25'))
        .id);

    // then the rooms for the pupil or parent
    if (isParent == true) {
      // this room is common for all parents
      roomIds.add(allRooms
          .firstWhere(
              (room) => room.name!.contains('Familien-Grundschul-Zentrum'))
          .id);
      final String groupStringPart =
          getSubstringAfterCharacter(displayName, ')').replaceAll(' ', '');

      Set<String> groups = splitIntoPairs(groupStringPart);
      for (MatrixRoom room in allRooms) {
        for (String group in groups) {
          if (room.name!.contains(group)) {
            roomIds.add(room.id);

            break; // No need to check other groups if one matches
          }
        }
      }
    } else {
      // pupil rooms
      final group =
          getSubstringAfterCharacter(displayName, '(').substring(0, 2);
      roomIds.add(allRooms
          .firstWhere((room) =>
              room.name!.contains(group) && !room.name!.contains('Eltern'))
          .id);
    }
    return roomIds;
  }
}
