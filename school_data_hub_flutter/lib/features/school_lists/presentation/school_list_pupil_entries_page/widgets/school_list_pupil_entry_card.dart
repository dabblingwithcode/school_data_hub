import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_checkbox_either_or.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_helper_functions.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

class SchoolListPupilEntryCard extends WatchingWidget {
  final int pupilId;

  final int originListId;

  const SchoolListPupilEntryCard(this.pupilId, this.originListId, {super.key});

  @override
  Widget build(BuildContext context) {
    final _pupilManager = di<PupilProxyManager>();
    final _mainMenuBottomNavManager = di<BottomNavManager>();
    final _hubSessionManager = di<HubSessionManager>();
    final _notificationService = di<NotificationService>();
    final _schoolListManager = di<SchoolListManager>();
    final PupilProxy pupil = _pupilManager.getPupilByPupilId(pupilId)!;

    final PupilListEntry pupilEntry = watch(
      _schoolListManager.getPupilSchoolListEntryProxy(
        pupilId: pupilId,
        listId: originListId,
      )!,
    ).pupilEntry;

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarWithBadges(pupil: pupil, size: 80),
            const SizedBox(width: 10), // Add some spacing
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _mainMenuBottomNavManager.setPupilProfileNavPage(6);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PupilProfilePage(pupil: pupil),
                          ),
                        );
                      },
                      onLongPress: () async {
                        if (!_hubSessionManager.isAdmin) {
                          if (SchoolListHelper.listOwner(
                                pupilEntry.schoolListId,
                              ) !=
                              _hubSessionManager.userName) {
                            _notificationService.showSnackBar(
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
                        await _schoolListManager.updateSchoolListProperty(
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
                        await _schoolListManager.updatePupilListEntry(
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
                        await _schoolListManager.updatePupilListEntry(
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
            const SizedBox(width: 5), // Add some spacing
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
                      representedBoolValue: false, // Red/negative checkbox
                      currentStatus: pupilEntry.status,
                      onStatusChanged: (newStatus) async {
                        await _schoolListManager.updatePupilListEntry(
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
                      representedBoolValue: true, // Green/positive checkbox
                      currentStatus: pupilEntry.status,
                      onStatusChanged: (newStatus) async {
                        await _schoolListManager.updatePupilListEntry(
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
      ),
    );
  }
}
