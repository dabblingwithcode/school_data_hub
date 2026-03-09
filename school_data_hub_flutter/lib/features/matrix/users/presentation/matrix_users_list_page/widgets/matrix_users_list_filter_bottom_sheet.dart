import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_user_filter_category.dart';

class MatrixUsersListFilterBottomSheet extends WatchingWidget {
  const MatrixUsersListFilterBottomSheet({super.key});

  static const Map<MatrixUserFilterCategory, String> _labels = {
    MatrixUserFilterCategory.pupil: 'SuS',
    MatrixUserFilterCategory.parent: 'Eltern',
    MatrixUserFilterCategory.familyParent: 'Familieneltern',
    MatrixUserFilterCategory.staff: 'Mitarbeiter',
    MatrixUserFilterCategory.noRelation: 'Ohne Zuordnung',
  };

  @override
  Widget build(BuildContext context) {
    final filterManager = di<MatrixPolicyFilterManager>();
    final includedSet =
        watchValue((MatrixPolicyFilterManager x) => x.includedCategories);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Filter', style: AppStyles.title),
                  const Spacer(),
                  IconButton.filled(
                    tooltip: 'Zurücksetzen',
                    iconSize: 28,
                    onPressed: () {
                      filterManager.resetAllMatrixFilters();
                    },
                    icon: const Icon(Icons.restart_alt_rounded),
                  ),
                ],
              ),
              const Gap(12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: MatrixUserFilterCategory.values.map((cat) {
                  final selected =
                      includedSet.isNotEmpty && includedSet.contains(cat);
                  return ThemedFilterChip(
                    label: _labels[cat]!,
                    selected: selected,
                    onSelected: (_) => filterManager.toggleCategory(cat),
                  );
                }).toList(),
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      filterManager.resetAllMatrixFilters();
                    },
                    child: const Text('Zurücksetzen'),
                  ),
                  const Gap(8),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Fertig'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showMatrixUsersListFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const MatrixUsersListFilterBottomSheet(),
  );
}
