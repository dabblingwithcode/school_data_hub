import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfileHeadingCard extends WatchingWidget {
  final PupilProxy passedPupil;
  const PupilProfileHeadingCard({required this.passedPupil, super.key});

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    final pupil = watch<PupilProxy>(passedPupil);
    return Card(
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
                Row(
                  children: [
                    Align(
                      child: Text(
                        pupil.firstName,
                        //textAlign: TextAlign.left,
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
                      '${pupil.lastName} ',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'FE  ${pupil.latestSupportLevel?.level ?? '0'}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const Gap(15),
                    pupil.specialNeeds != null
                        ? Text(
                          pupil.schoolGrade.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: AppColors.schoolyearColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                        : const SizedBox.shrink(),
                    const Gap(15),
                    if (pupil.specialInformation != null)
                      const Icon(Icons.warning_rounded, color: Colors.red),
                    if (_hubSessionManager.isAdmin == true) ...<Widget>[
                      const Gap(10),
                      Text(
                        '${pupil.internalId}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ],
                ),
                const Gap(2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
