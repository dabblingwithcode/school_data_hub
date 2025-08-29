import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:watch_it/watch_it.dart';

class SupportLevelHistoryExpansionTile extends StatefulWidget {
  final PupilProxy pupil;
  const SupportLevelHistoryExpansionTile({required this.pupil, super.key});

  @override
  State<SupportLevelHistoryExpansionTile> createState() =>
      _SupportLevelHistoryExpansionTileState();
}

final _hubSessionManager = di<HubSessionManager>();
final _pupilManager = di<PupilManager>();

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
                onTap:
                    () => supportLevelDialog(
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
                      : 'Regenbogenförderung',
                  style: const TextStyle(
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: GestureDetector(
                        onLongPress: () async {
                          final confirmation = await confirmationDialog(
                            context: context,
                            title: 'Eintrag löschen',
                            message: 'Eintrag wirklich löschen?',
                          );
                          if (confirmation != true) return;
                          if (_hubSessionManager.isAdmin) {
                            PupilMutator().deleteSupportLevelHistoryItem(
                              pupilId: pupil.pupilId,
                              supportLevelId: plans[index].id!,
                            );
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.pupil.supportLevelHistory![index].createdAt
                                  .formatForUser(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Gap(20),
                            Column(
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
                                      widget
                                          .pupil
                                          .supportLevelHistory![index]
                                          .level
                                          .toString(),
                                      style: const TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      pupil.supportLevelHistory![index].comment,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              pupil.supportLevelHistory![index].createdBy,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Gap(10),
                          ],
                        ),
                      ),
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
