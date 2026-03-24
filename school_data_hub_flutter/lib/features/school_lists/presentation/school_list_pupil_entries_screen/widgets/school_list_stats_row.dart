import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/models/school_list_pupil_entries_proxy.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_helper_functions.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';

class SchoolListStatsRow extends WatchingWidget {
  final SchoolList schoolList;
  final List<PupilProxy> pupils;
  const SchoolListStatsRow({
    super.key,
    required this.schoolList,
    required this.pupils,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schoolListManager = di<SchoolListManager>();
    watch<SchoolListPupilEntriesProxyMap>(
      schoolListManager.getPupilEntriesProxyFromSchoolList(schoolList.id!),
    );
    final Map<String, int> stats =
        SchoolListHelper.schoolListStatsForGivenPupils(schoolList, pupils);

    return Row(
      children: [
        InkWell(
          onLongPress: () async {
            final confirm = await confirmationDialog(
              context: context,
              title: 'Liste kopieren',
              message:
                  'Möchtest du eine neue Liste mit den gleichen Kindern erstellen?',
            );
            if (confirm != true) return;
            if (!context.mounted) return;
            context.push(RoutePaths.schoolListNew, extra: schoolList);
          },
          child: Icon(Icons.people_alt_rounded, color: style.colors.accent),
        ),
        const Gap(10),
        Text(
          pupils.length.toString(),
          style: context.typography.title.withColor(style.colors.foreground),
        ),
        const Gap(10),
        const Icon(Icons.close, color: Colors.red),
        const Gap(5),
        Text(
          stats['no'].toString(),
          style: context.typography.title.withColor(style.colors.foreground),
        ),
        const Gap(10),
        const Icon(Icons.done, color: Colors.green),
        const Gap(5),
        Text(
          stats['yes'].toString(),
          style: context.typography.title.withColor(style.colors.foreground),
        ),
        const Gap(10),
        Icon(Icons.question_mark_rounded, color: style.colors.accent),
        const Gap(5),
        Text(
          stats['null'].toString(),
          style: context.typography.title.withColor(style.colors.foreground),
        ),
        const Gap(10),
        Icon(Icons.create, color: style.colors.accent),
        const Gap(5),
        Text(
          stats['comment'].toString(),
          style: context.typography.title.withColor(style.colors.foreground),
        ),
      ],
    );
  }
}
