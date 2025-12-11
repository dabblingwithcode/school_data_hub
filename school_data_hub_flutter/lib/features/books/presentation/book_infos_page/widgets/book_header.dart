import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/isbn_extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:watch_it/watch_it.dart';

class BookHeader extends WatchingWidget {
  final LibraryBookProxy bookProxy;
  const BookHeader({required this.bookProxy, super.key});

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Gap(8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookProxy.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              bookProxy.author,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Gap(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnencryptedImageInCard(
                  cacheKey: bookProxy.isbn.toString(),
                  path: bookProxy.imagePath,
                  size: 120,
                ),
                const Gap(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('ISBN:', bookProxy.isbn.displayAsIsbn()),
                      _buildInfoRow(
                        'LeseStufe:',
                        bookProxy.readingLevel ?? ReadingLevel.notSet.value,
                      ),
                      _buildInfoRow('Ort:', bookProxy.location.location),
                      const Gap(5),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          const Text('Tags: '),
                          if (bookProxy.bookTags.isEmpty)
                            const Text(
                              'Keine Tags',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          else
                            for (final tag in bookProxy.bookTags)
                              Chip(
                                label: Text(
                                  tag.name,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: AppColors.interactiveColor,
                                padding: EdgeInsets.zero,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
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
      ),
    );
  }
}
