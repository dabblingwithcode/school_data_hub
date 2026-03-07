import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';

class BookTagManagementPage extends StatelessWidget {
  final BookTagManagementController controller;
  final List<BookTag> bookTags;

  const BookTagManagementPage(
    this.controller, {
    required this.bookTags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.bookmark,
        title: 'Schlagwörter verwalten',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verfügbare Schlagwörter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(16),
            Expanded(child: controller.buildBookTags(context, bookTags)),
          ],
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Neues Tag erstellen',
            icon: const Icon(Icons.add, size: 35),
            onPressed: () => controller.createNewTag(context),
          ),
        ],
      ),
    );
  }
}
