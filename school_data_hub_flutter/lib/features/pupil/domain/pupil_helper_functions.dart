// ? we should move this functions to the pupil manager in future

// TODO: these should be enums

class PupilHelper {
  static String preschoolRevisionPredicate(int value) {
    switch (value) {
      case 0:
        return 'nicht vorhanden';
      case 1:
        return "unauffällig";
      case 2:
        return "Förderbedarf";
      case 3:
        return "AO-SF prüfen";
      default:
        return "Falscher Wert im Server";
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

  static String communicationPredicate(String? value) {
    switch (value) {
      case null:
        return 'keine Angabe';
      case '0':
        return 'nicht';
      case '1':
        return "einfache Anliegen";
      case '2':
        return "komplexere Informationen";
      case '3':
        return "ohne Probleme";
      case '4':
        return "unbekannt";
      default:
        return "Falscher Wert im Server";
    }
  }

// TODO: Should these be getters in PupilProxy?

  static bool hasLanguageSupport(DateTime? endOfSupport) {
    if (endOfSupport != null) {
      return endOfSupport.isAfter(DateTime.now());
    }
    return false;
  }

  static bool hadLanguageSupport(DateTime? endOfSupport) {
    if (endOfSupport != null) {
      return endOfSupport.isBefore(DateTime.now());
    }
    return false;
  }
}
