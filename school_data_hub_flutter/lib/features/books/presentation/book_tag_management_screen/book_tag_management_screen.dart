import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_screen/book_tag_management_controller.dart';

class BookTagManagementScreen extends StatelessWidget {
  final BookTagManagementController controller;
  final List<BookTag> bookTags;

  const BookTagManagementScreen(
    this.controller, {
    required this.bookTags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        iconData: Icons.bookmark,
        title: 'Schlagwörter verwalten',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verfügbare Schlagwörter',
              style: context.typography.subtitle,
            ),
            const Gap(16),
            Expanded(child: controller.buildBookTags(context, bookTags)),
          ],
        ),
      ),
      bottomNavigationBar: ActionBar(
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
