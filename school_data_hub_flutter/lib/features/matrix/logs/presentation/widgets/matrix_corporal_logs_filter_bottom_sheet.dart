import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

import '../../domain/matrix_corporal_logs_manager.dart';

const List<String> _logLevels = [
  'trace',
  'debug',
  'info',
  'warning',
  'error',
  'fatal',
  'panic',
];

Future<void> showMatrixCorporalLogsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (_) => const MatrixCorporalLogsFilterBottomSheet(),
  );
}

class MatrixCorporalLogsFilterBottomSheet extends WatchingWidget {
  const MatrixCorporalLogsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = di<MatrixCorporalLogsManager>();
    final levelSet = watch(manager.levelFilter).value;
    final message = watch(manager.messageFilter).value;
    final filtersActive = watch(manager.filtersActive).value;

    final messageController = createOnce(
      () => TextEditingController(text: message ?? ''),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Filter', style: AppStyles.subtitle),
                  const Spacer(),
                  if (filtersActive)
                    TextButton.icon(
                      onPressed: () {
                        manager.resetFilters();
                        messageController.clear();
                      },
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Zurücksetzen'),
                    ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    tooltip: 'Schließen',
                  ),
                ],
              ),
              const Gap(8),
              Card(
                color: AppColors.pupilProfileCardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Log-Level', style: AppStyles.subtitle),
                      const Gap(12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _logLevels.map((level) {
                          final selected =
                              levelSet != null && levelSet.contains(level);
                          final color = _colorForLevel(level);
                          return FilterChip(
                            label: Text(
                              level,
                              style: AppStyles.textLabel.copyWith(
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.white : Colors.black87,
                              ),
                            ),
                            selected: selected,
                            showCheckmark: false,
                            onSelected: (_) => manager.toggleLevel(level),
                            backgroundColor: Colors.white,
                            selectedColor: color,
                            side: BorderSide(
                              color: AppColors.cardInCardBorderColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              Card(
                color: AppColors.pupilProfileCardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nachricht', style: AppStyles.subtitle),
                      const Gap(12),
                      TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          labelText: 'Nachricht enthält',
                          hintText: 'z.B. Fehler',
                          prefixIcon: Icon(Icons.message_outlined),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onSubmitted: manager.setMessageFilter,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _colorForLevel(String level) {
    switch (level) {
      case 'error':
      case 'fatal':
      case 'panic':
        return AppColors.dangerButtonColor;
      case 'warning':
        return AppColors.warningButtonColor;
      case 'info':
        return Colors.blue.shade700;
      case 'debug':
      case 'trace':
        return Colors.grey.shade700;
      default:
        return Colors.green.shade700;
    }
  }
}
