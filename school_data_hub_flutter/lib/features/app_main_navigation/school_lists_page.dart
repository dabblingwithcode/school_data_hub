import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorizations_list_page/authorizations_list_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_label_pdf_service.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_school_lists/presentation/school_lists_page/school_lists_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/main_menu_button.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class SchoolListsMenuPage extends StatelessWidget {
  const SchoolListsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(
        iconData: Icons.rule_rounded,
        title: locale.checkLists,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = Platform.isWindows
              ? 700.0
              : math.min(600.0, constraints.maxWidth);
          final height = Platform.isWindows
              ? 600.0
              : constraints.maxHeight * 0.9;
          return Center(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    MainMenuButton(
                      destinationPage: const SchoolListsPage(),
                      buttonIcon: Icon(
                        Icons.rule,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: locale.lists,
                    ),
                    MainMenuButton(
                      destinationPage: const AuthorizationsListPage(),
                      buttonIcon: Icon(
                        Icons.fact_check_rounded,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: locale.authorizations,
                    ),
                    MainMenuButton(
                      destinationPage: PdfViewerPage(
                        pdfGenerator: () =>
                            PupilLabelPdfService.generateLabelsPdf(
                          di<PupilProxyManager>().allPupils,
                        ),
                        title: 'Etiketten',
                        iconData: Icons.label_outline,
                        showZoomButton: true,
                      ),
                      buttonIcon: Icon(
                        Icons.label_outline,
                        size: 50,
                        color: AppColors.gridViewColor,
                      ),
                      buttonText: 'Etiketten',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
