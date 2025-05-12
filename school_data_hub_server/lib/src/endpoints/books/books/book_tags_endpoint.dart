import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class BookTagsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  //- create

  Future<BookTag> postBookTag(Session session, BookTag bookTag) async {
    final bookTagInDatabase = await BookTag.db.insertRow(session, bookTag);
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
    return updatedBookTag;
  }
  //- delete

  Future<bool> deleteBookTag(Session session, int id) async {
    // Check if the book tag exists
    final bookTag = await BookTag.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id),
    );
    if (bookTag == null) {
      throw Exception('Book tag with id $id does not exist.');
    }
    final deleted = await BookTag.db.deleteRow(session, bookTag);
    return true;
  }
}
