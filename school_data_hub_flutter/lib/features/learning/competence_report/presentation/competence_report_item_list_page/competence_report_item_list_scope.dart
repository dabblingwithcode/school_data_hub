import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/report_item_list_scope_state.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_page/competence_report_item_list_page.dart';

/// Wrapper that pushes a get_it scope when entering the report item list flow
/// and pops it when leaving. The scope holds [ReportItemListScopeState] (e.g. last selected grades).
class CompetenceReportItemListScope extends StatefulWidget {
  const CompetenceReportItemListScope({super.key});

  @override
  State<CompetenceReportItemListScope> createState() =>
      _CompetenceReportItemListScopeState();
}

class _CompetenceReportItemListScopeState
    extends State<CompetenceReportItemListScope> {
  static const _scopeName = 'competence_report_item_list';

  @override
  void initState() {
    super.initState();
    di.pushNewScope(
      scopeName: _scopeName,
      init: (getIt) {
        getIt.registerSingleton<ReportItemListScopeState>(
          ReportItemListScopeState(),
          dispose: (s) => s.dispose(),
        );
        Logger('Scoped state registered').info;
      },
    );
  }

  @override
  void dispose() {
    di.popScope();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const CompetenceReportItemListPage();
}
