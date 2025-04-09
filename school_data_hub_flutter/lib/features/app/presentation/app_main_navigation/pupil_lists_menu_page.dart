import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_data_hub_flutter/features/app/presentation/app_main_navigation/widgets/pupil_lists_buttons.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class PupilListsMenuPage extends StatelessWidget {
  const PupilListsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      primary: true,
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundColor,
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          locale.pupilLists,
          style: AppStyles.appBarTextStyle,
          textAlign: TextAlign.end,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: Platform.isWindows ? 700 : 600,
          height: Platform.isWindows
              ? 600
              : MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: PupilListButtons(
              screenWidth: screenWidth,
            ),
          ),
        ),
      ),
    );
  }
}
