import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/pupil_list_entry_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_page/school_list_pupil_entries_page.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();

class PupilProfileSchoolListPupilEntryCard extends WatchingWidget {
  final PupilListEntryProxy pupilListEntryProxy;
  const PupilProfileSchoolListPupilEntryCard(
      {required this.pupilListEntryProxy, super.key});

  @override
  Widget build(BuildContext context) {
    final pupilListEntry = watch(pupilListEntryProxy).pupilEntry;
    final schoolList =
        _schoolListManager.getSchoolListById(pupilListEntry.schoolListId);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, top: 10, bottom: 15, right: 15),
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SchoolListPupilEntriesPage(
                            schoolList,
                          ),
                        ));
                      },
                      child: Text(
                        schoolList.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.interactiveColor,
                        ),
                      ),
                    ),
                    const Gap(5),
                    Text(
                      maxLines: 2,
                      schoolList.description,
                      style: const TextStyle(fontSize: 15),
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
                        Icon(Icons.close, color: Colors.red[400]),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            activeColor: Colors.red,
                            value:
                                (pupilListEntry.status == false) ? true : false,
                            onChanged: (value) async {
                              await _schoolListManager.updatePupilListEntry(
                                  entry: pupilListEntry,
                                  status: (value: false));
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(children: [
                      Icon(Icons.done, color: Colors.green[400]),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Checkbox(
                          activeColor: Colors.green,
                          value: (pupilListEntry.status == true) ? true : false,
                          onChanged: (value) async {
                            await _schoolListManager.updatePupilListEntry(
                                entry: pupilListEntry, status: (value: true));
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ]),
                  ]),
            ]),
            const Gap(5),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Kommentar',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(
                pupilListEntry.entryBy ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ]),
            const Gap(5),
            Row(children: [
              Flexible(
                child: InkWell(
                  onTap: () async {
                    final String? comment = await longTextFieldDialog(
                        title: 'Kommentar',
                        textinField: pupilListEntry.comment ?? '',
                        labelText: 'Kommentar eintragen',
                        parentContext: context);
                    if (comment == null) {
                      return;
                    }
                    await _schoolListManager.updatePupilListEntry(
                        entry: pupilListEntry, comment: (value: comment));
                  },
                  child: Text(
                    pupilListEntry.comment ?? 'kein Kommentar',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.interactiveColor,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
