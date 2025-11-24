import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/statistics_page.dart';
import 'package:watch_it/watch_it.dart';

class Statistics extends WatchingStatefulWidget {
  const Statistics({super.key});

  @override
  StatisticsController createState() => StatisticsController();
}

class StatisticsController extends State<Statistics> {
  final List<PupilProxy> pupils = di<PupilManager>().allPupils;
  Map<String, int> languageOccurrences = {};
  Map<String, DateTime> enrollments = {};
  @override
  void initState() {
    calculateLanguageOccurrences();

    super.initState();
  }

  calculateLanguageOccurrences() {
    for (PupilProxy pupil in pupils) {
      languageOccurrences[pupil.language] =
          (languageOccurrences[pupil.language] ?? 0) + 1;
    }
  }

  List<PupilProxy> pupilsNotSpeakingGerman(List<PupilProxy> givenPupils) {
    return givenPupils.where((pupil) => pupil.language != 'Deutsch').toList();
  }

  List<PupilProxy> pupilsNotEnrolledOnDate(List<PupilProxy> givenPupils) {
    return givenPupils.where((pupil) {
      return !(pupil.pupilSince.month == 8 && pupil.pupilSince.day == 1);
    }).toList();
  }

  List<PupilProxy> pupilsEnrolledAfterDate(DateTime date) {
    return pupils.where((pupil) => pupil.pupilSince.isAfter(date)).toList();
  }

  List<PupilProxy> pupilsEnrolledBetweenDates(
    DateTime startDate,
    DateTime endDate,
  ) {
    return pupils
        .where(
          (pupil) =>
              pupil.pupilSince.isAfter(startDate) &&
              pupil.pupilSince.isBefore(endDate),
        )
        .toList();
  }

  List<PupilProxy> pupilsInaGivenGroup(String group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.group == group) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> pupilsInOGS(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      if (pupil.afterSchoolCare != null) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> malePupils(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      if (pupil.gender == 'm') {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> femalePupils(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      if (pupil.gender == 'w') {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> pupilsWithLanguageSupport(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      // if the pupil has a language support as of today, add to list

      if (pupil.migrationSupportEnds != null) {
        if (PupilHelper.hasLanguageSupport(pupil.migrationSupportEnds)) {
          groupPupils.add(pupil);
        }
      }
    }
    return groupPupils;
  }

  List<PupilProxy> pupilsHadLanguageSupport(List<PupilProxy> givenPupils) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in givenPupils) {
      // if the pupil has a language support as of today, add to list
      if (pupil.migrationSupportEnds != null) {
        if (PupilHelper.hadLanguageSupport(pupil.migrationSupportEnds)) {
          groupPupils.add(pupil);
        }
      }
    }
    return groupPupils;
  }

  List<PupilProxy> schoolyearInaGivenGroup(
    List<PupilProxy> group,
    String schoolyear,
  ) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.schoolGrade.name == schoolyear) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSupportInaGivenGroup(
    List<PupilProxy> group,
  ) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preSchoolMedical?.preschoolMedicalStatus ==
          PreSchoolMedicalStatus.supportAreas) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSpecialNeedsInaGivenGroup(
    List<PupilProxy> group,
  ) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preSchoolMedical?.preschoolMedicalStatus ==
          PreSchoolMedicalStatus.checkSpecialSupport) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> specialNeedsInAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.specialNeeds != null) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> developmentPlan1InAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.latestSupportLevel?.level == 1) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> developmentPlan2InAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.latestSupportLevel?.level == 2) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> developmentPlan3InAGivenGroup(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.latestSupportLevel?.level == 3) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionNotAvailable(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preSchoolMedical?.preschoolMedicalStatus ==
          PreSchoolMedicalStatus.notAvailable) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionOk(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preSchoolMedical?.preschoolMedicalStatus ==
          PreSchoolMedicalStatus.ok) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSupport(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preSchoolMedical?.preschoolMedicalStatus ==
          PreSchoolMedicalStatus.supportAreas) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<PupilProxy> preschoolRevisionSpecialNeeds(List<PupilProxy> group) {
    List<PupilProxy> groupPupils = [];
    for (PupilProxy pupil in group) {
      if (pupil.preSchoolMedical?.preschoolMedicalStatus ==
          PreSchoolMedicalStatus.checkSpecialSupport) {
        groupPupils.add(pupil);
      }
    }
    return groupPupils;
  }

  List<MissedSchoolday> totalMissedClasses(List<PupilProxy> pupils) {
    List<MissedSchoolday> missedClasses = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.missedSchooldays != null) {
        for (MissedSchoolday missedClass in pupil.missedSchooldays!) {
          missedClasses.add(missedClass);
        }
      }
    }
    return missedClasses;
  }

  List<MissedSchoolday> totalUnexcusedMissedClasses(List<PupilProxy> pupils) {
    List<MissedSchoolday> missedClasses = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.missedSchooldays != null) {
        for (MissedSchoolday missedClass in pupil.missedSchooldays!) {
          if (missedClass.unexcused == true) {
            missedClasses.add(missedClass);
          }
        }
      }
    }

    return missedClasses;
  }

  List<MissedSchoolday> totalContactedMissedClasses(List<PupilProxy> pupils) {
    List<MissedSchoolday> missedClasses = [];
    for (PupilProxy pupil in pupils) {
      if (pupil.missedSchooldays != null) {
        for (MissedSchoolday missedClass in pupil.missedSchooldays!) {
          if (missedClass.contacted != ContactedType.notSet) {
            missedClasses.add(missedClass);
          }
        }
      }
    }
    return missedClasses;
  }

  double averageMissedClassesperPupil(List<PupilProxy> pupils) {
    double totalMissedClasses = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.missedSchooldays != null) {
        totalMissedClasses += pupil.missedSchooldays!.length;
      }
    }
    return totalMissedClasses / pupils.length;
  }

  double averageUnexcusedMissedClassesperPupil(List<PupilProxy> pupils) {
    double totalMissedClasses = 0;
    for (PupilProxy pupil in pupils) {
      if (pupil.missedSchooldays != null) {
        for (MissedSchoolday missedClass in pupil.missedSchooldays!) {
          if (missedClass.unexcused == true) {
            totalMissedClasses++;
          }
        }
      }
    }
    return totalMissedClasses / pupils.length;
  }

  double percentageMissedSchooldays(double amountOfmissedClasses) {
    List<Schoolday> schooldays = di<SchoolCalendarManager>().schooldays.value;
    int schooldaysUntiltoday = 0;
    for (Schoolday schoolday in schooldays) {
      if (schoolday.schoolday.isBeforeDate(DateTime.now())) {
        schooldaysUntiltoday++;
      }
    }
    return amountOfmissedClasses / schooldaysUntiltoday * 100;
  }

  Map<String, int> groupStatistics(List<PupilProxy> pupils) {
    Map<String, int> groupStatistics = {};
    for (PupilProxy pupil in pupils) {
      groupStatistics[pupil.group] = (groupStatistics[pupil.group] ?? 0) + 1;
    }
    return groupStatistics;
  }

  @override
  Widget build(BuildContext context) {
    return StatisticsPage(this);
  }
}
