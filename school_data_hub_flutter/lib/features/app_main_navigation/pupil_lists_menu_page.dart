import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/pupil_lists_buttons.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';

class PupilListsMenuPage extends StatelessWidget {
  const PupilListsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      primary: true,
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(iconData: Icons.person, title: locale.pupilLists),

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
              child: const SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: PupilListButtons(),
              ),
            ),
          );
        },
      ),
    );
  }
}
