import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_screen/widgets/book_pupil_card.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_screen/widgets/book_user_card.dart';

class LibraryBookCard extends WatchingWidget {
  final LibraryBookProxy libraryBookProxy;
  const LibraryBookCard({required this.libraryBookProxy, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final tileController = createOnce(() => ExpansionController());
    final bookLendings = BookHelpers.lendingsLinkedToLibraryBook(
      libraryBookId: libraryBookProxy.id,
    );
    BookBorrowStatus? bookBorrowStatus = bookLendings.isEmpty
        ? null
        : BookHelpers.getBorrowedStatus(bookLendings.first);
    final Color borrowedColor = libraryBookProxy.available
        ? style.colors.success
        : bookBorrowStatus == BookBorrowStatus.since2Weeks
        ? style.colors.warning
        : bookBorrowStatus == BookBorrowStatus.since3Weeks
        ? style.colors.warning
        : style.colors.error;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Buch-ID:'),
              const Gap(10),
              Text(
                libraryBookProxy.libraryId,
                overflow: TextOverflow.fade,
                style: context.typography.body.bold,
              ),
              const Gap(10),

              const Spacer(),
              ExpansionHeader(
                expansionController: tileController,
                expansionSwitchWidget: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: borrowedColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Ablageort:'),
              const Gap(10),
              Text(
                libraryBookProxy.location.location,
                overflow: TextOverflow.fade,
                style: context.typography.body.bold,
              ),
            ],
          ),
          ExpansionBody(
            title: null,
            tileController: tileController,
            widgetList: bookLendings.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Keine Ausleihen',
                        style: context.typography.body.bold,
                      ),
                    ),
                  ]
                : bookLendings.map((lending) {
                    if (lending.borrowerType == 'user') {
                      return BookLendingUserCard(lending: lending);
                    }
                    return BookLendingPupilCard(passedPupilBook: lending);
                  }).toList(),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
