// import 'package:collection/collection.dart';
import 'package:collection/collection.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _matrixPolicyManager = di<MatrixPolicyManager>();
final _pupilManager = di<PupilManager>();

class MatrixUserHelper {
  static List<MatrixUser> usersFromUserIds(List<String> userIds) {
    final List<MatrixUser> users = List.from(
      _matrixPolicyManager.matrixUsers.value,
    );
    final usersFromUserIds =
        users.where((user) => userIds.contains(user.id)).toList();
    return usersFromUserIds;
  }

  static List<String> userIdsFromUsers(List<MatrixUser> users) {
    final List<String> userIds = users.map((user) => user.id!).toList();
    return userIds;
  }

  static List<String> restOfUsers(List<String> userIds) {
    List<String> restOfUsers = [];
    final users = _matrixPolicyManager.matrixUsers.value;
    for (MatrixUser user in users) {
      if (!userIds.contains(user.id)) {
        restOfUsers.add(user.id!);
      }
    }
    return restOfUsers;
  }

  static bool isLinkedToPupil(MatrixUser user) {
    final List<PupilProxy> pupils = _pupilManager.allPupils;
    final linkedPupil = pupils.firstWhereOrNull(
      (pupil) =>
          pupil.contact == user.id ||
          pupil.tutorInfo?.parentsContact == user.id,
    );
    return linkedPupil != null;
  }

  static PupilProxy? linkedPupil(MatrixUser user) {
    final List<PupilProxy> pupils = _pupilManager.allPupils;
    final linkedPupil = pupils.firstWhereOrNull(
      (pupil) =>
          pupil.contact == user.id ||
          pupil.tutorInfo?.parentsContact == user.id,
    );
    return linkedPupil;
  }

  static MatrixUserRelationship? getUserRelationship(MatrixUser user) {
    final List<PupilProxy> pupils = _pupilManager.allPupils;
    List<PupilProxy> familyPupils = [];
    final bool isTeacher = !user.id!.contains('_');
    final bool isParent = user.id!.contains('_e');
    final linkedPupil = pupils.firstWhereOrNull(
      (pupil) => pupil.contact == user.id,
    );
    final bool isLinked = linkedPupil != null;

    if (isLinked) {
      return MatrixUserRelationship(
        pupil: linkedPupil,
        familyPupils: null,
        isTeacher: isTeacher,
      );
    }
    if (isParent) {
      final parentChild = pupils.firstWhereOrNull(
        (pupil) => pupil.tutorInfo?.parentsContact == user.id,
      );
      if (parentChild != null) {
        final siblings = _pupilManager.getSiblings(parentChild);
        for (PupilProxy pupil in siblings) {
          familyPupils.add(pupil);
        }
        // siblings does not return the parent child, let's add it manually
        familyPupils.add(parentChild);
      }

      return MatrixUserRelationship(
        pupil: null,
        familyPupils: familyPupils,
        isTeacher: isTeacher,
      );
    }
    if (isTeacher) {
      return MatrixUserRelationship(
        pupil: null,
        familyPupils: null,
        isTeacher: isTeacher,
      );
    }
    return null;
  }
}

class MatrixUserRelationship {
  final PupilProxy? pupil;
  final List<PupilProxy>? familyPupils;
  final bool isTeacher;

  MatrixUserRelationship({
    required this.pupil,
    required this.familyPupils,
    required this.isTeacher,
  });

  bool get isLinked => pupil != null;
  bool get isParent => familyPupils != null;
}
