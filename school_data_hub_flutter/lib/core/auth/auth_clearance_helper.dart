import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

enum Clearance { none, developer, admin, tester }

class AuthClearanceHelper {
  static bool isAuthorized(Clearance clearanceLevel, {String? createdBy}) {
    final currentUser = di<HubSessionManager>().user!;

    switch (clearanceLevel) {
      case Clearance.none:
        return true; // No clearance required, allow access
      case Clearance.developer:
        return currentUser.userInfo!.scopeNames.any(
          (scope) => scope.contains('developer'),
        );
      case Clearance.admin:
        return di<HubSessionManager>().isAdmin;
      case Clearance.tester:
        return currentUser.userFlags.isTester;
    }
  }

  static bool isAdmin() {
    return di<HubSessionManager>().isAdmin;
  }

  static bool isTutorOrAdmin(PupilProxy pupil) {
    final currentUser = di<HubSessionManager>().user!;
    final isAuthorized = currentUser.pupilsAuth?.contains(pupil.pupilId);

    final isTutor =
        pupil.groupTutor == currentUser.userInfo!.userName ||
        di<HubSessionManager>().isAdmin;
    final isAdmin = di<HubSessionManager>().isAdmin;

    return isAuthorized == true || isTutor || isAdmin;
  }

  static bool isCreatorOrAdmin(String? createdBy) {
    final currentUser = di<HubSessionManager>().user!;
    if (createdBy == null) return false;
    return currentUser.userInfo!.scopeNames.contains('serverpod.admin') ||
        currentUser.userInfo!.userName == createdBy;
  }
}
