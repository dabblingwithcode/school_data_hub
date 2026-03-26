import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';

class BookLendingUserCard extends StatelessWidget {
  final PupilBookLending lending;
  const BookLendingUserCard({required this.lending, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final userName =
        lending.borrowerUser?.userInfo?.userName ?? 'Unbekannt';

    return CardBox(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, size: 40, color: style.colors.foreground),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: context.typography.subtitle.bold,
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        Text(
                          lending.lentBy,
                          style: context.typography.body.bold,
                        ),
                        const Gap(2),
                        Icon(
                          Icons.arrow_circle_right_rounded,
                          color: style.colors.warning,
                        ),
                        const Gap(2),
                        Text(
                          lending.lentAt.formatDateForUser(),
                          style: context.typography.body.bold,
                        ),
                      ],
                    ),
                    if (lending.returnedAt != null)
                      Row(
                        children: [
                          Text(
                            lending.receivedBy!,
                            style: context.typography.body.bold,
                          ),
                          const Gap(2),
                          Icon(
                            Icons.arrow_circle_left_rounded,
                            color: style.colors.success,
                          ),
                          const Gap(2),
                          Text(
                            lending.returnedAt!.formatDateForUser(),
                            style: context.typography.body.bold,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
