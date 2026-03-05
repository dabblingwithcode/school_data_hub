import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart'
    as workbookEnum;
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/common/workbook_image.dart';

class NewWorkbookPage extends WatchingWidget {
  final int isbn;

  final int? amount;
  final bool isEdit;
  final Workbook? workbook;

  const NewWorkbookPage({
    required this.isEdit,

    required this.isbn,

    this.amount,
    this.workbook,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final workbookNameTextFieldController = createOnce(
      () => TextEditingController(),
    );
    final selectedSubject =
        createOnce<ValueNotifier<workbookEnum.SubjectEnum?>>(
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

      if (isEdit) {
        workbookNameTextFieldController.text = workbook!.name;
        if (workbook!.subject != null) {
          selectedSubject.value = workbookEnum.SubjectEnum.values
              .cast<workbookEnum.SubjectEnum?>()
              .firstWhere(
                (s) =>
                    s?.name == workbook!.subject ||
                    s?.code == workbook!.subject,
                orElse: () => null,
              );
        }
        if (workbook!.level != null && workbook!.level!.isNotEmpty) {
          final levelNames = workbook!.level!
              .split(',')
              .map((l) => l.trim())
              .toSet();
          selectedGrades.value = workbookEnum.Grade.values
              .where((g) => levelNames.contains(g.name))
              .toSet();
        }
        amountTextFieldController.text = workbook!.amount != null
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

                  DropdownButtonFormField<workbookEnum.SubjectEnum>(
                    initialValue: currentSubject,
                    isDense: false,
                    itemHeight: 50,
                    decoration: AppStyles.textFieldDecoration(labelText: 'Fach')
                        .copyWith(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    items: workbookEnum.SubjectEnum.values.map((subject) {
                      return DropdownMenuItem<workbookEnum.SubjectEnum>(
                        value: subject,
                        child: Row(
                          children: [
                            if (subject.imagePath != null) ...[
                              _SubjectIcon(imagePath: subject.imagePath!),
                              const Gap(8),
                            ],
                            Text(subject.name),
                          ],
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) {
                      return workbookEnum.SubjectEnum.values.map((subject) {
                        return SizedBox(
                          height: 56,
                          child: Row(
                            children: [
                              if (subject.imagePath != null) ...[
                                _SubjectIcon(imagePath: subject.imagePath!),
                                const Gap(8),
                              ],
                              Text(subject.name),
                            ],
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (workbookEnum.SubjectEnum? newValue) {
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
                          showCheckmark: false,
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

class _SubjectIcon extends StatelessWidget {
  final String imagePath;

  const _SubjectIcon({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: ClipRect(
        child: Align(
          alignment: Alignment.center,
          widthFactor: 0.75,
          heightFactor: 0.75,
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
