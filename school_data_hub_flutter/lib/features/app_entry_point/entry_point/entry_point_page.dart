import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/app_utils/app_helpers.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:watch_it/watch_it.dart';

class EntryPointPage extends WatchingWidget {
  final EntryPointController controller;
  const EntryPointPage({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: AppColors.backgroundColor,
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
                        : const EdgeInsets.only(top: 0)),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Gap(10),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Platform.isWindows
                        ? Text(
                            locale.importSchoolDataToContinue,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                        : Text(
                            locale.scanSchoolIdToContinue,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    //margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                        style: AppStyles.actionButtonStyle,
                        onPressed: () async {
                          AppHelpers.generateSchoolKeys(context);
                        },
                        child: const Text('SCHULSCHLÜSSEL ERSTELLEN',
                            textAlign: TextAlign.center,
                            style: AppStyles.buttonTextStyle)),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    //margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                        style: AppStyles.actionButtonStyle,
                        onPressed: () {
                          Platform.isWindows || Platform.isMacOS
                              ? controller.importEnvFromTxt()
                              : controller.scanEnv(context);
                        },
                        child: Platform.isWindows || Platform.isMacOS
                            ? const Text('SCHULSCHLÜSSEL IMPORTIEREN',
                                style: AppStyles.buttonTextStyle)
                            : Text(
                                locale.scanButton,
                                style: AppStyles.buttonTextStyle,
                              )),
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
