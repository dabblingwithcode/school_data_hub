import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/custom_checkbox_either_or.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_helper_functions.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class SchoolListPupilEntryCard extends WatchingWidget {
  final int pupilId;

  final int originListId;

  const SchoolListPupilEntryCard(this.pupilId, this.originListId, {super.key});

  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();
    final PupilProxy pupil = pupilManager.getPupilByPupilId(pupilId)!;

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: _SchoolListPupilEntryContent(
        pupil: pupil,
        pupilId: pupilId,
        originListId: originListId,
      ),
    );
  }
}

/// Rebuilds only when the pupil's school list entry for this list changes.
class _SchoolListPupilEntryContent extends WatchingWidget {
  final PupilProxy pupil;
  final int pupilId;
  final int originListId;

  const _SchoolListPupilEntryContent({
    required this.pupil,
    required this.pupilId,
    required this.originListId,
  });

  @override
  Widget build(BuildContext context) {
    final mainMenuBottomNavManager = di<BottomNavManager>();
    final hubSessionManager = di<HubSessionManager>();
    final notificationService = di<NotificationService>();
    final schoolListManager = di<SchoolListManager>();
    final PupilListEntry pupilEntry = watch(
      schoolListManager.getPupilSchoolListEntryProxy(
        pupilId: pupilId,
        listId: originListId,
      )!,
    ).pupilEntry;

    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarWithBadges(pupil: pupil, size: 80),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      mainMenuBottomNavManager.setPupilProfileNavPage(6);
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (ctx) => PupilProfilePage(pupil: pupil),
                        ),
                      );
                    },
                    onLongPress: () async {
                      if (!hubSessionManager.isAdmin) {
                        if (SchoolListHelper.listOwner(
                              pupilEntry.schoolListId,
                            ) !=
                            hubSessionManager.userName) {
                          notificationService.showSnackBar(
                            NotificationType.error,
                            'Löschen nicht möglich - keine Berechtigung!',
                          );

                          return;
                        }
                      }
                      final bool? confirm = await confirmationDialog(
                        context: context,
                        title: 'Kind aus der Liste löschen',
                        message:
                            '${pupil.firstName} wirklich aus der Liste löschen?',
                      );
                      if (confirm != true) {
                        return;
                      }
                      await schoolListManager.updateSchoolListProperty(
                        listId: originListId,
                        operation: (
                          operation: MemberOperation.remove,
                          pupilIds: [pupil.pupilId],
                        ),
                      );

                      if (context.mounted) {
                        informationDialog(
                          context,
                          'Kind aus Liste gelöscht',
                          'Das Kind wurde gelöscht!',
                        );
                      }
                    },
                    child: Text(
                      '${pupil.firstName} ${pupil.lastName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(5),
                  InkWell(
                    onTap: () async {
                      final result = await longTextFieldDialog(
                        title: 'Kommentar ändern',
                        labelText: 'Kommentar',
                        initialValue: pupilEntry.comment ?? '',
                        parentContext: context,
                      );
                      if (result == null ||
                          result.value == pupilEntry.comment) {
                        return;
                      }
                      await schoolListManager.updatePupilListEntry(
                        entry: pupilEntry,
                        comment: (value: result.value),
                      );
                    },
                    onLongPress: () async {
                      final confirm = await confirmationDialog(
                        context: context,
                        title: 'Kommentar löschen',
                        message:
                            'Möchten Sie wirklich den Kommentar löschen?',
                      );
                      if (confirm != true) return;
                      await schoolListManager.updatePupilListEntry(
                        entry: pupilEntry,
                        comment: (value: null),
                      );
                    },
                    child: Text(
                      pupilEntry.comment != null && pupilEntry.comment != ''
                          ? pupilEntry.comment!
                          : 'kein Kommentar',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.close, color: Colors.red),
                  CustomCheckboxEitherOr(
                    representedBoolValue: false,
                    currentStatus: pupilEntry.status,
                    onStatusChanged: (newStatus) async {
                      await schoolListManager.updatePupilListEntry(
                        entry: pupilEntry,
                        status: (value: newStatus),
                      );
                    },
                  ),
                ],
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.done, color: Colors.green),
                  CustomCheckboxEitherOr(
                    representedBoolValue: true,
                    currentStatus: pupilEntry.status,
                    onStatusChanged: (newStatus) async {
                      await schoolListManager.updatePupilListEntry(
                        entry: pupilEntry,
                        status: (value: newStatus),
                      );
                    },
                  ),
                ],
              ),
              const Gap(10),
              if (pupilEntry.entryBy != null)
                Row(
                  children: [
                    Text(
                      pupilEntry.entryBy!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
