import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<String?> fromTextFilePickerToString() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
  );
  if (result != null) {
    File file = File(result.files.single.path!);
    return await file.readAsString();
  } else {
    // User canceled the picker
    return null;
  }
}
