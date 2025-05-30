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
    return updatedLibraryBookLocation;
  }

  //- delete
  Future<bool> deleteLibraryBookLocation(
      Session session, LibraryBookLocation location) async {
    // Check if the library book location exists

    final deleted = await LibraryBookLocation.db.deleteRow(session, location);
    return true;
  }
}
