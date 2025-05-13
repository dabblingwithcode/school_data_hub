import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_page/new_book_controller.dart';
import 'package:watch_it/watch_it.dart';

final _serverpodSessionManager = di<ServerpodSessionManager>();

class NewBookPage extends StatelessWidget {
  final NewBookController controller;

  const NewBookPage(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: Text(
            (controller.widget.isEdit) ? 'Buch bearbeiten' : 'Neues Buch',
            style: AppStyles.appBarTextStyle,
          ),
        ),
      ),
      body: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      if (controller.imagePath != null) ...<Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child:
                                    // TODO: Repair when image loading is implemented
                                    UnencryptedImageInCard(
                                  path: controller.imagePath!,
                                  cacheKey: controller.widget.isbn.toString(),
                                  size: 220,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                      ],
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'ISBN:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Gap(5),
                                Text(
                                  controller.widget.isbn.toString(),
                                ),
                              ],
                            ),
                            const Gap(20),
                            TextField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              minLines: 1,
                              maxLines: 1,
                              controller: controller.bookIdTextFieldController,
                              decoration: AppStyles.textFieldDecoration(
                                  labelText: 'Bücherei-ID'),
                            ),
                            const Gap(20),
                            DropdownButtonFormField<ReadingLevel>(
                                decoration: AppStyles.textFieldDecoration(
                                    labelText: 'Lesestufe'),
                                items: controller.readingLevelDropdownItems,
                                value: ReadingLevel.fromString(
                                    controller.readingLevel),
                                onChanged: (value) => controller
                                    .onChangedReadingLevelDropDown(value)),
                            const Gap(20),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<
                                      LibraryBookLocation>(
                                    decoration: AppStyles.textFieldDecoration(
                                        labelText: 'Ablageort'),
                                    items: controller.locationDropdownItems,
                                    value: controller.lastLocationValue,
                                    onChanged: (value) => controller
                                        .onChangedLocationDropDown(value!),
                                  ),
                                ),
                                if (_serverpodSessionManager.isAdmin) ...[
                                  const Gap(10),
                                  InkWell(
                                    onTap: () => controller.addLocation(),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.interactiveColor,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
                  TextField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    minLines: 2,
                    maxLines: 2,
                    controller: controller.bookTitleTextFieldController,
                    decoration:
                        AppStyles.textFieldDecoration(labelText: 'Buchtitel'),
                  ),
                  const Gap(20),
                  TextField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    minLines: 1,
                    maxLines: 1,
                    controller: controller.authorTextFieldController,
                    decoration:
                        AppStyles.textFieldDecoration(labelText: 'Author*in'),
                  ),
                  const Gap(20),
                  TextField(
                    minLines: 3,
                    maxLines: 3,
                    controller: controller.bookDescriptionTextFieldController,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    decoration: AppStyles.textFieldDecoration(
                        labelText: 'Buchbeschreibung'),
                  ),
                  const Gap(20),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: controller.bookTagSelection.entries.map((entry) {
                      return ThemedFilterChip(
                        label: entry.key.name,
                        selected: entry.value,
                        onSelected: (bool selected) {
                          controller.switchBookTagSelection(entry.key);
                        },
                      );
                    }).toList(),
                  ),
                  const Gap(30),
                  ...<Widget>[
                    if (!controller.widget.isEdit) ...<Widget>[
                      ElevatedButton(
                        style: AppStyles.actionButtonStyle,
                        onPressed: () async => controller.scanBookId(),
                        child: const Text(
                          'BÜCHEREI-ID SCANNEN',
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                      const Gap(15)
                    ],
                    ElevatedButton(
                      style: AppStyles.successButtonStyle,
                      onPressed: () => controller.submitBook(),
                      child: const Text(
                        'SENDEN',
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                    const Gap(15),
                    ElevatedButton(
                      style: AppStyles.cancelButtonStyle,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ABBRECHEN',
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
