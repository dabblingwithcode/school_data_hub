import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupils_page/school_list_pupils_page.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupils_page/widgets/school_list_stats_row.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();
final _serverpodSessionManager = di<ServerpodSessionManager>();
final _pupilManager = di<PupilManager>();

class SchoolListCard extends WatchingWidget {
  final SchoolList schoolList;
  const SchoolListCard({required this.schoolList, super.key});

  @override
  Widget build(BuildContext context) {
    final schoolList =
        watchPropertyValue((SchoolListManager x) => x.schoolLists)
            .firstWhere((element) => element.listId == this.schoolList.listId);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => SchoolListPupilsPage(
                  schoolList,
                ),
              ));
            },
            onLongPress: () async {
              if (schoolList.createdBy != _serverpodSessionManager.userName) {
                informationDialog(context, 'Keine Berechtigung',
                    'Listen können nur von ListenbesiterInnen bearbeitet werden!');
                return;
              }
              final bool? result = await confirmationDialog(
                  context: context,
                  title: 'Liste löschen',
                  message: 'Liste "${schoolList.name}" wirklich löschen?');
              if (result == true) {
                // TODO: UNCOMMENT THIS
                // await _schoolListManager
                //     .deleteSchoolList(schoolList.listId);
                if (context.mounted) {
                  informationDialog(
                      context, 'Liste gelöscht', 'Die Liste wurde gelöscht!');
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
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
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.interactiveColor),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              schoolList.public == true
                                  ? const Icon(
                                      Icons.school_rounded,
                                      color: AppColors.backgroundColor,
                                    )
                                  : Text(
                                      schoolList.createdBy,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              const Padding(padding: EdgeInsets.only(right: 10))
                            ],
                          ),
                          const Gap(10),
                          Text(
                            schoolList.description,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
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
                                        pupils: _schoolListManager
                                            .pupilsPresentInSchoolList(
                                          schoolList.id!,
                                          _pupilManager.allPupils,
                                        )),
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
          )),
    );
  }
}
