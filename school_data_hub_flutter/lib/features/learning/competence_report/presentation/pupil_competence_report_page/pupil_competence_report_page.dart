import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/new_competence_report_page/new_competence_report_page.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/pupil_competence_report_page/widgets/competence_report_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class PupilCompetenceReportPage extends WatchingWidget {
  final PupilProxy pupil;

  const PupilCompetenceReportPage({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final manager = di<CompetenceReportManager>();

    callOnce((_) => manager.fetchReportsForPupil(pupil.pupilId));

    final reportsByPupil = watchValue(
      (CompetenceReportManager x) => x.reportsByPupil,
    );
    final reports = reportsByPupil[pupil.pupilId] ?? <CompetenceReport>[];

    return Scaffold(
      appBar: GenericAppBar(
        iconData: Icons.assignment,
        title: 'Zeugnisse - ${pupil.firstName} ${pupil.lastName}',
      ),
      body: RefreshIndicator(
        onRefresh: () async => manager.fetchReportsForPupil(pupil.pupilId),
        child: reports.isEmpty
            ? const Center(
                child: Text(
                  'Keine Zeugnisse vorhanden',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return CompetenceReportCard(
                    report: reports[index],
                    pupilId: pupil.pupilId,
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomAppBar(
          height: 60,
          padding: const EdgeInsets.all(10),
          shape: null,
          color: AppColors.backgroundColor,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  tooltip: 'zurück',
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'aktualisieren',
                  icon: const Icon(Icons.update_rounded),
                  onPressed: () => manager.fetchReportsForPupil(pupil.pupilId),
                ),
                const Gap(30),
                IconButton(
                  tooltip: 'Neues Zeugnis',
                  icon: const Icon(Icons.add, size: 30),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => NewCompetenceReportPage(pupil: pupil),
                      ),
                    );
                  },
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
