import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

final AuthorizationInclude authInclude = Authorization.include(
    authorizedPupils: PupilAuthorization.includeList(
        include: PupilAuthorization.include(
  file: HubDocument.include(),
)));

class AuthorizationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Authorization>> fetchAuthorizations(Session session) async {
    final authorizations = await Authorization.db.find(
      session,
      include: authInclude,
    );

    return authorizations;
  }

  Future<Authorization?> fetchAuthorizationById(
    Session session,
    int id,
  ) async {
    final authorization = await Authorization.db.findById(
      session,
      id,
      include: authInclude,
    );

    return authorization;
  }

  Future<Authorization> postAuthorizationWithPupils(
      Session session,
      String name,
      String description,
      String createdBy,
      List<int> pupilIds) async {
    final authorization = Authorization(
      name: name,
      description: description,
      createdBy: createdBy,
    );
    final authorizationInDatabase =
        await Authorization.db.insertRow(session, authorization);
    final List<PupilAuthorization> pupilAuths = pupilIds.map((pupilId) {
      return PupilAuthorization(
        pupilId: pupilId,
        authorizationId: authorizationInDatabase.id!,
      );
    }).toList();

    var createdPupilAuths = await PupilAuthorization.db.insert(
      session,
      pupilAuths,
    );
    // Attach all the PupilAuthorizations to the Authorization
    await Authorization.db.attach.authorizedPupils(
      session,
      authorizationInDatabase,
      createdPupilAuths,
    );
    // recall the authorization with the pupil authorizations
    final authorizationWithPupils = await Authorization.db.findById(
      session,
      authorizationInDatabase.id!,
      include: Authorization.include(
          authorizedPupils: PupilAuthorization.includeList()),
    );
    return authorizationWithPupils!;
  }

  Future<Authorization> updateAuthorization(
      Session session,
      int authId,
      String? name,
      String? description,
      ({List<int> pupilIds, MemberOperation operation})? updateMembers) async {
    final authorization = await Authorization.db.findById(
      session,
      authId,
      include: Authorization.include(
          authorizedPupils: PupilAuthorization.includeList()),
    );
    if (authorization == null) {
      throw Exception('Authorization not found');
    }
    if (name != null) {
      authorization.name = name;
    }
    if (description != null) {
      authorization.description = description;
    }
    if (updateMembers != null) {
      if (updateMembers.operation == MemberOperation.add) {
        // Create PupilAuthorization objects from the pupil IDs
        List<PupilAuthorization> pupilAuths = updateMembers.pupilIds
            .map((pupilId) => PupilAuthorization(
                  pupilId: pupilId,
                  authorizationId: authorization.id!,
                ))
            .toList();
        // Bulk insert the PupilAuthorization objects
        var createdPupilAuths = await PupilAuthorization.db.insert(
          session,
          pupilAuths,
        );
        // Attach all the PupilAuthorizations to the Authorization
        await Authorization.db.attach.authorizedPupils(
          session,
          authorization,
          createdPupilAuths,
        );
      } else if (updateMembers.operation == MemberOperation.remove) {
        // Remove the PupilAuthorizations from the Authorization
        for (var pupilId in updateMembers.pupilIds) {
          final pupilAuth = await PupilAuthorization.db.findFirstRow(
            session,
            where: (t) =>
                t.pupilId.equals(pupilId) &
                t.authorizationId.equals(authorization.id!),
          );
          if (pupilAuth != null) {
            // Detach the PupilListEntry from the SchoolList

            await PupilAuthorization.db.deleteRow(session, pupilAuth);
          }
        }
      }
    }
    await Authorization.db.updateRow(session, authorization);

    final updatedAuthorization = await Authorization.db.findById(
      session,
      authorization.id!,
      include: authInclude,
    );
    return updatedAuthorization!;
  }

  Future<bool> deleteAuthorization(Session session, int authId) async {
    final authorization = await Authorization.db.findById(
      session,
      authId,
      include: Authorization.include(
          authorizedPupils: PupilAuthorization.includeList()),
    );
    if (authorization == null) {
      throw Exception('Authorization not found');
    }
    // Delete all the PupilAuthorizations associated with the Authorization
    for (var pupilAuth in authorization.authorizedPupils!) {
      await PupilAuthorization.db.deleteRow(session, pupilAuth);
    }
    // Delete the Authorization itself
    await Authorization.db.deleteRow(session, authorization);

    return true;
  }
}
