import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

import '../../domain/server_logs_manager.dart';

Future<void> showServerLogsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (_) => const ServerLogsFilterBottomSheet(),
  );
}

class ServerLogsFilterBottomSheet extends WatchingWidget {
  const ServerLogsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = di<ServerLogsManager>();
    final slow = watch(manager.slowFilter).value;
    final error = watch(manager.errorFilter).value;
    final open = watch(manager.openFilter).value;
    final endpoint = watch(manager.endpointFilter).value;
    final method = watch(manager.methodFilter).value;
    final filtersActive = watch(manager.filtersActive).value;

    final endpointController = createOnce(
      () => TextEditingController(text: endpoint ?? ''),
    );
    final methodController = createOnce(
      () => TextEditingController(text: method ?? ''),
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
                        endpointController.clear();
                        methodController.clear();
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
                      const Text('Session-Status', style: AppStyles.subtitle),
                      const Gap(12),
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          FilterChip(
                            label: Text(
                              'Langsam',
                              style: AppStyles.textLabel.copyWith(
                                fontWeight: FontWeight.bold,
                                color: slow ? Colors.white : Colors.black87,
                              ),
                            ),
                            avatar: Icon(
                              Icons.slow_motion_video,
                              size: 18,
                              color: slow
                                  ? Colors.white
                                  : AppColors.cardInCardBorderColor,
                            ),
                            selected: slow,
                            showCheckmark: false,
                            onSelected: (_) => manager.toggleSlow(),
                            backgroundColor: Colors.white,
                            selectedColor: AppColors.warningButtonColor,
                            side: BorderSide(
                              color: AppColors.cardInCardBorderColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                          FilterChip(
                            label: Text(
                              'Fehler',
                              style: AppStyles.textLabel.copyWith(
                                fontWeight: FontWeight.bold,
                                color: error ? Colors.white : Colors.black87,
                              ),
                            ),
                            avatar: Icon(
                              Icons.error_outline,
                              size: 18,
                              color: error
                                  ? Colors.white
                                  : AppColors.cardInCardBorderColor,
                            ),
                            selected: error,
                            showCheckmark: false,
                            onSelected: (_) => manager.toggleError(),
                            backgroundColor: Colors.white,
                            selectedColor: AppColors.dangerButtonColor,
                            side: BorderSide(
                              color: AppColors.cardInCardBorderColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                          FilterChip(
                            label: Text(
                              'Offen',
                              style: AppStyles.textLabel.copyWith(
                                fontWeight: FontWeight.bold,
                                color: open ? Colors.white : Colors.black87,
                              ),
                            ),
                            avatar: Icon(
                              Icons.hourglass_top,
                              size: 18,
                              color: open
                                  ? Colors.white
                                  : AppColors.cardInCardBorderColor,
                            ),
                            selected: open,
                            showCheckmark: false,
                            onSelected: (_) => manager.toggleOpen(),
                            backgroundColor: Colors.white,
                            selectedColor: Colors.blue.shade700,
                            side: BorderSide(
                              color: AppColors.cardInCardBorderColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                        ],
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
                      const Text('Endpoint / Methode', style: AppStyles.subtitle),
                      const Gap(12),
                      TextField(
                        controller: endpointController,
                        decoration: const InputDecoration(
                          labelText: 'Endpoint',
                          hintText: 'z.B. adminUser',
                          prefixIcon: Icon(Icons.api_outlined),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onSubmitted: manager.setEndpointFilter,
                      ),
                      const Gap(12),
                      TextField(
                        controller: methodController,
                        decoration: const InputDecoration(
                          labelText: 'Methode',
                          hintText: 'z.B. getAllUsers',
                          prefixIcon: Icon(Icons.functions_outlined),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onSubmitted: manager.setMethodFilter,
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
}
