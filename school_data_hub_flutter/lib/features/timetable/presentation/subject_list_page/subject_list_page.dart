import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/new_subject_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject_list_page/widgets/subject_list_card.dart';
import 'package:flutter_it/flutter_it.dart';

class SubjectListPage extends WatchingWidget {
  const SubjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();

    return GenericListPage<Subject>(
      backgroundColor: AppColors.canvasColor,
      iconData: Icons.subject,
      title: 'Fächer',
      itemsListenable: timetableManager.subjects,
      itemBuilder: (context, subject) => SubjectListCard(
        subject: subject,
        onTap: () => _navigateToSubject(context, subject),
      ),
      onRefresh: () async => timetableManager.refreshData(),
      emptyMessage: 'Keine Fächer verfügbar',
      maxWidth: 800,
      bottomBarActions: [
        IconButton(
          tooltip: 'Neues Fach',
          icon: const Icon(Icons.add, size: 35),
          onPressed: () => _navigateToNewSubject(context),
        ),
      ],
    );
  }

  void _navigateToNewSubject(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const NewSubjectPage(),
      ),
    );
    await di<TimetableManager>().refreshData();
  }

  void _navigateToSubject(BuildContext context, Subject subject) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => NewSubjectPage(subject: subject),
      ),
    );
    await di<TimetableManager>().refreshData();
  }
}
