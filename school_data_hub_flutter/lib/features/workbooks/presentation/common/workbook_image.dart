import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/create_and_crop_image_file.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:flutter_it/flutter_it.dart';

class WorkbookImage extends WatchingWidget {
  final Workbook workbook;
  const WorkbookImage({super.key, required this.workbook});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final File? file = await createAndCropImageFile(context);
        if (file == null) return;
        // TODO: implement when ready
        di<NotificationService>().showSnackBar(
          NotificationType.warning,
          'Not implemented yet',
        );
        // await di<WorkbookManager>()
        //     .postWorkbookFile(file, workbook.isbn);
      },
      onLongPress: () async {
        final bool? result = await confirmationDialog(
          context: context,
          title: 'Bild löschen',
          message: 'Bild löschen?',
        );
        if (result != true) return;
        // TODO: implement when ready
        di<NotificationService>().showSnackBar(
          NotificationType.warning,
          'Not implemented yet',
        );

        // await di<WorkbookManager>()
        //     .deleteWorkbookFile(workbook.isbn);
      },
      child: UnencryptedImageInCard(
        cacheKey: workbook.isbn.toString(),
        path: workbook.imageUrl,
        size: 75,
      ),
    );
  }
}
