import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/new_subject_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject/subject_list_page/widgets/subject_list_card.dart';
import 'package:flutter_it/flutter_it.dart';

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
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const NewSubjectScreen(),
      ),
    );
    await di<TimetableManager>().refreshData();
  }

  void _navigateToSubject(BuildContext context, Subject subject) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => NewSubjectScreen(subject: subject),
      ),
    );
    await di<TimetableManager>().refreshData();
  }
}
