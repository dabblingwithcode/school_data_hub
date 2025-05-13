import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_pupil_card.dart';

class LibraryBookCard extends StatelessWidget {
  final LibraryBookProxy bookProxy;
  const LibraryBookCard({required this.bookProxy, super.key});
  // List<PupilBookLending> libraryBookPupilBooks(int bookId) {
  //   return BookHelpers.pupilBooksLinkedToBook(libraryId: bookId);
  // }

  @override
  Widget build(BuildContext context) {
    final tileController = CustomExpansionTileController();
    final bookPupilBooks =
        BookHelpers.pupilBooksLinkedToBook(libraryId: bookProxy.libraryId);
    BookBorrowStatus? bookBorrowStatus = bookPupilBooks.isEmpty
        ? null
        : BookHelpers.getBorrowedStatus(bookPupilBooks.first);
    final Color borrowedColor = bookProxy.available
        ? Colors.green
        : bookBorrowStatus == BookBorrowStatus.since2Weeks
            ? Colors.yellow
            : bookBorrowStatus == BookBorrowStatus.since3Weeks
                ? Colors.orange
                : Colors.red;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Buch-ID:'),
            const Gap(10),
            Text(
              bookProxy.libraryId,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Gap(10),
            const Text('Ablageort:'),
            const Gap(10),
            Text(
              bookProxy.location.location,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            CustomExpansionTileSwitch(
              customExpansionTileController: tileController,
              expansionSwitchWidget: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: borrowedColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        CustomExpansionTileContent(
          title: null,
          tileController: tileController,
          widgetList: bookPupilBooks.isEmpty
              ? [
                  const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Keine Ausleihen',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ))
                ]
              : bookPupilBooks.map((pupilBook) {
                  return BookPupilCard(passedPupilBook: pupilBook);
                }).toList(),
        ),
        const Gap(5),
      ],
    );
  }
}
