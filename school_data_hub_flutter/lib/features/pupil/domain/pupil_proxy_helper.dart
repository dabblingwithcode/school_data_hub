// ? we should move this functions to the pupil manager in future

// TODO: these should be enums

import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

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
}
