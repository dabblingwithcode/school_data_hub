import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<String?> importStringtromTxtFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: ['txt'],
  );
  if (result != null) {
    File file = File(result.files.single.path!);
    String rawTextResult = await file.readAsString();

    return rawTextResult;
  }
  return null;
}
