import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page1.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page2.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page3.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/pdf/pages/pdf_page4.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';

final _log = Logger('LearningSupportPlanPdfGenerator');

class LearningSupportPlanPdfGenerator {
  static Future<File> generateLearningSupportPlanPdf({
    required LearningSupportPlan plan,
    required PupilProxy pupil,
    required List<SupportCategory> supportCategories,
  }) async {
    final regularData = await rootBundle.load(
      'assets/fonts/Roboto-Regular.ttf',
    );
    final boldData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final fontRegular = pw.Font.ttf(regularData);
    final fontBold = pw.Font.ttf(boldData);

    // Load checkbox images for Page 1
    final checkboxData = await rootBundle.load(
      'assets/images/support_categories_icons/checkbox.png',
    );
    final checkboxCheckData = await rootBundle.load(
      'assets/images/support_categories_icons/checkbox_check.png',
    );
    final strengthEmojiData = await rootBundle.load(
      'assets/images/support_categories_icons/strength.png',
    );
    final checkboxImage = pw.MemoryImage(checkboxData.buffer.asUint8List());
    final checkboxCheckImage = pw.MemoryImage(
      checkboxCheckData.buffer.asUint8List(),
    );
    final strengthEmoji = pw.MemoryImage(
      strengthEmojiData.buffer.asUint8List(),
    );

    final schoolData = di<SchoolDataMainManager>().schoolData.value!;
    final pdf = pw.Document();

    di<NotificationManager>().setHeavyLoadingValue(true);

    try {
      // Page 1: Pupil info and plan metadata
      pdf.addPage(
        PdfPage1.build(
          plan: plan,
          pupil: pupil,
          schoolData: schoolData,
          fontRegular: fontRegular,
          fontBold: fontBold,
          checkboxImage: checkboxImage,
          checkboxCheckImage: checkboxCheckImage,
          strengthImage: strengthEmoji,
        ),
      );

      // Page 2: Support category status grid
      pdf.addPage(
        await PdfPage2.build(
          plan: plan,
          pupil: pupil,
          supportCategories: supportCategories,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );

      // Page 3: Goals detail table
      pdf.addPage(
        PdfPage3.build(
          plan: plan,
          pupil: pupil,
          supportCategories: supportCategories,
          fontRegular: fontRegular,
          fontBold: fontBold,
        ),
      );

      // Page 4: Notes and signatures
      pdf.addPage(
        PdfPage4.build(
          checkboxCheckImage: checkboxCheckImage,
          checkboxImage: checkboxImage,
          plan: plan,
          pupil: pupil,
          fontRegular: fontRegular,
          fontBold: fontBold,
          location: schoolData.city!,
        ),
      );
    } finally {
      di<NotificationManager>().setHeavyLoadingValue(false);
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "Förderplan_${pupil.firstName}_${pupil.lastName}_${DateTime.now().formatDateForUser()}.pdf";
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    _log.info('Learning Support Plan PDF generated: ${file.path}');
    return file;
  }
}
