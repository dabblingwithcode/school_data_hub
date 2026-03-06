// ? we should move this functions to the pupil manager in future

// TODO: these should be enums

import 'dart:ui';

import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';

class PupilProxyHelper {
  static String preschoolRevisionPredicate(PreSchoolMedical? preSchoolMedical) {
    if (preSchoolMedical == null) {
      return 'nicht vorhanden';
    }
    final value = preSchoolMedical.preschoolMedicalStatus!;
    switch (value) {
      case PreSchoolMedicalStatus.notAvailable:
        return 'nicht vorhanden';
      case PreSchoolMedicalStatus.ok:
        return "unauffällig";
      case PreSchoolMedicalStatus.supportAreas:
        return "Förderbedarf";
      case PreSchoolMedicalStatus.checkSpecialSupport:
        return "AO-SF prüfen";
    }
  }

  static String pickUpValue(String? value) {
    return pickupTimePredicate(value);
  }

  static String pickupTimePredicate(String? value) {
    switch (value) {
      case null:
        return 'k.A.';
      case '0':
        return '14:00';
      case '1':
        return "14:00";
      case '2':
        return "15:00";
      case '3':
        return "16:00";
      default:
        return "Falscher Wert im Server";
    }
  }

  static String communicationPredicate(int? value) {
    switch (value) {
      case null:
        return 'keine Angabe';
      case 0:
        return 'nicht';
      case 1:
        return "einfache Anliegen";
      case 2:
        return "komplexere Informationen";
      case 3:
        return "ohne Probleme";
      case 4:
        return "unbekannt";
      default:
        return "Falscher Wert im Server";
    }
  }

  // TODO: Should these be getters in PupilProxy?

  static bool hasLanguageSupport(DateTime? endOfSupport) {
    if (endOfSupport != null) {
      return endOfSupport.isAfter(DateTime.now().toUtc());
    }
    return false;
  }

  static bool hadLanguageSupport(DateTime? endOfSupport) {
    if (endOfSupport != null) {
      return endOfSupport.isBefore(DateTime.now().toUtc());
    }
    return false;
  }

  static bool hasTurkishLessions(PupilProxy pupil) {
    if (pupil.language.toLowerCase() == "türkisch".toLowerCase() &&
        pupil.familyLanguageLessonsSince != null) {
      return true;
    }
    return false;
  }

  static bool hasArabicLessions(PupilProxy pupil) {
    if ((pupil.language.toLowerCase() == "arabisch".toLowerCase() &&
        pupil.familyLanguageLessonsSince != null)) {
      return true;
    }
    return false;
  }

  static bool hasAlbanianLessions(PupilProxy pupil) {
    if (pupil.language.toLowerCase() == "albanisch".toLowerCase() &&
        pupil.familyLanguageLessonsSince != null) {
      return true;
    }
    return false;
  }

  /// Calculate "Lernjahr Deutsch" (1..4 where 4 means >3).
  /// Returns null if the pupil is not a migration pupil.
  static int? calculateLernjahr(PupilProxy pupil) {
    final migrationEnd = pupil.migrationSupportEnds;
    if (migrationEnd == null) {
      return null;
    }
    final years = DateTime.now().difference(pupil.pupilSince).inDays ~/ 365;
    if (years <= 0) return 1;
    if (years >= 4) return 4; // >3
    return years;
  }

  /// Calculate the "Schulbesuchsjahr" from the pupil's school grade,
  /// adding one extra year if the pupil was held back.
  static int calculateSchulbesuchsjahr(PupilProxy pupil) {
    int base;
    switch (pupil.schoolGrade) {
      case SchoolGrade.E1:
        base = 1;
      case SchoolGrade.E2:
        base = 2;
      case SchoolGrade.E3:
        base = 3;
      case SchoolGrade.K3:
        base = 3;
      case SchoolGrade.K4:
        base = 4;
    }
    if (pupil.schoolyearHeldBackAt != null) base += 1;
    return base;
  }

  static Color migrationSupportEndsColor(DateTime migrationSupportEnds) {
    final currentSchoolSemester =
        di<SchoolCalendarManager>().currentSemester.value!;
    if (migrationSupportEnds.isAfterDate(currentSchoolSemester.endDate)) {
      return const Color.fromARGB(255, 0, 128, 0); // Green
    } else if (migrationSupportEnds.isBeforeDate(
          currentSchoolSemester.endDate,
        ) &&
        migrationSupportEnds.isAfterDate(currentSchoolSemester.startDate)) {
      return const Color.fromARGB(255, 236, 158, 48); // Red
    } else {
      return const Color.fromARGB(255, 103, 103, 103); // Red
    }
  }
}
