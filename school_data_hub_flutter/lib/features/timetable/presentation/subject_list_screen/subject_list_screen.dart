import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject_list_screen/widgets/subject_list_card.dart';

class SubjectListScreen extends WatchingWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    return ListScreen<Subject>(
      iconData: Icons.subject,
      title: 'Fächer',
      itemsListenable: timetableManager.data.subjects,
      itemBuilder: (context, subject) => SubjectListCard(
        subject: subject,
        onTap: () => _navigateToSubject(context, subject),
      ),
      onRefresh: () async => timetableManager.refreshData(),
      emptyMessage: 'Keine Fächer verfügbar',
      maxWidth: 800,
      bottomBarActions: [
        TappableIcon(
          icon: const Icon(Icons.add, size: 30),
          onPressed: () => _navigateToNewSubject(context),
        ),
      ],
    );
  }

  void _navigateToNewSubject(BuildContext context) async {
    await context.push(RoutePaths.toolsTimetableNewSubject);
    await di<TimetableManager>().refreshData();
  }

  void _navigateToSubject(BuildContext context, Subject subject) async {
    await context.push(RoutePaths.toolsTimetableNewSubject, extra: subject);
    await di<TimetableManager>().refreshData();
  }
}
