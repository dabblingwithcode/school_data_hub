import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/search_input.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/empty_state.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_screen/new_workbook_screen.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_screen/widgets/workbook_card.dart';

class WorkbookListScreen extends WatchingWidget {
  const WorkbookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    callOnce((context) => di<WorkbookManager>().fetchWorkbooks());
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    List<Workbook> workbooks = watchValue((WorkbookManager x) => x.workbooks);

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.note_alt_rounded,
        title: 'Arbeitshefte',
      ),

      body: RefreshIndicator(
        onRefresh: () async => di<WorkbookManager>().fetchWorkbooks(),
        child: workbooks.isEmpty
            ? const EmptyState(
                title: 'Keine Arbeitshefte',
                description:
                    'Es wurden noch keine Arbeitshefte angelegt!',
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Style.spacing.md,
                          top: Style.spacing.lg,
                          right: Style.spacing.md,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Gesamt:',
                              style: context.typography.bodySmall,
                            ),
                            Gap(Style.spacing.sm),
                            Text(
                              workbooks.length.toString(),
                              style: context.typography.title.withColor(
                                style.colors.foreground,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Style.spacing.sm + 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchInput(
                                searchType: SearchType.workbook,
                                hintText: 'Arbeitsheft suchen',
                                refreshFunction:
                                    di<WorkbookManager>().fetchWorkbooks,
                                onChanged: (value) => di<PupilsFilter>()
                                    .textFilter
                                    .setFilterText(value),
                                filtersActive:
                                    di<FiltersStateManager>().filtersActive,
                                onResetFilters: di<PupilsFilter>().resetFilters,
                              ),
                            ),
                            TappableIcon(
                              tooltip: 'Filter zurücksetzen',
                              icon: Icon(
                                Icons.filter_list,
                                color: filtersOn
                                    ? style.colors.warning
                                    : style.colors.mutedForeground,
                                size: 30,
                              ),
                              onPressed: filtersOn
                                  ? () => di<PupilsFilter>().resetFilters()
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      workbooks.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.all(Style.spacing.sm),
                                child: Text(
                                  'Keine Ergebnisse',
                                  style: context.typography.subtitle,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: workbooks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return WorkbookCard(
                                    key: ValueKey(workbooks[index].isbn),
                                    workbook: workbooks[index],
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: ActionBar(
        actions: [
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
              final workbookManager = di<WorkbookManager>();
              if (!workbookManager.workbooks.value.any(
                (element) => element.isbn == isbn,
              )) {
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (ctx) =>
                          NewWorkbookScreen(isEdit: false, isbn: isbn!),
                    ),
                  );
                }
                return;
              }
              if (!context.mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) =>
                      NewWorkbookScreen(isbn: isbn!, isEdit: false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
