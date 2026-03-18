import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class BookTagsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<BookTag> postBookTag(Session session, BookTag bookTag) async {
    final bookTagInDatabase = await BookTag.db.insertRow(session, bookTag);
    session.messages.postMessage('hub_events_stream', bookTagInDatabase);
    HubUpdatesTracker.instance.touch(HubObjectType.libraryBook);
    return bookTagInDatabase;
  }

  //- read
  Future<List<BookTag>> fetchBookTags(Session session) async {
    final tags = await BookTag.db.find(
      session,
    );
    return tags;
  }

  //- update

  Future<BookTag> updateBookTag(Session session, BookTag bookTag) async {
    final updatedBookTag = await BookTag.db.updateRow(session, bookTag);
    session.messages.postMessage('hub_events_stream', updatedBookTag);
    HubUpdatesTracker.instance.touch(HubObjectType.libraryBook);
    return updatedBookTag;
  }
  //- delete

  Future<bool> deleteBookTag(Session session, BookTag bookTag) async {
    await BookTag.db.deleteRow(session, bookTag);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(objectType: HubObjectType.libraryBook, id: bookTag.id!),
    );
    HubUpdatesTracker.instance.touch(HubObjectType.libraryBook);
    return true;
  }
}
