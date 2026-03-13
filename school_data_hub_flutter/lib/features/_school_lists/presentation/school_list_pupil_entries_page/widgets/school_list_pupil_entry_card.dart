import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
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

class SchoolListPupilEntryCard extends StatelessWidget {
  final int pupilId;
  final int originListId;

  const SchoolListPupilEntryCard(this.pupilId, this.originListId, {super.key});

  @override
  Widget build(BuildContext context) {
    final pupil = di<PupilProxyManager>().getPupilByPupilId(pupilId)!;

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
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
                    _EntryName(pupil: pupil, originListId: originListId),
                    const Gap(5),
                    _EntryComment(pupilId: pupilId, originListId: originListId),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            _EntryStatus(pupilId: pupilId, originListId: originListId),
          ],
        ),
      ),
    );
  }
}

/// Name row with navigation and delete-on-long-press.
/// Does not need to watch the entry — uses [originListId] directly.
class _EntryName extends StatelessWidget {
  final PupilProxy pupil;
  final int originListId;

  const _EntryName({required this.pupil, required this.originListId});

  @override
  Widget build(BuildContext context) {
    final mainMenuBottomNavManager = di<BottomNavManager>();
    final hubSessionManager = di<HubSessionManager>();
    final notificationService = di<NotificationService>();
    final schoolListManager = di<SchoolListManager>();

    return InkWell(
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
          if (SchoolListHelper.listOwner(originListId) !=
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
          message: '${pupil.firstName} wirklich aus der Liste löschen?',
        );
        if (confirm != true) return;
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
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// Watches the pupil entry for comment display and editing.
class _EntryComment extends WatchingWidget {
  final int pupilId;
  final int originListId;

  const _EntryComment({required this.pupilId, required this.originListId});

  @override
  Widget build(BuildContext context) {
    final schoolListManager = di<SchoolListManager>();
    final PupilListEntry pupilEntry = watch(
      schoolListManager.getPupilSchoolListEntryProxy(
        pupilId: pupilId,
        listId: originListId,
      )!,
    ).pupilEntry;

    return InkWell(
      onTap: () async {
        final result = await longTextFieldDialog(
          title: 'Kommentar ändern',
          labelText: 'Kommentar',
          initialValue: pupilEntry.comment ?? '',
          parentContext: context,
        );
        if (result == null || result.value == pupilEntry.comment) return;
        await schoolListManager.updatePupilListEntry(
          entry: pupilEntry,
          comment: (value: result.value),
        );
      },
      onLongPress: () async {
        final confirm = await confirmationDialog(
          context: context,
          title: 'Kommentar löschen',
          message: 'Möchten Sie wirklich den Kommentar löschen?',
        );
        if (confirm != true) return;
        await schoolListManager.updatePupilListEntry(
          entry: pupilEntry,
          comment: (value: null),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            textAlign: TextAlign.left,
            TextSpan(
              children: [
                const TextSpan(
                  text: ' Kommentar: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: (pupilEntry.comment == null ||
                          pupilEntry.comment!.isEmpty)
                      ? 'Kein Kommentar'
                      : pupilEntry.comment!,
                ),
              ],
            ),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}

/// Watches the pupil entry for status checkboxes and entryBy display.
class _EntryStatus extends WatchingWidget {
  final int pupilId;
  final int originListId;

  const _EntryStatus({required this.pupilId, required this.originListId});

  @override
  Widget build(BuildContext context) {
    final schoolListManager = di<SchoolListManager>();
    final PupilListEntry pupilEntry = watch(
      schoolListManager.getPupilSchoolListEntryProxy(
        pupilId: pupilId,
        listId: originListId,
      )!,
    ).pupilEntry;

    return Column(
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
    );
  }
}
