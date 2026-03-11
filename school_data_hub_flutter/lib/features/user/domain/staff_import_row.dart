import 'package:school_data_hub_client/school_data_hub_client.dart';

/// One row from the staff Excel import (Vorname, Nachname, Kürzel, etc.).
class StaffImportRow {
  const StaffImportRow({
    required this.firstName,
    required this.lastName,
    required this.kurzel,
    required this.amtsbezeichnung,
    required this.email,
    required this.pflichtstundenSoll,
    required this.mehrleistungsstunden,
    required this.minderleistungsstunden,
  });

  final String firstName;
  final String lastName;
  final String kurzel;
  final String amtsbezeichnung;
  final String email;
  final int pflichtstundenSoll;
  final int mehrleistungsstunden;
  final int minderleistungsstunden;

  String get fullName => '${firstName.trim()} ${lastName.trim()}'.trim();

  Role get role => roleFromAmtsbezeichnung(amtsbezeichnung);

  /// Minderleistungsstunden map to reliefTimeUnits.
  int get reliefTimeUnits => minderleistungsstunden;

  int get timeUnits => pflichtstundenSoll;

  /// Maps Excel "Amtsbezeichnung" to [Role].
  /// SoPäd -> specialEducator, SoFa -> specialEducatorE, MPT -> specialEducatorK,
  /// L, Wkg, HSU -> teacher, Rektor -> admin; unknown -> notAssigned.
  static Role roleFromAmtsbezeichnung(String value) {
    final v = value.trim();
    if (v.isEmpty) return Role.notAssigned;
    switch (v) {
      case 'SoPäd':
        return Role.specialEducator;
      case 'SoFa':
        return Role.specialEducatorE;
      case 'MPT':
        return Role.specialEducatorK;
      case 'L':
      case 'Wkg':
      case 'HSU':
        return Role.teacher;
      case 'Rektor':
        return Role.admin;
      default:
        return Role.notAssigned;
    }
  }
}
