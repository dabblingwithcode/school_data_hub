import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_screen/new_workbook_screen.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_screen/widgets/workbook_card.dart';

class WorkbookListScreen extends WatchingWidget {
  const WorkbookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workbookManager = di<WorkbookManager>();
    final pupilsFilter = di<PupilsFilter>();
    final filtersStateManager = di<FiltersStateManager>();

    callOnce((context) => workbookManager.fetchWorkbooks());

    return ListScreen<Workbook>(
      iconData: Icons.note_alt_rounded,
      title: 'Arbeitshefte',
      backgroundColor: Style.of(context).colors.canvas,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: const _WorkbookStatsWidget(),
        searchType: SearchType.workbook,
        hintText: 'Arbeitsheft suchen',
        refreshFunction: workbookManager.fetchWorkbooks,
        onChanged: (value) => pupilsFilter.textFilter.setFilterText(value),
        filtersActive: filtersStateManager.filtersActive,
        onResetFilters: pupilsFilter.resetFilters,
      ),
      itemsListenable: workbookManager.workbooks,
      itemBuilder: (context, workbook) =>
          WorkbookCard(key: ValueKey(workbook.isbn), workbook: workbook),
      onRefresh: () async => workbookManager.fetchWorkbooks(),
      emptyMessage: 'Es wurden noch keine Arbeitshefte angelegt!',
      bottomBarActions: [
        TappableIcon(
          tooltip: 'Neues Arbeitsheft',
          icon: const Icon(Icons.add, size: 35),
          onPressed: () async {
            int? isbn;
            if (Platform.isAndroid || Platform.isIOS) {
              final scanResult = await qrScanner(
                context: context,
                overlayText: 'ISBN code scannen',
              );
              if (scanResult == null) return;
              isbn = int.parse(scanResult);
            } else {
              final isbnText = await shortTextfieldDialog(
                context: context,
                title: 'ISBN',
                hintText: 'ISBN',
                labelText: 'ISBN',
              );
              if (isbnText == null) return;
              isbn = int.tryParse(isbnText);
            }
            if (isbn == null) return;
            if (!context.mounted) return;
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute<void>(
                builder: (ctx) => NewWorkbookScreen(isEdit: false, isbn: isbn!),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _WorkbookStatsWidget extends WatchingWidget {
  const _WorkbookStatsWidget();

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final workbooks = watchValue((WorkbookManager x) => x.workbooks);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
      child: Row(
        children: [
          Text('Gesamt:', style: context.typography.bodySmall),
          const Gap(10),
          Text(
            workbooks.length.toString(),
            style: context.typography.title.withColor(style.colors.foreground),
          ),
        ],
      ),
    );
  }
}
