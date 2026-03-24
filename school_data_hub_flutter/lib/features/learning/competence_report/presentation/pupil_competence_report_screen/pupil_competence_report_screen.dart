import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/pupil_competence_report_screen/widgets/competence_report_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class PupilCompetenceReportScreen extends WatchingWidget {
  final PupilProxy pupil;

  const PupilCompetenceReportScreen({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final manager = di<CompetenceReportManager>();

    callOnce((_) => manager.fetchReportsForPupil(pupil.pupilId));

    final reportsByPupil = watchValue(
      (CompetenceReportManager x) => x.reportsByPupil,
    );
    final reports = reportsByPupil[pupil.pupilId] ?? <CompetenceReport>[];

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppHeader(
        iconData: Icons.assignment,
        title: 'Zeugnisse - ${pupil.firstName} ${pupil.lastName}',
      ),
      body: RefreshIndicator(
        onRefresh: () async => manager.fetchReportsForPupil(pupil.pupilId),
        child: reports.isEmpty
            ? Center(
                child: Text(
                  'Keine Zeugnisse vorhanden',
                  style: context.typography.subtitle,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(Style.spacing.md),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return CompetenceReportCard(
                    report: reports[index],
                    pupilId: pupil.pupilId,
                  );
                },
              ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
          TappableIcon(
            tooltip: 'aktualisieren',
            icon: const Icon(Icons.update_rounded, size: 30),
            onPressed: () => manager.fetchReportsForPupil(pupil.pupilId),
          ),
          TappableIcon(
            tooltip: 'Neues Zeugnis',
            icon: const Icon(Icons.add, size: 30),
            onPressed: () {
              context.push(
                RoutePaths.learningCompetenceReportNew,
                extra: pupil,
              );
            },
          ),
        ],
      ),
    );
  }
}
