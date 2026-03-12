import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';

class WorkbookImage extends WatchingWidget {
  final Workbook workbook;
  const WorkbookImage({super.key, required this.workbook});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final File? file = await createAndCropImageFile(context);
        if (file == null) return;
        await di<WorkbookManager>().postWorkbookFile(file, workbook.isbn);
      },
      onLongPress: () async {
        final bool? result = await confirmationDialog(
          context: context,
          title: 'Bild löschen',
          message: 'Bild löschen?',
        );
        if (result != true) return;
        await di<WorkbookManager>().deleteWorkbookFile(workbook.isbn);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: UnencryptedImageInCard(
          cacheKey: workbook.isbn.toString(),
          path: workbook.imageUrl,
          size: 75,
        ),
      ),
    );
  }
}
