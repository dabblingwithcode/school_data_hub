import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:school_data_hub_flutter/features/user/domain/staff_import_row.dart';

/// Result of parsing the staff Excel file.
class StaffImportParseResult {
  const StaffImportParseResult({
    required this.rows,
    required this.errors,
  });

  final List<StaffImportRow> rows;
  final List<String> errors;

  bool get hasErrors => errors.isNotEmpty;
}

/// Expected header names (Excel column titles).
class _Headers {
  static const vorname = 'Vorname';
  static const nachname = 'Nachname';
  static const kurzel = 'Kürzel';
  static const amtsbezeichnung = 'Amtsbezeichnung';
  static const email = 'E-Mail (Dienstlich)';
  static const pflichtstundenSoll = 'Pflichtstunden-Soll';
  static const mehrleistungsstunden = 'Mehrleistungsstunden';
  static const minderleistungsstunden = 'Minderleistungsstunden';
}

/// Picks an .xlsx file and parses it into [StaffImportRow] list.
class StaffExcelImportParser {
  StaffExcelImportParser._();

  /// Returns null if user cancels or no file selected.
  static Future<StaffImportParseResult?> pickAndParse() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result == null ||
        result.files.isEmpty ||
        result.files.single.path == null) {
      return null;
    }
    final path = result.files.single.path!;
    final bytes = await File(path).readAsBytes();
    return parseBytes(bytes);
  }

  /// Parses Excel bytes. First row = headers; data rows follow.
  static StaffImportParseResult parseBytes(List<int> bytes) {
    final errors = <String>[];
    final rows = <StaffImportRow>[];

    Excel excel;
    try {
      excel = Excel.decodeBytes(bytes);
    } catch (e) {
      errors.add('Datei konnte nicht gelesen werden: $e');
      return StaffImportParseResult(rows: rows, errors: errors);
    }

    if (excel.tables.isEmpty) {
      errors.add('Keine Tabelle in der Datei gefunden.');
      return StaffImportParseResult(rows: rows, errors: errors);
    }

    final table = excel.tables.values.first;
    final tableRows = table.rows;
    if (tableRows.length < 2) {
      errors.add('Keine Datenzeilen (nur Kopfzeile oder leer).');
      return StaffImportParseResult(rows: rows, errors: errors);
    }

    final headerRow = tableRows[0];
    final colIndex = <String, int>{};
    for (var i = 0; i < headerRow.length; i++) {
      final s = _cellToString(headerRow[i]).trim();
      if (s.isNotEmpty) colIndex[s] = i;
    }

    final vornameCol = colIndex[_Headers.vorname];
    final nachnameCol = colIndex[_Headers.nachname];
    final kurzelCol = colIndex[_Headers.kurzel];
    final amtsbezeichnungCol = colIndex[_Headers.amtsbezeichnung];
    final emailCol = colIndex[_Headers.email];
    final pflichtCol = colIndex[_Headers.pflichtstundenSoll];
    final mehrCol = colIndex[_Headers.mehrleistungsstunden];
    final minderCol = colIndex[_Headers.minderleistungsstunden];

    if (vornameCol == null ||
        nachnameCol == null ||
        kurzelCol == null ||
        amtsbezeichnungCol == null ||
        emailCol == null ||
        pflichtCol == null ||
        mehrCol == null ||
        minderCol == null) {
      final missing = <String>[];
      if (vornameCol == null) missing.add(_Headers.vorname);
      if (nachnameCol == null) missing.add(_Headers.nachname);
      if (kurzelCol == null) missing.add(_Headers.kurzel);
      if (amtsbezeichnungCol == null) missing.add(_Headers.amtsbezeichnung);
      if (emailCol == null) missing.add(_Headers.email);
      if (pflichtCol == null) missing.add(_Headers.pflichtstundenSoll);
      if (mehrCol == null) missing.add(_Headers.mehrleistungsstunden);
      if (minderCol == null) missing.add(_Headers.minderleistungsstunden);
      errors.add('Fehlende Spalten: ${missing.join(", ")}');
      return StaffImportParseResult(rows: rows, errors: errors);
    }

    for (var rowIndex = 1; rowIndex < tableRows.length; rowIndex++) {
      final row = tableRows[rowIndex];
      String cell(int? col) {
        if (col == null || col >= row.length) return '';
        return _cellToString(row[col]).trim();
      }

      final kurzel = cell(kurzelCol);
      if (kurzel.isEmpty) {
        errors.add('Zeile ${rowIndex + 1}: Kürzel ist leer – übersprungen.');
        continue;
      }

      final timeUnits = _parseInt(cell(pflichtCol), 0);
      final mehr = _parseInt(cell(mehrCol), 0);
      final minder = _parseInt(cell(minderCol), 0);

      rows.add(StaffImportRow(
        firstName: cell(vornameCol),
        lastName: cell(nachnameCol),
        kurzel: kurzel,
        amtsbezeichnung: cell(amtsbezeichnungCol),
        email: cell(emailCol),
        pflichtstundenSoll: timeUnits,
        mehrleistungsstunden: mehr,
        minderleistungsstunden: minder,
      ));
    }

    return StaffImportParseResult(rows: rows, errors: errors);
  }
}

String _cellToString(Data? data) {
  if (data == null) return '';
  final v = data.value;
  if (v == null) return '';
  if (v is TextCellValue) return v.value.toString();
  if (v is IntCellValue) return v.value.toString();
  if (v is DoubleCellValue) return v.value.toString();
  if (v is BoolCellValue) return v.value ? '1' : '0';
  if (v is DateCellValue) return '${v.year}-${v.month}-${v.day}';
  if (v is FormulaCellValue) return v.formula;
  return v.toString();
}

int _parseInt(String s, int fallback) {
  if (s.isEmpty) return fallback;
  final n = int.tryParse(s);
  return n ?? fallback;
}
