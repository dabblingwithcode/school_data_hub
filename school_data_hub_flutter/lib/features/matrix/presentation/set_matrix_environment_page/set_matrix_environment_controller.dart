import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/models/matrix_credentials.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/set_matrix_environment_page/set_matrix_environment_page.dart';
import 'package:watch_it/watch_it.dart';

class SetMatrixEnvironment extends StatefulWidget {
  const SetMatrixEnvironment({super.key});

  @override
  State<SetMatrixEnvironment> createState() => SetMatrixEnvironmentController();
}

class SetMatrixEnvironmentController extends State<SetMatrixEnvironment> {
  final TextEditingController urlTextFieldController = TextEditingController();
  final TextEditingController matrixTokenTextFieldController =
      TextEditingController();
  final TextEditingController policyTokenTextFieldController =
      TextEditingController();
  final TextEditingController matrixAdminTextFieldController =
      TextEditingController();
  final TextEditingController encryptionKeyTextFieldController =
      TextEditingController();
  final TextEditingController encryptionIvTextFieldController =
      TextEditingController();
  Set<String> roomIds = {};
  //Set<int> pupilIds = {};
  void setMatrixEnvironment() async {
    String url = 'https://${urlTextFieldController.text}';
    String matrixToken = matrixTokenTextFieldController.text;
    String policyToken = policyTokenTextFieldController.text;
    final credentials = MatrixCredentials(
      url: url,
      matrixToken: matrixToken,
      policyToken: policyToken,
      matrixAdmin: matrixAdminTextFieldController.text,
      encryptionKey: encryptionKeyTextFieldController.text,
      encryptionIv: encryptionIvTextFieldController.text,
    );
    if (!di.isRegistered<MatrixPolicyManager>()) {
      await MatrixPolicyHelper.registerMatrixPolicyManager(
        passedCredentials: credentials,
      );
    }

    await di.allReady();
  }

  @override
  Widget build(BuildContext context) {
    return SetupMatrixEnvironmentPage(this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    urlTextFieldController.dispose();
    matrixTokenTextFieldController.dispose();
    policyTokenTextFieldController.dispose();
    matrixAdminTextFieldController.dispose();
    encryptionKeyTextFieldController.dispose();
    encryptionIvTextFieldController.dispose();
    super.dispose();
  }
}
