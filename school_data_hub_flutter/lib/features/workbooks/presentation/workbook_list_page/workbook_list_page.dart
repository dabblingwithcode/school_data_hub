import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_page/controller/workbook_list_view_model.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_page/widgets/workbook_card.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_page/new_workbook_page.dart';

class WorkbookListPage extends WatchingWidget {
  final WorkbookListViewModel viewModel;
  const WorkbookListPage(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);

    //Session session = watchValue((SessionManager x) => x.credentials);
    List<Workbook> workbooks = watchValue((WorkbookManager x) => x.workbooks);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_alt_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text('Arbeitshefte', style: AppStyles.appBarTextStyle),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<WorkbookManager>().fetchWorkbooks(),
        child: workbooks.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Es wurden noch keine Arbeitshefte angelegt!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          top: 15.0,
                          right: 10.00,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Gesamt:',
                              style: TextStyle(fontSize: 13),
                            ),
                            const Gap(10),
                            Text(
                              workbooks.length.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: PupilSearchTextField(
                                searchType: SearchType.workbook,
                                hintText: 'Arbeitsheft suchen',
                                refreshFunction:
                                    di<WorkbookManager>().fetchWorkbooks,
                              ),
                            ),
                            //---------------------------------
                            InkWell(
                              onTap: () {},

                              onLongPress: () =>
                                  di<PupilsFilter>().resetFilters(),
                              // onPressed: () => showBottomSheetFilters(context),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.filter_list,
                                  color: filtersOn
                                      ? Colors.deepOrange
                                      : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      workbooks.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Keine Ergebnisse',
                                  style: TextStyle(fontSize: 18),
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
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          IconButton(
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
                          NewWorkbookPage(isEdit: false, isbn: isbn!),
                    ),
                  );
                }
                return;
              }
              if (!context.mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => NewWorkbookPage(isbn: isbn!, isEdit: false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
