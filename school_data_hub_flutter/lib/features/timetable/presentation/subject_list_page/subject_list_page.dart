import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_page/new_subject_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject_list_page/subject_list.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:flutter_it/flutter_it.dart';

class SubjectListPage extends WatchingWidget {
  const SubjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableManager = di<TimetableManager>();
    final subjects = watch(timetableManager.subjects);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(iconData: Icons.subject, title: 'Fächer'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SubjectList(
            subjects: subjects.value,
            onSubjectTap: (Subject subject) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewSubjectPage(subject: subject),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
            tooltip: 'Neues Fach',
            icon: const Icon(Icons.add, size: 35),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewSubjectPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
