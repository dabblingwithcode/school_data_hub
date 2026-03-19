import 'package:flutter/widgets.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';

class WorkbookImage extends WatchingWidget {
  final Workbook workbook;
  const WorkbookImage({super.key, required this.workbook});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.xs),
      child: UnencryptedImageInCard(
        cacheKey: workbook.isbn.toString(),
        path: workbook.imageUrl,
        type: UnencryptedImageType.workbook,
        size: 75,
      ),
    );
  }
}
