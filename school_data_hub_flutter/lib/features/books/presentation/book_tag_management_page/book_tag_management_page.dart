import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';

class BookTagManagementPage extends StatelessWidget {
  final BookTagManagementController controller;

  const BookTagManagementPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Center(
          child: Text('Buch-Tags verwalten', style: AppStyles.appBarTextStyle),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.createNewTag(context),
            icon: const Icon(Icons.add, color: AppColors.interactiveColor),
          ),
        ],
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
    );
  }
}
