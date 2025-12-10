import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:watch_it/watch_it.dart';

enum BookBorrowStatus { since2Weeks, since3Weeks, since5weeks }

class BookHelpers {
  static List<PupilBookLending> pupilBookLendingsLinkedToLibraryBook({
    required int libraryBookId,
  }) {
    // Get all pupil book lendings
    final allPupilBookLendings = di<PupilProxyManager>().allPupils
        .map((pupil) => pupil.pupilBookLendings ?? <PupilBookLending>[])
        .expand((element) => element)
        .toList();

    // Filter by libraryId
    final pupilBookLendingsLinkedToLibraryBook = allPupilBookLendings.where((
      pupilBook,
    ) {
      final match = pupilBook.libraryBookId == libraryBookId;

      return match;
    }).toList();

    pupilBookLendingsLinkedToLibraryBook.sort(
      (a, b) => b.lentAt.compareTo(a.lentAt),
    );
    return pupilBookLendingsLinkedToLibraryBook;
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
