import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/competence/domain/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

final _competenceManager = di<CompetenceManager>();

class CompetenceHelper {
  static List<Competence> sortCompetences(List<Competence> competences) {
    List<Competence> rootCompetences = [];
    List<Competence> childCompetences = [];

    for (var competence in competences) {
      if (competence.parentCompetence == null) {
        rootCompetences.add(competence);
      } else {
        childCompetences.add(competence);
      }
    }
    // Sort the child competences list based on parentCompetence and order values
    childCompetences.sort((a, b) {
      if (a.parentCompetence == b.parentCompetence) {
        if (a.order == null && b.order == null) return 0;
        if (a.order == null) return 1;
        if (b.order == null) return -1;
        return a.order!.compareTo(b.order!);
      }
      return (a.parentCompetence ?? 0).compareTo(b.parentCompetence ?? 0);
    });

    // Combine the root competences and sorted child competences
    List<Competence> sortedCompetences = [
      ...rootCompetences,
      ...childCompetences
    ];
    return sortedCompetences;
  }

  static CompetenceCheck? getLastCompetenceCheckOfCompetence(
      PupilProxy pupil, int publicId) {
    if (pupil.competenceChecks != null && pupil.competenceChecks!.isNotEmpty) {
      final filteredChecks = pupil.competenceChecks!
          .where((element) =>
              _competenceManager
                  .findCompetenceById(element.competenceId)
                  .publicId ==
              publicId)
          .toList();
      if (filteredChecks.isNotEmpty) {
        return filteredChecks
            .reduce((a, b) => a.createdAt.isAfter(b.createdAt) ? a : b);
      }
    }
    return null;
  }

  static CompetenceCheck? getGroupCompetenceCheckFromPupil(
      {required PupilProxy pupil, required String groupId}) {
    if (pupil.competenceChecks != null && pupil.competenceChecks!.isNotEmpty) {
      final groupIdCheck = pupil.competenceChecks!
          .firstWhereOrNull((element) => element.groupCheckId == groupId);

      return groupIdCheck;
    }

    return null;
  }

  static Map<int, int> generateRootCompetencesMap(
      List<Competence> competences) {
    final Map<int, Competence> rootCompetencesMap = {
      for (Competence competence in competences) competence.publicId: competence
    };
    Map<int, int> rootCompetencesCache = {};

    int findRootCompetence(int publicId) {
      if (rootCompetencesCache.containsKey(publicId)) {
        return rootCompetencesCache[publicId]!;
      }
      final Competence competence = rootCompetencesMap[publicId]!;
      if (competence.parentCompetence == null) {
        rootCompetencesCache[publicId] = publicId;
        return publicId;
      }
      final int rootpublicId = findRootCompetence(competence.parentCompetence!);
      rootCompetencesCache[publicId] = rootpublicId;
      return rootpublicId;
    }

    final Map<int, int> result = {};
    for (var competence in competences) {
      result[competence.publicId] = findRootCompetence(competence.publicId);
    }
    return result;
  }

  static Color getCompetenceColor(int publicId) {
    final Competence rootCcompetence =
        _competenceManager.findRootCompetenceById(publicId);
    return getRootCompetenceColor(
        rootCompetenceType:
            RootCompetenceType.stringToValue[rootCcompetence.name]!);
  }

  static Color getRootCompetenceColor(
      {required RootCompetenceType rootCompetenceType}) {
    if (rootCompetenceType == RootCompetenceType.science) {
      return AppColors.scienceColor;
    } else if (rootCompetenceType == RootCompetenceType.english) {
      return AppColors.englishColor;
    } else if (rootCompetenceType == RootCompetenceType.math) {
      return AppColors.mathColor;
    } else if (rootCompetenceType == RootCompetenceType.music) {
      return AppColors.musicColor;
    } else if (rootCompetenceType == RootCompetenceType.german) {
      return AppColors.germanColor;
    } else if (rootCompetenceType == RootCompetenceType.art) {
      return AppColors.artColor;
    } else if (rootCompetenceType == RootCompetenceType.religion) {
      return AppColors.religionColor;
    } else if (rootCompetenceType == RootCompetenceType.sport) {
      return AppColors.sportColor;
    } else if (rootCompetenceType == RootCompetenceType.socialAndWorkSkills) {
      return AppColors.workBehaviourColor;
    } else if (rootCompetenceType == RootCompetenceType.motherLanguage) {
      return AppColors.socialColor;
    }
    return const Color.fromARGB(255, 157, 36, 36);
  }

