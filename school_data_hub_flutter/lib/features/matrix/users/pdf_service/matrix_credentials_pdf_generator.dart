import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/matrix_user_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user_relationship.dart';
import 'package:school_data_hub_flutter/features/matrix/users/pdf_service/widgets/matrix_credentials_card.dart';

final _log = Logger('MatrixCredentialsPrinter');

class MatrixCredentialsPrinter {
  static Future<File> printMatrixCredentials({
    required String matrixDomain,
    required MatrixUser matrixUser,
    required String password,
    required bool isStaff,
  }) async {
    final appButton = await rootBundle.load('assets/hermannpost_button.png');
    final keyAsset = await rootBundle.load('assets/key.png');

    final logoImage = pw.MemoryImage(appButton.buffer.asUint8List());
    final keyImage = pw.MemoryImage(keyAsset.buffer.asUint8List());

    final pdf = pw.Document();

    final String matrixId = matrixUser.id!.replaceAll("@", "").split(":").first;

    String qrPassword = password.substring(0, password.length - 4);

    String pin = password.substring(password.length - 4);

    final String domain = matrixDomain.replaceAll("https://", "");
    final String qrCodeData = "$matrixId:$domain*$qrPassword";

    _log.info('QR Code Data: $qrCodeData');

    final String encryptedQrCodeData = customEncrypter
        .encryptAndPackageCredentials(matrixId, qrPassword);

    final qrCredentials = '$domain*$encryptedQrCodeData';

    final userRelationship = MatrixUserHelper.getUserRelationship(matrixUser);

    Future<ByteData> getUserIcon(
      MatrixUserRelationship? userRelationship,
    ) async {
      if (userRelationship != null) {
        if (userRelationship.isTeacher) {
          return await rootBundle.load(
            'assets/images/matrix_icons/teacher.png',
          );
        }
        if (userRelationship.isParent &&
            userRelationship.familyPupils.isNotEmpty) {
          return await rootBundle.load('assets/images/matrix_icons/family.png');
        }
        if (userRelationship.isParent &&
            userRelationship.familyPupils.isEmpty) {
          return await rootBundle.load(
            'assets/images/matrix_icons/parents.png',
          );
        }
      }
      return await rootBundle.load('assets/images/matrix_icons/pupil.png');
    }

    final userIcon = await getUserIcon(userRelationship);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: MatrixCredentialsCard.build(
            userIcon: userIcon,
            logoImage: logoImage,
            keyImage: keyImage,
            matrixUser: matrixUser,
            qrCredentials: qrCredentials,
            pin: pin,
            creationDate: DateTime.now().formatDateForUser(),
            password: password,
            userRelationship: userRelationship,
          ),
        ),
      ),
    );

    final file = File("HP_credentials_${matrixUser.id}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
