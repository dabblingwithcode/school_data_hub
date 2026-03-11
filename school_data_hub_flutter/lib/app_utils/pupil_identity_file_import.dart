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
/// Headers: Interne ID-Nummer, Vorname, Nachname, Klasse, Klassenlehrer, Stv., Jahrgang,
/// Förderschwerpunkt 1, Förderschwerpunkt 2, Geschlecht, Staatsangehörigkeit,
/// Migrationshintergrund vorhanden, Verkehrssprache, Externe ID-Nummer, Geburtsdatum,
/// Ende Eingliederungsphase, Aufnahmedatum, bes.Merkmal, Konfession, Religionsanmeldung,
/// Religionsabmeldung, Ausweisnummer, Übergangsempfehlung, Entlassdatum
class SchildExportColumns {
  SchildExportColumns._();

  static const int id = 0; // Interne ID-Nummer
  static const int firstName = 1; // Vorname
  static const int lastName = 2; // Nachname
  static const int group = 3; // Klasse
  static const int groupTutor = 4; // Klassenlehrer: Krz.
  static const int deputyGroupTutor = 5; // Stv. Klassenlehrer: Krz.
  static const int schoolGrade = 6; // Jahrgang
  static const int specialNeeds1 = 7; // Förderschwerpunkt 1
  static const int specialNeeds2 = 8; // Förderschwerpunkt 2
  static const int gender = 9; // Geschlecht
  static const int nationality = 10; // Staatsangehörigkeit (Schlüssel)
  static const int migrationBackground = 11; // Migrationshintergrund vorhanden
  static const int language = 12; // Verkehrssprache in der Familie
  static const int familyLanguageLessonsSince = 13; // Externe ID-Nummer (hijacked)
  static const int birthday = 14; // Geburtsdatum
  static const int migrationSupportEnds = 15; // Ende der Eingliederungsphase
  static const int pupilSince = 16; // Aufnahmedatum
  static const int religion = 18; // Konfession (Klartext)
  static const int religionLessonsSince = 19; // Religionsanmeldung
  static const int religionLessonsCancelledAt = 20; // Religionsabmeldung
  static const int family = 21; // Ausweisnummer (hijacked for family code)
  static const int schoolTransitionRecommendation = 22; // Übergangsempfehlung
  static const int leavingDate = 23; // Entlassdatum
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

  final migrationBg =
      _parseBoolCell(cellStr(SchildExportColumns.migrationBackground));

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
    cellStr(SchildExportColumns.language),
    migrationBg ? 'true' : 'false',
    cellStr(SchildExportColumns.family),
    _normalizeDateCell(cellStr(SchildExportColumns.birthday), dateFormat),
    _normalizeDateCell(
        cellStr(SchildExportColumns.migrationSupportEnds), dateFormat),
    _normalizeDateCell(cellStr(SchildExportColumns.pupilSince), dateFormat),
    '', // afterSchoolCare -> not in export
    cellStr(SchildExportColumns.religion),
    _normalizeDateCell(
        cellStr(SchildExportColumns.religionLessonsSince), dateFormat),
    _normalizeDateCell(
        cellStr(SchildExportColumns.religionLessonsCancelledAt), dateFormat),
    cellStr(SchildExportColumns.familyLanguageLessonsSince),
    _normalizeDateCell(cellStr(SchildExportColumns.leavingDate), dateFormat),
    cellStr(SchildExportColumns.deputyGroupTutor),
    cellStr(SchildExportColumns.nationality),
    cellStr(SchildExportColumns.schoolTransitionRecommendation),
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

/// Parses a cell string as bool (e.g. "ja", "j", "true", "1", "x" -> true).
bool _parseBoolCell(String raw) {
  final s = raw.trim().toLowerCase();
  if (s.isEmpty) return false;
  if (s == 'true' || s == '1' || s == 'ja' || s == 'j' || s == 'x' || s == 'yes') {
    return true;
  }
  return false;
}

/// Returns a date string (yyyy-MM-dd) or '' if [raw] is not a valid date.
/// Avoids passing non-date values (e.g. category codes like "LE") into date fields.
String _normalizeDateCell(String raw, DateFormat dateFormat) {
  final s = raw.trim();
  if (s.isEmpty) return '';
  final parsed = DateTime.tryParse(s);
  if (parsed != null) return dateFormat.format(parsed);
  try {
    final ddMMyyyy = DateFormat('dd.MM.yyyy').parse(s);
    return dateFormat.format(ddMMyyyy);
  } catch (_) {
    return '';
  }
}
