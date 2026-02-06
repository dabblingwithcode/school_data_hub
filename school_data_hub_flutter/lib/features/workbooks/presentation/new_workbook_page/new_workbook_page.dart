import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart'
    as workbookEnum;
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/common/workbook_image.dart';
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
    final selectedSubject = createOnce<ValueNotifier<workbookEnum.Subject?>>(
      () => ValueNotifier(null),
      dispose: (notifier) => notifier.dispose(),
    );
    final selectedGrades = createOnce<ValueNotifier<Set<workbookEnum.Grade>>>(
      () => ValueNotifier(<workbookEnum.Grade>{}),
      dispose: (notifier) => notifier.dispose(),
    );
    final amountTextFieldController = createOnce(() => TextEditingController());

    // Watch at top level to avoid conditional watch errors
    final currentSubject = watch(selectedSubject).value;
    final currentGrades = watch(selectedGrades).value;

    callOnce((context) async {
      await di<WorkbookManager>().fetchWorkbookByIsbn(isbn);
      // final workbook = di<WorkbookManager>()
      //     .workbooks
      //     .value
      //     .firstWhere((element) => element.isbn == isbn);
      if (isEdit) {
        workbookNameTextFieldController.text = name ?? '';
        if (subject != null) {
          selectedSubject.value = workbookEnum.Subject.values
              .cast<workbookEnum.Subject?>()
              .firstWhere(
                (s) => s?.name == subject || s?.code == subject,
                orElse: () => null,
              );
        }
        if (level != null && level!.isNotEmpty) {
          final levelNames = level!.split(',').map((l) => l.trim()).toSet();
          selectedGrades.value = workbookEnum.Grade.values
              .where((g) => levelNames.contains(g.name))
              .toSet();
        }
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
        subject: selectedSubject.value?.name,
        level: selectedGrades.value.isEmpty
            ? null
            : selectedGrades.value.map((g) => g.name).join(','),
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
                  Row(
                    children: [
                      WorkbookImage(workbook: workbook!),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(workbook!.isbn.toString())],
                      ),
                    ],
                  ),
                  const Gap(20),
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

                  DropdownButtonFormField<workbookEnum.Subject>(
                    initialValue: currentSubject,
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Fach',
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    items: workbookEnum.Subject.values.map((subject) {
                      return DropdownMenuItem<workbookEnum.Subject>(
                        value: subject,
                        child: Text(subject.name),
                      );
                    }).toList(),
                    onChanged: (workbookEnum.Subject? newValue) {
                      selectedSubject.value = newValue;
                    },
                  ),
                  const Gap(20),
                  InputDecorator(
                    decoration: AppStyles.textFieldDecoration(
                      labelText: 'Kompetenzstufe',
                    ),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: workbookEnum.Grade.values.map((grade) {
                        final isSelected = currentGrades.contains(grade);
                        return FilterChip(
                          avatar: Image.asset(grade.imagePath, width: 20),
                          label: Text(grade.name),
                          selected: isSelected,
                          onSelected: (selected) {
                            final currentSet = Set<workbookEnum.Grade>.from(
                              selectedGrades.value,
                            );
                            if (selected) {
                              currentSet.add(grade);
                            } else {
                              currentSet.remove(grade);
                            }
                            selectedGrades.value = currentSet;
                          },
                        );
                      }).toList(),
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
