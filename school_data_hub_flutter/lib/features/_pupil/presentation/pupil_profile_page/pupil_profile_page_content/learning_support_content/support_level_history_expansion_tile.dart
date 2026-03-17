import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/custom_encrypter.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/dialogs/support_level_dialog.dart';

class SupportLevelHistoryExpansionTile extends StatefulWidget {
  final PupilProxy pupil;
  const SupportLevelHistoryExpansionTile({required this.pupil, super.key});

  @override
  State<SupportLevelHistoryExpansionTile> createState() =>
      _SupportLevelHistoryExpansionTileState();
}

class _SupportLevelHistoryExpansionTileState
    extends State<SupportLevelHistoryExpansionTile> {
  bool _isExpanded = false;

  String _supportLevelText(SupportLevel? level) {
    if (level == null) return 'kein Eintrag';
    return switch (level.level) {
      0 => 'Förderebene 0',
      1 => 'Förderebene 1',
      2 => 'Förderebene 2',
      3 => 'Förderebene 3',
      4 => 'Regenbogenförderung',
      _ => 'unbekannt',
    };
  }

  @override
  Widget build(BuildContext context) {
    final PupilProxy pupil = widget.pupil;
    final List<SupportLevel> plans = pupil.supportLevelHistory!;

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.pupilProfileCardColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.backgroundColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.layers_outlined,
                  color: AppColors.backgroundColor.withValues(alpha: 0.7),
                  size: 18,
                ),
                const Gap(8),
                Text(
                  'Förderebene:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.backgroundColor,
                  ),
                ),
                const Spacer(),
                TappableIcon(
                  size: 32,
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.backgroundColor.withValues(alpha: 0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
            const Gap(6),
            InkWell(
              onTap: () => supportLevelDialog(
                context,
                pupil,
                pupil.latestSupportLevel?.level,
              ),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.interactiveColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _supportLevelText(pupil.latestSupportLevel),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.interactiveColor,
                  ),
                ),
              ),
            ),
            if (_isExpanded) ...[
              const Gap(10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.pupil.supportLevelHistory!.length,
                itemBuilder: (context, index) {
                  return SupportLevelHistoryItemCard(
                    pupil: pupil,
                    supportLevel: plans[index],
                  );
                },
              ),
            ],
            const Gap(10),
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

  String _supportLevelText(int level) {
    return switch (level) {
      0 => 'Förderebene 0',
      1 => 'Förderebene 1',
      2 => 'Förderebene 2',
      3 => 'Förderebene 3',
      4 => 'Regenbogenförderung',
      _ => 'unbekannt',
    };
  }

  @override
  Widget build(BuildContext context) {
    final hubSessionManager = di<HubSessionManager>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: hubSessionManager.isAdmin
                ? AppColors.interactiveColor.withValues(alpha: 0.05)
                : Colors.grey.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.backgroundColor.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    supportLevel.createdAt.formatDateForUser(),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    supportLevel.createdBy,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _supportLevelText(supportLevel.level),
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    if (supportLevel.comment.isNotEmpty) ...[
                      const Gap(4),
                      Text(
                        customEncrypter.decryptString(supportLevel.comment),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
