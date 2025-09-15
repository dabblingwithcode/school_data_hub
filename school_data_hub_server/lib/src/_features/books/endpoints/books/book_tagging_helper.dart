import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class BookTaggingHelper {
  static Future<Book> updateBookWithTags(
      Session session, Book book, List<BookTag> tags,
      {Transaction? transaction}) async {
    await session.db.transaction((transaction) async {
      // 1. Insert or update tags, collect their IDs
      List<BookTag> updatedTags = [];

      for (var tag in tags) {
        if (tag.id == null) {
          updatedTags.add(await BookTag.db
              .insertRow(session, tag, transaction: transaction));
        } else {
          updatedTags.add(await BookTag.db
              .updateRow(session, tag, transaction: transaction));
        }
      }

      // 2. Remove existing taggings for this book
      await BookTagging.db.deleteWhere(
        session,
        where: (t) => t.bookId.equals(book.id),
        transaction: transaction,
      );

      // 4. Insert new taggings
      var newTaggings = updatedTags.map((tag) {
        return BookTagging(
          bookId: book.id!,
          bookTagId: tag.id!,
        );
      }).toList();

      await BookTagging.db
          .insert(session, newTaggings, transaction: transaction);
    });
    // return the updated book
    final updatedBook = await Book.db.findFirstRow(
      session,
      where: (t) => t.id.equals(book.id),
      include: Book.include(tags: BookTagging.includeList()),
    );

    return updatedBook!;
  }
}