  static Widget getCompetenceCheckSymbol(
      {required int status, required double size}) {
    switch (status) {
      case 1:
        return SizedBox(
            width: size, child: Image.asset('assets/growth_1-4.png'));
      case 2:
        return SizedBox(
            width: size, child: Image.asset('assets/growth_2-4.png'));
      case 3:
        return SizedBox(
            width: size, child: Image.asset('assets/growth_3-4.png'));
      // case 'orange':
      //   return Colors.orange;
      case 4:
        return SizedBox(
            width: size, child: Image.asset('assets/growth_4-4.png'));
    }
    return SizedBox(
        width: size,
        child: const Icon(Icons.question_mark_rounded, color: Colors.white));
  }

  static Widget getLastCompetenceCheckSymbol(
      {required PupilProxy pupil,
      required int publicId,
      required double size}) {
    if (pupil.competenceChecks!.isNotEmpty) {
      final CompetenceCheck? competenceCheck =
          getLastCompetenceCheckOfCompetence(pupil, publicId);

      if (competenceCheck != null) {
        getCompetenceCheckSymbol(
            status: competenceCheck.score ?? 0, size: size);
      }
      return const SizedBox(
          width: 50,
          child: Icon(
            Icons.question_mark_rounded,
            color: Colors.white,
          ));
    }

    return const SizedBox(
        width: 40, child: Icon(Icons.error, color: Colors.white));
  }

  static Map<int, List<CompetenceCheck>>
      getCompetenceChecksMappedTopublicIdsForThisPupil(int pupilId) {
    //! TODO: this is broken, we should access the competence
    //! public Id, but we are accessing the competenceId
    //! we should implement a getter for this
    final Map<int, List<CompetenceCheck>> competenceChecksMap = {};

    final PupilProxy pupil = di<PupilManager>().getPupilByPupilId(pupilId)!;
    if (pupil.competenceChecks == null || pupil.competenceChecks!.isEmpty) {
      return {};
    }
    for (CompetenceCheck competenceCheck in pupil.competenceChecks!) {
      if (competenceChecksMap[competenceCheck.competenceId] == null) {
        competenceChecksMap[competenceCheck.competenceId] = [];
      }
      // add the competence check to the list of the competence checks of the competence
      competenceChecksMap[competenceCheck.competenceId]!.add(competenceCheck);
      // order the competence checks by the date of creation latest first
      competenceChecksMap[competenceCheck.competenceId]!
          .sort((a, b) => b.createdAt.isAfter(a.createdAt) ? 1 : -1);
    }

    return competenceChecksMap;
  }

  static List<Competence> getAllowedCompetencesForThisPupil(PupilProxy pupil) {
    SchoolGrade schoolGrade = pupil.schoolGrade;
    if (pupil.specialNeeds != null && pupil.specialNeeds!.contains('LE')) {
      return _competenceManager.competences.value;
    }
    if ((pupil.schoolyearHeldBackAt != null) ||
        pupil.schoolGrade.name == 'E3') {
      switch (pupil.schoolGrade.name) {
        case 'E1':
          schoolGrade = SchoolGrade.E1;
          break;
        case 'E2':
          schoolGrade = SchoolGrade.E1;
          break;
        case 'E3':
          schoolGrade = SchoolGrade.E2;
          break;
      }
    }
    return _competenceManager.competences.value
        .where((Competence competence) =>
            competence.level!.contains(schoolGrade.name))
        .toList();
  }

  static ({int total, int checked}) competenceChecksStats(PupilProxy pupil) {
    final competences = getAllowedCompetencesForThisPupil(pupil);
    final Map<int, List<CompetenceCheck>> pupilCompetenceChecksMap =
        getCompetenceChecksMappedTopublicIdsForThisPupil(pupil.pupilId);
    int count = 0;
    int competencesWithCheck = 0;
    for (Competence competence in competences) {
      if (!_competenceManager.isCompetenceWithChildren(competence)) {
        count++;
      }
      if (pupilCompetenceChecksMap.containsKey(competence.publicId)) {
        competencesWithCheck++;
      }
    }
    return (total: count, checked: competencesWithCheck);
  }

  static List<PupilProxy> getFilteredPupilsByCompetence(
      {required Competence competence}) {
    List<PupilProxy> pupils = [];
    final filteredPupils = di<PupilFilterManager>().filteredPupils;
    for (PupilProxy pupil in filteredPupils.value) {
      if (pupil.specialNeeds != null && pupil.specialNeeds!.contains('LE')) {
        pupils.add(pupil);
        continue;
      } else {
        final allowedCompetences = getAllowedCompetencesForThisPupil(pupil);
        if (allowedCompetences.contains(competence)) {
          pupils.add(pupil);
          continue;
        }
      }
    }
    return pupils;
  }
}
