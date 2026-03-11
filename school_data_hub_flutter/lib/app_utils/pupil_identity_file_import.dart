import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

/// Picks a .txt or .xlsx file and returns pupil identity content as a single
/// string: newline-separated lines, each line 20 comma-separated fields
/// in the order expected by [decodePupilIdentityFromTextLine].
Future<String?> pickPupilIdentityFileContent() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt', 'xlsx'],
  );
  if (result == null ||
      result.files.isEmpty ||
      result.files.single.path == null) {
    return null;
  }

  final path = result.files.single.path!;
  final extension = path.toLowerCase().endsWith('.xlsx') ? 'xlsx' : 'txt';

  if (extension == 'txt') {
    return await File(path).readAsString();
  }

  final bytes = await File(path).readAsBytes();
  return _xlsxToPupilIdentityLines(bytes);
}

/// SchILD export column indices (0-based). Mapping by position, not header names.
/// Hijacked: Ausweisnummer (14) -> family; Externe ID-Nummer (15) -> familyLanguageLessonsSince.
/// Förderschwerpunkt 1/2 (20, 21) -> specialNeeds columns 6 and 7.
class SchildExportColumns {
  SchildExportColumns._();

  static const int id = 0; // Schulnummer / l.d.A.Schildnummer
  static const int group = 1; // Klasse
  static const int lastName = 2; // Nachname
  static const int firstName = 3; // Vorname
  static const int gender = 5; // Geschlecht
  static const int birthday = 6; // Geburtsdatum
  static const int religion = 8; // Rel.
  static const int family = 14; // Ausweisnummer (hijacked for family code)
  static const int familyLanguageLessonsSince =
      15; // Externe ID-Nummer (hijacked for family language lessons since)
  static const int specialNeeds1 = 20; // Förderschwerpunkt 1
  static const int specialNeeds2 = 21; // Förderschwerpunkt 2
  static const int groupTutor = 31; // Klassenleiter (if present)
  static const int schoolGrade = 29; // Jahrgang (if present)
  static const int pupilSince = 30; // Aufnahmedatum
  static const int leavingDate =
      32; // Datum Abgang (if present; column may vary)
}

String _xlsxToPupilIdentityLines(List<int> bytes) {
  final excel = Excel.decodeBytes(bytes);
  if (excel.tables.isEmpty) return '';

  final table = excel.tables.values.first;
  final rows = table.rows;
  if (rows.isEmpty) return '';

  final lines = <String>[];
  final dateFormat = DateFormat('yyyy-MM-dd');

  for (var rowIndex = 1; rowIndex < rows.length; rowIndex++) {
    final row = rows[rowIndex];
    final line = _rowToCanonicalLine(row, dateFormat, rowIndex);
    if (line != null) lines.add(line);
  }

  return lines.join('\n');
}

String? _rowToCanonicalLine(
  List<Data?> row,
  DateFormat dateFormat,
  int rowIndex,
) {
  String cellStr(int colIndex) {
    if (colIndex >= row.length) return '';
    final data = row[colIndex];
    final v = data?.value;
    if (v == null) return '';
    return _cellValueToCanonicalString(v, dateFormat);
  }

  int? idVal;
  try {
    final s = cellStr(SchildExportColumns.id).trim();
    if (s.isEmpty) return null;
    idVal = int.tryParse(s);
    if (idVal == null) return null;
  } catch (_) {
    return null;
  }

  final schoolGradeStr = cellStr(SchildExportColumns.schoolGrade).trim();
  final grade = schoolGradeStr.isNotEmpty ? schoolGradeStr : 'E1';

  final parts = <String>[
    idVal.toString(),
    cellStr(SchildExportColumns.firstName),
    cellStr(SchildExportColumns.lastName),
    cellStr(SchildExportColumns.group),
    cellStr(SchildExportColumns.groupTutor),
    grade,
    cellStr(SchildExportColumns.specialNeeds1),
    cellStr(SchildExportColumns.specialNeeds2),
    cellStr(SchildExportColumns.gender),
    '', // language - not mapped from template
    cellStr(SchildExportColumns.family),
    _normalizeDateCell(cellStr(SchildExportColumns.birthday), dateFormat),
    '', // migrationSupportEnds
    _normalizeDateCell(cellStr(SchildExportColumns.pupilSince), dateFormat),
    '', // afterSchoolCare -> empty if not in export
    cellStr(SchildExportColumns.religion),
    '', // religionLessonsSince
    '', // religionLessonsCancelledAt
    cellStr(SchildExportColumns.familyLanguageLessonsSince),
    _normalizeDateCell(cellStr(SchildExportColumns.leavingDate), dateFormat),
  ];

  return parts.map((p) => p.replaceAll(',', ' ')).join(',');
}

String _cellValueToCanonicalString(dynamic value, DateFormat dateFormat) {
  if (value == null) return '';
  if (value is TextCellValue) return value.value.toString();
  if (value is IntCellValue) return value.value.toString();
  if (value is DoubleCellValue) {
    final d = value.value;
    if (d == d.roundToDouble()) return d.toInt().toString();
    return d.toString();
  }
  if (value is BoolCellValue) return value.value ? 'true' : 'false';
  if (value is DateCellValue) {
    return dateFormat.format(DateTime(value.year, value.month, value.day));
  }
  if (value is FormulaCellValue) return value.formula.toString();
  return value.toString();
}

String _normalizeDateCell(String raw, DateFormat dateFormat) {
  final s = raw.trim();
  if (s.isEmpty) return '';
  final parsed = DateTime.tryParse(s);
  if (parsed != null) return dateFormat.format(parsed);
  try {
    final ddMMyyyy = DateFormat('dd.MM.yyyy').parse(s);
    return dateFormat.format(ddMMyyyy);
  } catch (_) {
    return s;
  }
}
