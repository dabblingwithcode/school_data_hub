import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/widgets/book_tag_management_bottom_nav_bar.dart';

class BookTagManagementPage extends StatelessWidget {
  final BookTagManagementController controller;

  const BookTagManagementPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.label,
        title: 'Buch-Tags verwalten',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verfügbare Buch-Tags',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(16),
            Expanded(child: controller.watchBookTags(context)),
          ],
        ),
      ),
      bottomNavigationBar: BookTagManagementBottomNavBar(
        onAddPressed: () => controller.createNewTag(context),
      ),
    );
  }
}
