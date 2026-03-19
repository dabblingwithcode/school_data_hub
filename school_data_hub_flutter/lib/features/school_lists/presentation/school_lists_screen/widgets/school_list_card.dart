import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_screen/school_list_pupil_entries_screen.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_screen/widgets/school_list_stats_row.dart';
import 'package:flutter_it/flutter_it.dart';

class SchoolListCard extends WatchingWidget {
  final SchoolList schoolList;
  const SchoolListCard({required this.schoolList, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schoolListManager = di<SchoolListManager>();
    final hubSessionManager = di<HubSessionManager>();
    final schoolList = watchValue(
      (SchoolListManager x) => x.schoolLists,
    ).firstWhere((element) => element.listId == this.schoolList.listId);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (ctx) => SchoolListPupilEntriesScreen(schoolList),
          ),
        );
      },
      onLongPress: () async {
        if (schoolList.createdBy != hubSessionManager.userName) {
          informationDialog(
            context,
            'Keine Berechtigung',
            'Listen können nur von ListenbesiterInnen bearbeitet werden!',
          );
          return;
        }
        final bool? result = await confirmationDialog(
          context: context,
          title: 'Liste löschen',
          message: 'Liste "${schoolList.name}" wirklich löschen?',
        );
        if (result == true) {
          await schoolListManager.deleteSchoolList(schoolList.id!);
          if (context.mounted) {
            informationDialog(
              context,
              'Liste gelöscht',
              'Die Liste wurde gelöscht!',
            );
          }
        }
      },
      child: CardBox(
        padding: const EdgeInsets.only(top: 8.0, bottom: 5),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              schoolList.name,
                              style: context.typography.title.withColor(
                                style.colors.interactive,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        schoolList.public == true
                            ? Icon(
                                Icons.school_rounded,
                                color: style.colors.accent,
                              )
                            : Text(
                                schoolList.createdBy,
                                style: context.typography.title.withColor(
                                  style.colors.foreground,
                                ),
                              ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            schoolList.description,
                            style: context.typography.body,
                          ),
                        ),
                        const Gap(10),
                        if (schoolList.authorizedUsers != null &&
                            schoolList.authorizedUsers!.isNotEmpty) ...[
                          SizedBox(
                            width: 50,
                            child: Wrap(
                              spacing: 5,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                const Gap(2),
                                Text(
                                  '+ ${schoolList.authorizedUsers!.replaceAll('*', ' + ')}',
                                  style: context.typography.bodySmall.w500
                                      .withColor(style.colors.accent),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                        ],
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SchoolListStatsRow(
                                schoolList: schoolList,
                                pupils: schoolListManager.getPupilsinSchoolList(
                                  schoolList.id!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
