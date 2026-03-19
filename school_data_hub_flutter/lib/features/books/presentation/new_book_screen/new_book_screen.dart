import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_screen/new_book_controller.dart';

class NewBookScreen extends StatelessWidget {
  final NewBookController controller;

  const NewBookScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final hubSessionManager = di<HubSessionManager>();
    return Scaffold(
      appBar: AppHeader(
        iconData: Icons.book,
        title: controller.widget.isEdit ? 'Buch bearbeiten' : 'Neues Buch',
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
                                borderRadius: BorderRadius.circular(Style.radii.medium),
                                child: KeyedSubtree(
                                  key: ValueKey(controller.imagePath),
                                  child: UnencryptedImageInCard(
                                    path: controller.imagePath!,
                                    cacheKey: controller.widget.isbn.toString(),
                                    type: UnencryptedImageType.book,
                                    size: 220,
                                  ),
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
                                Text(
                                  'ISBN:',
                                  style: context.typography.body.bold,
                                ),
                                const Gap(5),
                                Text(controller.widget.isbn.toString()),
                              ],
                            ),
                            const Gap(20),
                            TextField(
                              style: context.typography.body.bold,
                              minLines: 1,
                              maxLines: 1,
                              controller: controller.bookIdTextFieldController,
                              decoration: AppStyles.textFieldDecoration(
                                labelText: 'Bücherei-ID',
                              ),
                            ),
                            const Gap(20),
                            DropdownButtonFormField<ReadingLevel>(
                              decoration: AppStyles.textFieldDecoration(
                                labelText: 'Lesestufe',
                              ),
                              items: controller.readingLevelDropdownItems,
                              initialValue: ReadingLevel.fromString(
                                controller.readingLevel,
                              ),
                              onChanged: (value) => controller
                                  .onChangedReadingLevelDropDown(value),
                            ),
                            const Gap(20),
                            Row(
                              children: [
                                Expanded(
                                  child:
                                      DropdownButtonFormField<
                                        LibraryBookLocation
                                      >(
                                        decoration:
                                            AppStyles.textFieldDecoration(
                                              labelText: 'Ablageort',
                                            ),
                                        items: controller.locationDropdownItems,
                                        initialValue:
                                            controller.lastLocationValue,
                                        onChanged: (value) => controller
                                            .onChangedLocationDropDown(value!),
                                      ),
                                ),
                                if (hubSessionManager.isAdmin) ...[
                                  const Gap(10),
                                  InkWell(
                                    onTap: () => controller.addLocation(),
                                    child: Icon(
                                      Icons.add,
                                      color: style.colors.accent,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  TextField(
                    style: context.typography.body.bold,
                    minLines: 2,
                    maxLines: 2,
                    controller: controller.bookTitleTextFieldController,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Buchtitel',
                    ),
                  ),
                  const Gap(20),
                  TextField(
                    style: context.typography.body.bold,
                    minLines: 1,
                    maxLines: 1,
                    controller: controller.authorTextFieldController,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Author*in',
                    ),
                  ),
                  const Gap(20),
                  TextField(
                    minLines: 3,
                    maxLines: 3,
                    controller: controller.bookDescriptionTextFieldController,
                    style: context.typography.body.bold,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Buchbeschreibung',
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Text(
                        'Buch-Tags:',
                        style: context.typography.body.bold,
                      ),

                      const Gap(10),

                      InkWell(
                        onTap: () => controller.openTagManagement(context),
                        child: Icon(
                          Icons.bookmark_add_rounded,
                          color: style.colors.accent,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
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
                      Button(
                        onPressed: () async => controller.scanBookId(),
                        label: 'BÜCHEREI-ID SCANNEN',
                      ),
                      const Gap(15),
                    ],
                    Button(
                      onPressed: () => controller.submitBook(),
                      label: 'SENDEN',
                    ),
                    const Gap(15),
                    Button(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'ABBRECHEN',
                      variant: ButtonVariant.secondary,
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
