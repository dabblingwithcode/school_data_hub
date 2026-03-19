import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_user_filter_category.dart';

/// Filter chips for matrix user categories.
/// Designed to be passed as a child in [GenericListPage.filterSheetChildren].
class MatrixUsersFilterChips extends WatchingWidget {
  const MatrixUsersFilterChips({super.key});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Text('Kategorie', style: context.typography.subtitle)]),
        const Gap(5),
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
      ],
    );
  }
}
