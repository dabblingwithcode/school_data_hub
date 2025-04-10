import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/app_utils/import_string_from_txt_file.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/set_matrix_environment_page/set_matrix_environment_controller.dart';

class SetupMatrixEnvironmentPage extends StatelessWidget {
  final SetMatrixEnvironmentController viewModel;
  const SetupMatrixEnvironmentPage(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 25,
              color: Colors.white,
            ),
            Gap(10),
            Text(
              'Matrix-Umgebung einrichten',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Add this
                  children: <Widget>[
                    const Text(
                      'Matrix-URL:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    const Text('https://', style: TextStyle(fontSize: 16)),
                    const Gap(5),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        controller: viewModel.urlTextFieldController,
                        decoration: AppStyles.textFieldDecoration(
                            labelText: 'Matrix-URL'),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: viewModel.matrixTokenTextFieldController,
                  decoration: AppStyles.textFieldDecoration(
                      labelText: 'Matrix-Admin Token'),
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: viewModel.policyTokenTextFieldController,
                  decoration: AppStyles.textFieldDecoration(
                      labelText: 'Matrix-Corporal Token'),
                ),
                const Spacer(),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () async {
                    viewModel.setMatrixEnvironment();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SENDEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () async {
                    String? scanResult;
                    if (Platform.isAndroid || Platform.isIOS) {
                      scanResult = await qrScanner(
                          context: context,
                          overlayText: 'Matrix Zugangsdaten scannen');
                    }
                    if (Platform.isWindows ||
                        Platform.isLinux ||
                        Platform.isMacOS) {
                      scanResult = await importStringtromTxtFile();
                    }
                    if (scanResult != null) {
                      final matrixCredentialsMap = jsonDecode(scanResult);

                      // final MatrixCredentials matrixCredentials =
                      //     MatrixCredentials.fromJson(matrixCredentialsMap);
                      viewModel.urlTextFieldController.text =
                          matrixCredentialsMap['url'];

                      viewModel.matrixTokenTextFieldController.text =
                          matrixCredentialsMap['matrixToken'];

                      viewModel.policyTokenTextFieldController.text =
                          matrixCredentialsMap['policyToken'];

                      viewModel.setMatrixEnvironment();

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    (Platform.isAndroid || Platform.isIOS)
                        ? 'SCANNEN'
                        : 'IMPORT AUS DATEI',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
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
