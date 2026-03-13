import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
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
    return await session.db.transaction((transaction) async {
      final authorizationInDatabase = await Authorization.db.insertRow(
        session,
        authorization,
        transaction: transaction,
      );
      final List<PupilAuthorization> pupilAuths = pupilIds.map((pupilId) {
        return PupilAuthorization(
          pupilId: pupilId,
          authorizationId: authorizationInDatabase.id!,
        );
      }).toList();

      var createdPupilAuths = await PupilAuthorization.db.insert(
        session,
        pupilAuths,
        transaction: transaction,
      );
      // Attach all the PupilAuthorizations to the Authorization
      await Authorization.db.attach.authorizedPupils(
        session,
        authorizationInDatabase,
        createdPupilAuths,
        transaction: transaction,
      );
      // recall the authorization with the pupil authorizations
      final authorizationWithPupils = await Authorization.db.findById(
        session,
        authorizationInDatabase.id!,
        include: Authorization.include(
            authorizedPupils: PupilAuthorization.includeList()),
        transaction: transaction,
      );
      final result = authorizationWithPupils!;
      session.messages.postMessage('hub_events_stream', result);
      HubUpdatesTracker.instance.touch(HubObjectType.authorization);
      return result;
    });
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
    return await session.db.transaction((transaction) async {
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
            transaction: transaction,
          );
          // Attach all the PupilAuthorizations to the Authorization
          await Authorization.db.attach.authorizedPupils(
            session,
            authorization,
            createdPupilAuths,
            transaction: transaction,
          );
        } else if (updateMembers.operation == MemberOperation.remove) {
          // Remove the PupilAuthorizations from the Authorization
          for (var pupilId in updateMembers.pupilIds) {
            final pupilAuth = await PupilAuthorization.db.findFirstRow(
              session,
              where: (t) =>
                  t.pupilId.equals(pupilId) &
                  t.authorizationId.equals(authorization.id!),
              transaction: transaction,
            );
            if (pupilAuth != null) {
              await PupilAuthorization.db
                  .deleteRow(session, pupilAuth, transaction: transaction);
            }
          }
        }
      }
      await Authorization.db
          .updateRow(session, authorization, transaction: transaction);

      final updatedAuthorization = await Authorization.db.findById(
        session,
        authorization.id!,
        include: authInclude,
        transaction: transaction,
      );
      final result = updatedAuthorization!;
      session.messages.postMessage('hub_events_stream', result);
      HubUpdatesTracker.instance.touch(HubObjectType.authorization);
      return result;
    });
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
    await session.db.transaction((transaction) async {
      // Delete all the PupilAuthorizations associated with the Authorization
      for (var pupilAuth in authorization.authorizedPupils!) {
        await PupilAuthorization.db
            .deleteRow(session, pupilAuth, transaction: transaction);
      }
      // Delete the Authorization itself
      await Authorization.db
          .deleteRow(session, authorization, transaction: transaction);
    });
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(objectType: HubObjectType.authorization, id: authId),
    );
    return true;
  }
}
