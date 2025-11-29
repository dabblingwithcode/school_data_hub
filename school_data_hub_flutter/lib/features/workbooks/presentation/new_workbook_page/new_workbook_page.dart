import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:watch_it/watch_it.dart';

class NewWorkbookPage extends WatchingWidget {
  final String? name;
  final int isbn;
  final String? subject;
  final String? level;
  final int? amount;
  final bool isEdit;
  final Workbook? workbook;

  const NewWorkbookPage({
    required this.isEdit,
    this.name,
    required this.isbn,
    this.subject,
    this.level,
    this.amount,
    this.workbook,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final workbookNameTextFieldController = createOnce(
      () => TextEditingController(),
    );
    final subjectTextFieldController = createOnce(
      () => TextEditingController(),
    );
    final levelTextFieldController = createOnce(() => TextEditingController());
    final amountTextFieldController = createOnce(() => TextEditingController());

    callOnce((context) async {
      await di<WorkbookManager>().fetchWorkbookByIsbn(isbn);
      // final workbook = di<WorkbookManager>()
      //     .workbooks
      //     .value
      //     .firstWhere((element) => element.isbn == isbn);
      if (isEdit) {
        workbookNameTextFieldController.text = name ?? '';
        subjectTextFieldController.text = subject ?? '';
        levelTextFieldController.text = level ?? '';
        amountTextFieldController.text = amount != null
            ? amount!.toString()
            : '';
      }
    });
    Future<void> updateWorkbook() async {
      await di<WorkbookManager>().updateWorkbookProperty(
        workbook: workbook!,
        name: workbookNameTextFieldController.text.isEmpty
            ? null
            : workbookNameTextFieldController.text,
        subject: subjectTextFieldController.text.isEmpty
            ? null
            : subjectTextFieldController.text,
        level: levelTextFieldController.text.isEmpty
            ? null
            : levelTextFieldController.text,
        amount: amountTextFieldController.text.isEmpty
            ? null
            : int.tryParse(amountTextFieldController.text),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Center(
          child: Text(
            (isEdit) ? 'Arbeitsheft bearbeiten' : 'Neues Arbeitsheft',
            style: AppStyles.appBarTextStyle,
          ),
        ),
      ),
      body: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Row(
                    children: [
                      Text('Image', style: AppStyles.subtitle),
                      // if (controller.workbookImage != null) ...<Widget>[
                      //   Expanded(
                      //     flex: 1,
                      //     child: Column(
                      //       children: [
                      //         ClipRRect(
                      //             borderRadius: BorderRadius.circular(10.0),
                      //             child: controller.workbookImage!),
                      //         const Gap(20),
                      //       ],
                      //     ),
                      //   ),
                      //   const Gap(10),
                      // ],
                      const Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [const Gap(20), Text('Placeholder ISBN')],
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    minLines: 2,
                    maxLines: 2,
                    controller: workbookNameTextFieldController,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Name des Heftes',
                    ),
                  ),
                  const Gap(20),

                  TextField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    minLines: 1,
                    maxLines: 1,
                    controller: subjectTextFieldController,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Fach',
                    ),
                  ),
                  const Gap(20),
                  TextField(
                    minLines: 1,
                    maxLines: 1,
                    controller: levelTextFieldController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Kompetenzstufe',
                    ),
                  ),
                  // const Gap(20),
                  // TextField(
                  //     style: const TextStyle(
                  //         color: Colors.black, fontWeight: FontWeight.bold),
                  //     minLines: 1,
                  //     maxLines: 1,
                  //     controller: controller.amountTextFieldController,
                  //     decoration:
                  //         AppStyles.textFieldDecoration(labelText: 'Bestand')),
                  const Gap(30),
                  if (!isEdit) ...<Widget>[
                    ElevatedButton(
                      style: AppStyles.actionButtonStyle,
                      onPressed: () {}, // async => controller.scanIsbn(),
                      child: const Text(
                        'ISBN SCANNEN',
                        style: AppStyles.buttonTextStyle,
                      ),
                    ),
                    const Gap(15),
                  ],
                  ElevatedButton(
                    style: AppStyles.successButtonStyle,
                    onPressed: () {
                      updateWorkbook();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'SENDEN',
                      style: AppStyles.buttonTextStyle,
                    ),
                  ),
                  const Gap(15),
                  ElevatedButton(
                    style: AppStyles.cancelButtonStyle,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ABBRECHEN',
                      style: AppStyles.buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
