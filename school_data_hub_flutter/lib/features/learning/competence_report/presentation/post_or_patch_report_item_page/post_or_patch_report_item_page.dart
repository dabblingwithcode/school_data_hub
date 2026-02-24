import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/report_item_list_scope_state.dart';

Set<int> _getDescendantIds(int publicId, List<CompetenceReportItem> allItems) {
  final descendants = <int>{};
  final children = allItems
      .where((i) => i.parentItem == publicId)
      .map((i) => i.publicId);
  for (final childId in children) {
    descendants.add(childId);
    descendants.addAll(_getDescendantIds(childId, allItems));
  }
  return descendants;
}

class PostOrPatchReportItemPage extends WatchingWidget {
  final int? parentItem;
  final CompetenceReportItem? item;

  const PostOrPatchReportItemPage({super.key, this.parentItem, this.item});

  @override
  Widget build(BuildContext context) {
    final manager = di<CompetenceReportItemManager>();
    final allItems = watchValue((CompetenceReportItemManager m) => m.items);

    final nameController = createOnce(
      () => TextEditingController(text: item?.name ?? ''),
    );
    final selectedGrades = createOnce(() {
      final initial = <SchoolGrade>{};
      if (item?.level != null) {
        for (final value in item!.level!) {
          try {
            initial.add(SchoolGrade.fromJson(value));
          } catch (_) {}
        }
      } else {
        final scopeState = di.maybeGet<ReportItemListScopeState>();
        if (scopeState != null) {
          Logger('Scoped grades: ${scopeState.lastGrades.value}').info;
          initial.addAll(scopeState.lastGrades.value);
        }
      }
      return ValueNotifier<Set<SchoolGrade>>(initial);
    });
    final selectedParent = createOnce(
      () => ValueNotifier<int?>(item != null ? item!.parentItem : parentItem),
    );

    final parentValue = watch(selectedParent).value;
    final grades = watch(selectedGrades).value;

    final excludedIds = <int>{};
    if (item != null) {
      excludedIds.add(item!.publicId);
      excludedIds.addAll(_getDescendantIds(item!.publicId, allItems));
    }
    final parentOptions = allItems
        .where((i) => !excludedIds.contains(i.publicId))
        .toList();

    void toggleGrade(SchoolGrade grade, bool add) {
      final updated = Set<SchoolGrade>.from(grades);
      if (add) {
        updated.add(grade);
      } else {
        updated.remove(grade);
      }
      selectedGrades.value = updated;
    }

    List<String> gradeValues() => grades.map((g) => g.name).toList();

    void postNew() async {
      if (grades.isEmpty) {
        informationDialog(
          context,
          'Stufe auswählen',
          'Bitte mindestens eine Stufe auswählen!',
        );
        return;
      }
      Navigator.pop(context);
      await manager.postNewItem(
        parentItem: selectedParent.value,
        name: nameController.text,
        level: gradeValues(),
      );
      di.maybeGet<ReportItemListScopeState>()?.lastGrades.value = Set.from(
        grades,
      );
    }

    void patch() async {
      if (grades.isEmpty) {
        informationDialog(
          context,
          'Stufe auswählen',
          'Bitte mindestens eine Stufe auswählen!',
        );
        return;
      }
      final updated = item!.copyWith(
        parentItem: selectedParent.value,
        name: nameController.text,
        level: gradeValues(),
      );
      Navigator.pop(context);
      await manager.updateItem(updated);
    }

    return Scaffold(
      appBar: GenericAppBar(
        iconData: Icons.edit_document,
        title: item != null
            ? 'Zeugniskompetenz überarbeiten'
            : 'Neue Zeugniskompetenz',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Übergeordnete Kompetenz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                InputDecorator(
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Übergeordnete Kompetenz',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int?>(
                      value: parentValue,
                      isExpanded: true,
                      isDense: true,
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('Keine (Hauptkategorie)'),
                        ),
                        ...parentOptions.map(
                          (i) => DropdownMenuItem<int?>(
                            value: i.publicId,
                            child: Text(
                              i.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) => selectedParent.value = value,
                    ),
                  ),
                ),
                const Gap(10),
                const Text(
                  'Kompetenz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: nameController,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Name der Kompetenz',
                  ),
                ),
                const Gap(10),
                const Text(
                  'Kompetenzstufe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (final grade in SchoolGrade.values)
                      ThemedFilterChip(
                        label: grade.name,
                        selected: grades.contains(grade),
                        onSelected: (v) => toggleGrade(grade, v),
                      ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: () {
                    item == null ? postNew() : patch();
                  },
                  child: const Text('SENDEN', style: AppStyles.buttonTextStyle),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () => Navigator.pop(context),
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
    );
  }
}
