import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';

/// Filter chips and actions for the Matrix rooms list.
/// Shown inside the rooms filter bottom sheet.
class MatrixRoomsFiltersWidget extends WatchingWidget {
  const MatrixRoomsFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filterManager = di<MatrixPolicyFilterManager>();

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
                  Text('Filter', style: context.typography.title),
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

/// Shows the Matrix rooms filter bottom sheet (compulsory-room filter chips).
Future<void> showMatrixRoomsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const MatrixRoomsFiltersWidget(),
  );
}
