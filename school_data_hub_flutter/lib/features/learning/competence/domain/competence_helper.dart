import 'package:collection/collection.dart';
import 'dart:ui' show Color;
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/utils/hierarchical_sort.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/enums.dart';

class CompetenceHelper {
  static CompetenceManager get _competenceManager => di<CompetenceManager>();
  static List<Competence> sortCompetences(List<Competence> competences) {
    return HierarchicalSort.sort(
      items: competences,
      getParent: (c) => c.parentCompetence,
      getOrder: (c) => c.order,
    );
  }

  static CompetenceCheck? getGroupCompetenceCheckFromPupil({
    required PupilProxy pupil,
    required String groupId,
  }) {
    if (pupil.competenceChecks != null && pupil.competenceChecks!.isNotEmpty) {
      final groupIdCheck = pupil.competenceChecks!.firstWhereOrNull(
        (element) => element.groupCheckId == groupId,
      );

      return groupIdCheck;
    }

    return null;
  }

  static Map<int, int> generateRootCompetencesMap(
    List<Competence> competences,
  ) {
    return HierarchicalSort.generateRootMap(
      items: competences,
      getPublicId: (c) => c.publicId,
      getParent: (c) => c.parentCompetence,
    );
  }

  static Color getCompetenceColor(int publicId) {
    final Competence rootCcompetence = _competenceManager
        .findRootCompetenceById(publicId);
    final rootType = RootCompetenceType.stringToValue[rootCcompetence.name];
    if (rootType == null) {
      return const Color.fromARGB(255, 157, 36, 36);
    }
    return getRootCompetenceColor(rootCompetenceType: rootType);
  }

  static Color getRootCompetenceColor({
    required RootCompetenceType rootCompetenceType,
  }) {
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

  static CompetenceCheck? getLastCompetenceCheckOfCompetence(
    PupilProxy pupil,
    int publicId,
  ) {
    if (pupil.competenceChecks != null && pupil.competenceChecks!.isNotEmpty) {
      final filteredChecks = pupil.competenceChecks!
          .where(
            (element) =>
                _competenceManager
                    .findCompetenceById(element.competenceId)
                    .publicId ==
                publicId,
          )
          .toList();
      if (filteredChecks.isNotEmpty) {
        return filteredChecks.reduce(
          (a, b) => a.createdAt.isAfter(b.createdAt) ? a : b,
        );
      }
    }
    return null;
  }

  static Map<int, List<CompetenceCheck>>
  getCompetenceChecksMappedTopublicIdsForThisPupil(int pupilId) {
    final Map<int, List<CompetenceCheck>> competenceChecksMap = {};

    final PupilProxy pupil = di<PupilProxyManager>().getPupilByPupilId(
      pupilId,
    )!;
    if (pupil.competenceChecks == null || pupil.competenceChecks!.isEmpty) {
      return {};
    }
    for (CompetenceCheck competenceCheck in pupil.competenceChecks!) {
      // Use the competenceId directly as it corresponds to the competence's publicId
      final competencePublicId = competenceCheck.competenceId;

      if (competenceChecksMap[competencePublicId] == null) {
        competenceChecksMap[competencePublicId] = [];
      }
      // add the competence check to the list of the competence checks of the competence
      competenceChecksMap[competencePublicId]!.add(competenceCheck);
      // order the competence checks by the date of creation latest first
      competenceChecksMap[competencePublicId]!.sort(
        (a, b) => b.createdAt.isAfter(a.createdAt) ? 1 : -1,
      );
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
        .where(
          (Competence competence) =>
              competence.level!.contains(schoolGrade.name),
        )
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

  static List<PupilProxy> getFilteredPupilsByCompetence({
    required Competence competence,
  }) {
    List<PupilProxy> pupils = [];
    final filteredPupils = di<PupilsFilter>().filteredPupils;
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
