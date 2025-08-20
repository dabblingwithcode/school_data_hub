import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_page/workbook_list_page.dart';
import 'package:watch_it/watch_it.dart';

class WorkbookList extends StatefulWidget {
  const WorkbookList({
    super.key,
  });

  @override
  WorkbookListViewModel createState() => WorkbookListViewModel();
}

class WorkbookListViewModel extends State<WorkbookList> {
  @override
  void initState() {
    di<WorkbookManager>().fetchWorkbooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WorkbookListPage(this);
  }
}
