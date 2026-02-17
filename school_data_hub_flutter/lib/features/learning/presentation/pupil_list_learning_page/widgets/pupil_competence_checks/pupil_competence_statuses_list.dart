import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_competence_checks/competence_check_card.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_list_learning_page/widgets/pupil_competence_checks/pupil_competence_card.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class PupilCompetenceStatusesList extends WatchingWidget {
  final PupilProxy pupil;

  const PupilCompetenceStatusesList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    watch(pupil);

    // Get all competences allowed for this pupil
    final competences = CompetenceHelper.getAllowedCompetencesForThisPupil(
      pupil,
    );

    // Get competence checks mapped by competence ID
    final Map<int, List<CompetenceCheck>> pupilCompetenceChecksMap =
        CompetenceHelper.getCompetenceChecksMappedTopublicIdsForThisPupil(
          pupil.pupilId,
        );

    if (pupilCompetenceChecksMap.isEmpty) {
      return const SizedBox.shrink();
    }

    final competenceManager = di<CompetenceManager>();

    // Group leaf competences (those with checks) by their root competence
    final leafCompetenceIdsByRoot = <int, List<int>>{};

    for (final competenceId in pupilCompetenceChecksMap.keys) {
      // Find the competence object
      // final competence = competences.firstWhere(
      //   (c) => c.publicId == competenceId,
      //   orElse: () => competenceManager.findCompetenceById(competenceId),
      // );

      // Get the root competence ID
      final rootCompetenceId = competenceManager
          .findRootCompetenceById(competenceId)
          .publicId;

      // Group by root
      leafCompetenceIdsByRoot
          .putIfAbsent(rootCompetenceId, () => [])
          .add(competenceId);
    }

    // Sort root competence IDs for consistent display
    final sortedRootIds = leafCompetenceIdsByRoot.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final rootCompetenceId in sortedRootIds) ...[
          _RootCompetenceHeader(rootCompetenceId: rootCompetenceId),
          for (final competenceId in leafCompetenceIdsByRoot[rootCompetenceId]!)
            _buildCompetenceCard(
              context: context,
              competenceId: competenceId,
              competences: competences,
              competenceChecksMap: pupilCompetenceChecksMap,
              rootCompetenceId: rootCompetenceId,
            ),
        ],
      ],
    );
  }

  Widget _buildCompetenceCard({
    required BuildContext context,
    required int competenceId,
    required List<Competence> competences,
    required Map<int, List<CompetenceCheck>> competenceChecksMap,
    required int rootCompetenceId,
  }) {
    final competenceManager = di<CompetenceManager>();

    // Find the competence
    final competence = competences.firstWhere(
      (c) => c.publicId == competenceId,
      orElse: () => competenceManager.findCompetenceById(competenceId),
    );

    // Get the root competence color
    final Color backgroundColor = CompetenceHelper.getCompetenceColor(
      rootCompetenceId,
    );

    // Calculate average score
    double? averageCompetenceStatus;
    final checks = competenceChecksMap[competenceId]!;
    final filteredChecks = checks.where((check) => check.score != 0).toList();

    if (filteredChecks.isNotEmpty) {
      final totalWeightedScore = filteredChecks
          .map((check) => check.score * check.valueFactor)
          .reduce((a, b) => a + b);
      final totalValueFactor = filteredChecks
          .map((check) => check.valueFactor)
          .reduce((a, b) => a + b);
      averageCompetenceStatus = totalWeightedScore / totalValueFactor;
    }

    // Build competence check cards
    final competenceCheckCards = checks.map((check) {
      return CompetenceCheckCard(competenceCheck: check);
    }).toList();

    final isReport = !competenceManager.isCompetenceWithChildren(competence);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: PupilCompetenceCard(
        backgroundColor: backgroundColor,
        competence: competence,
        pupil: pupil,
        isReport: isReport,
        competenceChecks: competenceCheckCards,
        checksAverageValue: averageCompetenceStatus,
        children: const [], // No children in flat structure
      ),
    );
  }
}

class _RootCompetenceHeader extends StatelessWidget {
  final int rootCompetenceId;

  const _RootCompetenceHeader({required this.rootCompetenceId});

  @override
  Widget build(BuildContext context) {
    final competenceManager = di<CompetenceManager>();
    final rootCompetence = competenceManager.findRootCompetenceById(
      rootCompetenceId,
    );
    final color = CompetenceHelper.getCompetenceColor(rootCompetenceId);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Center(
              child: Text(
                _getCompetenceShortName(rootCompetence.name),
                style: TextStyle(
                  color: AppColors.bestContrastCompetenceFontColor(color),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: Text(
              rootCompetence.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCompetenceShortName(String name) {
    // Extract initials or first few letters for display in circle
    final words = name.split(' ');
    if (words.length > 1) {
      return words.take(2).map((w) => w[0]).join().toUpperCase();
    }
    return name.substring(0, name.length > 2 ? 2 : name.length).toUpperCase();
  }
}
