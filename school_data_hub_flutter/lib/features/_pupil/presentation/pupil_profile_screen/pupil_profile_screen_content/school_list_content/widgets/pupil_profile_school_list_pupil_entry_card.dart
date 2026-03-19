import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/custom_checkbox_either_or.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/pupil_list_entry_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_screen/school_list_pupil_entries_screen.dart';

class PupilProfileSchoolListPupilEntryCard extends WatchingWidget {
  final PupilListEntryProxy pupilListEntryProxy;
  const PupilProfileSchoolListPupilEntryCard({
    required this.pupilListEntryProxy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _PupilProfileSchoolListEntryContent(
      pupilListEntryProxy: pupilListEntryProxy,
    );
  }
}

/// Rebuilds only when [pupilListEntryProxy.pupilEntry] changes.
class _PupilProfileSchoolListEntryContent extends WatchingWidget {
  final PupilListEntryProxy pupilListEntryProxy;

  const _PupilProfileSchoolListEntryContent({
    required this.pupilListEntryProxy,
  });

  @override
  Widget build(BuildContext context) {
    final schoolListManager = di<SchoolListManager>();
    final pupilListEntry = watch(pupilListEntryProxy).pupilEntry;
    final schoolList = schoolListManager.getSchoolListById(
      pupilListEntry.schoolListId,
    );
    return GestureDetector(
      onLongPress: () async {
        final confirm = await confirmationDialog(
          context: context,
          title: 'Schüler*in aus Liste löschen',
          message: 'Schüler*in aus der Liste löschen?',
        );
        if (confirm != true) {
          return;
        }
        await schoolListManager.updateSchoolListProperty(
          listId: pupilListEntry.schoolListId,
          operation: (
            pupilIds: [pupilListEntry.pupilId],
            operation: MemberOperation.remove,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Style.of(context).colors.cardInCard,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            top: 10,
            bottom: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute<void>(
                                builder: (ctx) =>
                                    SchoolListPupilEntriesScreen(schoolList),
                              ),
                            );
                          },
                          child: Text(
                            schoolList.name,
                            style: context.typography.title.bold.withColor(
                              Style.of(context).colors.interactive,
                            ),
                          ),
                        ),
                        const Gap(5),
                        Text(
                          maxLines: 2,
                          schoolList.description,
                          style: context.typography.body,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: Style.of(context).colors.error,
                          ),
                          CustomCheckboxEitherOr(
                            representedBoolValue:
                                false, // Red/negative checkbox
                            currentStatus: pupilListEntry.status,
                            onStatusChanged: (newStatus) async {
                              await schoolListManager.updatePupilListEntry(
                                entry: pupilListEntry,
                                status: (value: newStatus),
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: Style.of(context).colors.success,
                          ),
                          CustomCheckboxEitherOr(
                            representedBoolValue:
                                true, // Green/positive checkbox
                            currentStatus: pupilListEntry.status,
                            onStatusChanged: (newStatus) async {
                              await schoolListManager.updatePupilListEntry(
                                entry: pupilListEntry,
                                status: (value: newStatus),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(5),
              GestureDetector(
                onTap: () async {
                  final result = await longTextFieldDialog(
                    title: 'Kommentar',
                    initialValue: pupilListEntry.comment ?? '',
                    labelText: 'Kommentar eintragen',
                    parentContext: context,
                  );
                  if (result == null ||
                      result.value == pupilListEntry.comment) {
                    return;
                  }
                  await schoolListManager.updatePupilListEntry(
                    entry: pupilListEntry,
                    comment: (value: result.value),
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
                          TextSpan(
                            text: 'Kommentar: ',
                            style: context.typography.subtitle.bold,
                          ),
                          TextSpan(
                            text:
                                (pupilListEntry.comment == null ||
                                    pupilListEntry.comment!.isEmpty)
                                ? 'Kein Kommentar'
                                : pupilListEntry.comment!,
                          ),
                        ],
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
