import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/app_helpers.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:school_data_hub_flutter/l10n/app_localizations.dart';
import 'package:flutter_it/flutter_it.dart';

class EntryPointScreen extends WatchingWidget {
  final EntryPointController controller;
  const EntryPointScreen({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final style = Style.of(context);
    return Scaffold(
      backgroundColor: style.colors.canvas,
      resizeToAvoidBottomInset: true,
      body: Container(
        color: style.colors.accent,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: Platform.isWindows
                      ? const EdgeInsets.only(top: 0)
                      : const EdgeInsets.only(top: 0),
                ),
                const SizedBox(
                  height: 250,
                  width: 250,
                  child: Image(
                    image: AssetImage('assets/foreground_windows.png'),
                  ),
                ),
                const Gap(20),
                Text(
                  locale.schoolDataHub,
                  style: context.typography.title.withColor(
                    style.colors.background,
                  ).copyWith(fontSize: 30),
                ),
                const Gap(10),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.all(Style.spacing.lg),
                  child: Center(
                    child: Platform.isWindows
                        ? Text(
                            locale.importSchoolDataToContinue,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: context.typography.title.withColor(
                              style.colors.background,
                            ),
                          )
                        : Text(
                            locale.scanSchoolIdToContinue,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: context.typography.title.withColor(
                              style.colors.background,
                            ),
                          ),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Style.spacing.md,
                  ),
                  child: Button(
                    label: 'SCHULSCHLÜSSEL ERSTELLEN',
                    onPressed: () async {
                      AppHelpers.generateSchoolKeys(context);
                    },
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Style.spacing.md,
                  ),
                  child: Button(
                    label: Platform.isWindows || Platform.isMacOS
                        ? 'SCHULSCHLÜSSEL IMPORTIEREN'
                        : locale.scanButton,
                    onPressed: () {
                      Platform.isWindows || Platform.isMacOS
                          ? controller.importEnvFromTxtFile()
                          : controller.importEnvDataFromQrCode(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
