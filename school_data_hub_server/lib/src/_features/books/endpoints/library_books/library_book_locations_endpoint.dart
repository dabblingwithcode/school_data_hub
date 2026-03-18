import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class LibraryBookLocationsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<LibraryBookLocation> postLibraryBookLocation(
      Session session, LibraryBookLocation libraryBookLocation) async {
    final libraryBookLocationInDatabase =
        await LibraryBookLocation.db.insertRow(session, libraryBookLocation);
    session.messages.postMessage('hub_events_stream', libraryBookLocationInDatabase);
    HubUpdatesTracker.instance.touch(HubObjectType.libraryBook);
    return libraryBookLocationInDatabase;
  }

  //- read
  Future<List<LibraryBookLocation>> fetchLibraryBookLocations(
      Session session) async {
    final libraryBookLocations = await LibraryBookLocation.db.find(
      session,
    );
    return libraryBookLocations;
  }

  //-update
  Future<LibraryBookLocation> updateLibraryBookLocation(
      Session session, LibraryBookLocation libraryBookLocation) async {
    final updatedLibraryBookLocation =
        await LibraryBookLocation.db.updateRow(session, libraryBookLocation);
    session.messages.postMessage('hub_events_stream', updatedLibraryBookLocation);
    HubUpdatesTracker.instance.touch(HubObjectType.libraryBook);
    return updatedLibraryBookLocation;
  }

  //- delete
  Future<bool> deleteLibraryBookLocation(
      Session session, LibraryBookLocation location) async {
    // Check if the library book location exists

    await LibraryBookLocation.db.deleteRow(session, location);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(objectType: HubObjectType.libraryBook, id: location.id!),
    );
    HubUpdatesTracker.instance.touch(HubObjectType.libraryBook);
    return true;
  }
}
