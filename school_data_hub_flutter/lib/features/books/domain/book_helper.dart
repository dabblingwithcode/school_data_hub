import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

enum BookBorrowStatus { since2Weeks, since3Weeks, since5weeks }

class BookHelpers {
  static List<PupilBookLending> pupilBooksLinkedToBook(
      {required String libraryId}) {
    // returned starting with the most recent
    final pupilBooks = di<PupilManager>()
        .allPupils
        .map((pupil) => pupil.pupilBooks)
        .expand((element) => element as Iterable<PupilBookLending>)
        .where((pupilBook) => pupilBook.libraryBook!.libraryId == libraryId)
        .toList();

    pupilBooks.sort((a, b) => b.lentAt.compareTo(a.lentAt));
    return pupilBooks;
  }

  static BookBorrowStatus getBorrowedStatus(PupilBookLending book) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(book.lentAt);
    if (difference.inDays < 21) {
      return BookBorrowStatus.since2Weeks;
    } else if (difference.inDays < 35) {
      return BookBorrowStatus.since3Weeks;
    } else {
      return BookBorrowStatus.since5weeks;
    }
  }
}
