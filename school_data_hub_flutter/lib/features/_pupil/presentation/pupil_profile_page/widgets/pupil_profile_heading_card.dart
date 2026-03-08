import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';

class PupilProfileHeadingCard extends WatchingWidget {
  final PupilProxy pupil;
  const PupilProfileHeadingCard({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [AvatarWithBadges(pupil: pupil, size: 100)]),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10),
                _PupilNameRow(pupil: pupil),
                _SchoolGradeAndInternalIdRow(pupil: pupil),
                const Gap(2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _PupilNameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _PupilNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Align(
              child: Text(
                firstName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$lastName ',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Rebuilds only when [pupil.schoolGrade], [pupil.specialNeeds], or [pupil.internalId] changes.
class _SchoolGradeAndInternalIdRow extends WatchingWidget {
  final PupilProxy pupil;

  const _SchoolGradeAndInternalIdRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final schoolGrade = watchPropertyValue((m) => m.schoolGrade, target: pupil);
    final specialNeeds =
        watchPropertyValue((m) => m.specialNeeds, target: pupil);
    final internalId =
        watchPropertyValue((m) => m.internalId, target: pupil);
    final isAdmin = di<HubSessionManager>().isAdmin == true;

    return Row(
      children: [
        specialNeeds != null
            ? Text(
                schoolGrade.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.schoolyearColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              )
            : const SizedBox.shrink(),
        const Gap(15),
        if (isAdmin) ...[
          const Gap(10),
          Text(
            '$internalId',
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ],
    );
  }
}
