import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/isbn_extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tag.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:flutter_it/flutter_it.dart';

class BookHeader extends WatchingWidget {
  final LibraryBookProxy bookProxy;
  const BookHeader({required this.bookProxy, super.key});

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.typography.body.bold),
          const Gap(8),
          Expanded(child: Text(value, style: context.typography.body)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return CardBox(
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bookProxy.title,
            style: context.typography.title,
          ),
          Text(
            bookProxy.author,
            style: context.typography.body.muted(context),
          ),
          const Gap(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UnencryptedImageInCard(
                cacheKey: bookProxy.isbn.toString(),
                path: bookProxy.imagePath,
                type: UnencryptedImageType.book,
                size: 120,
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(context, 'ISBN:', bookProxy.isbn.displayAsIsbn()),
                    _buildInfoRow(
                      context,
                      'LeseStufe:',
                      bookProxy.readingLevel ?? ReadingLevel.notSet.value,
                    ),
                    _buildInfoRow(context, 'Ort:', bookProxy.location.location),
                    const Gap(5),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        Text('Tags: ', style: context.typography.body),
                        if (bookProxy.bookTags.isEmpty)
                          Text(
                            'Keine Tags',
                            style: context.typography.bodySmall.copyWith(
                              color: style.colors.mutedForeground,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        else
                          for (final tag in bookProxy.bookTags)
                            Tag(
                              label: tag.name,
                              color: style.colors.accent,
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
