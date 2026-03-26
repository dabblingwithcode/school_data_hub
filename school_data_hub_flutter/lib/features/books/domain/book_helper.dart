import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_proxy_books_ext.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';

enum BookBorrowStatus { since2Weeks, since3Weeks, since5weeks }

class BookHelpers {
  static int totalPupilBookLendings() {
    return di<PupilBookLendingManager>().allPupilBookLendings.length;
  }

  static int totalOpenPupilBookLendings() {
    return di<PupilBookLendingManager>().allPupilBookLendings
        .where((lending) => lending.returnedAt == null)
        .length;
  }

  static List<PupilBookLending> lendingsLinkedToLibraryBook({
    required int libraryBookId,
  }) {
    final lendingManager = di<PupilBookLendingManager>();

    final linked = lendingManager.allLendings
        .where((lending) => lending.libraryBookId == libraryBookId)
        .toList()
      ..sort((a, b) => b.lentAt.compareTo(a.lentAt));

    return linked;
  }

  @Deprecated('Use lendingsLinkedToLibraryBook instead')
  static List<PupilBookLending> pupilBookLendingsLinkedToLibraryBook({
    required int libraryBookId,
  }) {
    return lendingsLinkedToLibraryBook(libraryBookId: libraryBookId);
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
