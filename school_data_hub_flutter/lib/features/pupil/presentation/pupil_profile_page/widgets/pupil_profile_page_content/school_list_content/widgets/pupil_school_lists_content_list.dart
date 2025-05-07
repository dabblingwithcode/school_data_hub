import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/school_list_content/widgets/pupil_profile_school_list_pupil_entry_card.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();

class PupilSchoolListContentList extends WatchingWidget {
  final PupilProxy pupil;
  const PupilSchoolListContentList({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final pupilListEntriesProxyMaps = watchPropertyValue(
      (SchoolListManager m) => m.allPupilEntries,
    );
    final pupilListEntries = [
      ...pupilListEntriesProxyMaps
          .expand((element) => element.pupilEntries.values)
    ];
    final filteredPupilListEntries = pupilListEntries
        .where((element) => element.pupilEntry.pupilId == pupil.pupilId)
        .toList();

    return Column(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredPupilListEntries.length,
          itemBuilder: (BuildContext context, int index) {
            return PupilProfileSchoolListPupilEntryCard(
              pupilListEntryProxy: filteredPupilListEntries[index],
            );
          },
        ),
        const Gap(10)
      ],
    );
  }
}
