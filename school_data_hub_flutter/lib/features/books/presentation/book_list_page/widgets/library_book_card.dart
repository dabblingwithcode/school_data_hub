import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/widgets/book_pupil_card.dart';

class LibraryBookCard extends StatelessWidget {
  final LibraryBookProxy libraryBookProxy;
  const LibraryBookCard({required this.libraryBookProxy, super.key});

  @override
  Widget build(BuildContext context) {
    final tileController = CustomExpansionTileController();
    final bookPupilLendings = BookHelpers.pupilBookLendingsLinkedToLibraryBook(
      libraryBookId: libraryBookProxy.id,
    );
    BookBorrowStatus? bookBorrowStatus =
        bookPupilLendings.isEmpty
            ? null
            : BookHelpers.getBorrowedStatus(bookPupilLendings.first);
    final Color borrowedColor =
        libraryBookProxy.available
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
              libraryBookProxy.libraryId,
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
              libraryBookProxy.location.location,
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
          widgetList:
              bookPupilLendings.isEmpty
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
                      ),
                    ),
                  ]
                  : bookPupilLendings.map((pupilBook) {
                    return BookLendingPupilCard(passedPupilBook: pupilBook);
                  }).toList(),
        ),
        const Gap(5),
      ],
    );
  }
}
