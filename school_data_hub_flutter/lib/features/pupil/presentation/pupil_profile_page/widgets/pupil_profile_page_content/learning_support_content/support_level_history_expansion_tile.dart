import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';

class SupportLevelHistoryExpansionTile extends StatefulWidget {
  final PupilProxy pupil;
  const SupportLevelHistoryExpansionTile({required this.pupil, super.key});

  @override
  State<SupportLevelHistoryExpansionTile> createState() =>
      _SupportLevelHistoryExpansionTileState();
}

class _SupportLevelHistoryExpansionTileState
    extends State<SupportLevelHistoryExpansionTile> {
  late ExpansibleController _tileController;

  @override
  void initState() {
    _tileController = ExpansibleController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = widget.pupil;
    final List<SupportLevel> plans = pupil.supportLevelHistory!;
    return ListTileTheme(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: const EdgeInsets.all(0),
          title: Row(
            children: [
              const Text('Förderebene:', style: TextStyle(fontSize: 15.0)),
              const Gap(10),
              InkWell(
                onTap: () => supportLevelDialog(
                  context,
                  pupil,
                  pupil.latestSupportLevel!.level,
                ),
                child: Text(
                  pupil.latestSupportLevel == null
                      ? 'kein Eintrag'
                      : pupil.latestSupportLevel!.level == 1
                      ? 'Förderebene 1'
                      : pupil.latestSupportLevel!.level == 2
                      ? 'Förderebene 2'
                      : pupil.latestSupportLevel!.level == 3
                      ? 'Förderebene 3'
                      : '🌈-Förderung',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ),
            ],
          ),
          controller: _tileController,
          children: [
            pupil.supportLevelHistory != null
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.pupil.supportLevelHistory!.length,
                    itemBuilder: (context, index) {
                      return SupportLevelHistoryItemCard(
                        pupil: pupil,
                        supportLevel: plans[index],
                      );
                    },
                  )
                : const Text('keine Einträge'),
          ],
        ),
      ),
    );
  }
}

class SupportLevelHistoryItemCard extends StatelessWidget {
  final PupilProxy pupil;
  final SupportLevel supportLevel;

  const SupportLevelHistoryItemCard({
    required this.pupil,
    required this.supportLevel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hubSessionManager = di<HubSessionManager>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        child: InkWell(
          onTap: () {
            if (hubSessionManager.isAdmin) {
              supportLevelDialog(
                context,
                pupil,
                supportLevel.level,
                existingSupportLevel: supportLevel,
              );
            }
          },
          onLongPress: () async {
            if (!hubSessionManager.isAdmin) return;
            final confirmation = await confirmationDialog(
              context: context,
              title: 'Eintrag löschen',
              message: 'Eintrag wirklich löschen?',
            );
            if (confirmation != true) return;
            PupilMutator().deleteSupportLevelHistoryItem(
              pupilId: pupil.pupilId,
              supportLevelId: supportLevel.id!,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          supportLevel.createdAt.formatDateForUser(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          supportLevel.createdBy,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Förderebene ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            supportLevel.level.toString(),
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      if (supportLevel.comment.isNotEmpty)
                        Text(
                          customEncrypter.decryptString(supportLevel.comment),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                    ],
                  ),
                ),

                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
