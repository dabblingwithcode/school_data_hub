import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/picker.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart'
    // ignore: library_prefixes
    as workbookEnum;
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/common/workbook_image.dart';

class NewWorkbookScreen extends WatchingWidget {
  final int isbn;

  final int? amount;
  final bool isEdit;
  final Workbook? workbook;

  const NewWorkbookScreen({
    required this.isEdit,
    required this.isbn,
    this.amount,
    this.workbook,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
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

    return ColoredBox(
      color: style.colors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: style.colors.accent,
              padding: EdgeInsets.symmetric(
                horizontal: Style.spacing.lg,
                vertical: Style.spacing.md,
              ),
              child: Center(
                child: Text(
                  (isEdit) ? 'Arbeitsheft bearbeiten' : 'Neues Arbeitsheft',
                  style: context.typography.title.withColor(
                    style.colors.background,
                  ),
                ),
              ),
            ),
            // Body
            Expanded(
              child: Center(
                heightFactor: 1,
                child: Padding(
                  padding: EdgeInsets.all(Style.spacing.lg),
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
                                children: [
                                  Text(
                                    workbook!.isbn.toString(),
                                    style: context.typography.body,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Gap(Style.spacing.xl),
                          TextField(
                            style: context.typography.body.bold.withColor(
                              style.colors.foreground,
                            ),
                            minLines: 2,
                            maxLines: 2,
                            controller: workbookNameTextFieldController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.all(Style.spacing.sm + 2),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: style.colors.accent,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: style.colors.accent,
                                  width: 2,
                                ),
                              ),
                              labelStyle: context.typography.body.withColor(
                                style.colors.accent,
                              ),
                              labelText: 'Name des Heftes',
                            ),
                          ),
                          Gap(Style.spacing.xl),
                          Picker<workbookEnum.SubjectEnum>(
                            label: 'Fach',
                            value: currentSubject,
                            items: workbookEnum.SubjectEnum.values,
                            itemLabel: (subject) => subject.name,
                            onChanged: (workbookEnum.SubjectEnum newValue) {
                              selectedSubject.value = newValue;
                            },
                          ),
                          Gap(Style.spacing.xl),
                          InputDecorator(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.all(Style.spacing.sm + 2),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: style.colors.accent,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: style.colors.accent,
                                  width: 2,
                                ),
                              ),
                              labelStyle: context.typography.body.withColor(
                                style.colors.accent,
                              ),
                              labelText: 'Kompetenzstufe',
                            ),
                            child: Wrap(
                              spacing: Style.spacing.sm,
                              runSpacing: Style.spacing.xs,
                              children:
                                  workbookEnum.Grade.values.map((grade) {
                                    final isSelected =
                                        currentGrades.contains(grade);
                                    return FilterChip(
                                      avatar: Image.asset(
                                        grade.imagePath,
                                        width: 20,
                                      ),
                                      label: Text(grade.name),
                                      selected: isSelected,
                                      showCheckmark: false,
                                      onSelected: (selected) {
                                        final currentSet =
                                            Set<workbookEnum.Grade>.from(
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
                          Gap(Style.spacing.xxl),
                          if (!isEdit) ...<Widget>[
                            Button(
                              variant: ButtonVariant.secondary,
                              onPressed: () {}, // async => controller.scanIsbn(),
                              label: 'ISBN SCANNEN',
                            ),
                            Gap(Style.spacing.lg),
                          ],
                          Button(
                            variant: ButtonVariant.primary,
                            onPressed: () {
                              updateWorkbook();
                              Navigator.pop(context);
                            },
                            label: 'SENDEN',
                          ),
                          Gap(Style.spacing.lg),
                          Button(
                            variant: ButtonVariant.destructive,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: 'ABBRECHEN',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
