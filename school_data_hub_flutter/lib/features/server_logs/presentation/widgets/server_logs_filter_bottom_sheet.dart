import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/features/server_logs/domain/server_logs_manager.dart';

Future<void> showServerLogsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Style.radii.large),
        topRight: Radius.circular(Style.radii.large),
      ),
    ),
    builder: (_) => const ServerLogsFilterBottomSheet(),
  );
}

class ServerLogsFilterBottomSheet extends WatchingWidget {
  const ServerLogsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
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
        padding: EdgeInsets.fromLTRB(
          Style.spacing.xl,
          Style.spacing.md,
          Style.spacing.xl,
          Style.spacing.xl,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Filter', style: context.typography.subtitle),
                  const Spacer(),
                  if (filtersActive)
                    Button.small(
                      onPressed: () {
                        manager.resetFilters();
                        endpointController.clear();
                        methodController.clear();
                      },
                      icon: const Icon(Icons.restart_alt),
                      label: 'Zurücksetzen',
                      variant: ButtonVariant.ghost,
                    ),
                  TappableIcon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    tooltip: 'Schließen',
                  ),
                ],
              ),
              Gap(Style.spacing.sm),
              CardBox(
                padding: EdgeInsets.all(Style.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Session-Status',
                      style: context.typography.subtitle,
                    ),
                    Gap(Style.spacing.md),
                    Wrap(
                      spacing: Style.spacing.lg,
                      runSpacing: Style.spacing.md,
                      children: [
                        FilterChip(
                          label: Text(
                            'Langsam',
                            style: context.typography.bodySmall.bold.withColor(
                              slow
                                  ? style.colors.background
                                  : style.colors.foreground,
                            ),
                          ),
                          avatar: Icon(
                            Icons.slow_motion_video,
                            size: 18,
                            color: slow
                                ? style.colors.background
                                : style.colors.mutedForeground,
                          ),
                          selected: slow,
                          showCheckmark: false,
                          onSelected: (_) => manager.toggleSlow(),
                          backgroundColor: style.colors.background,
                          selectedColor: style.colors.warning,
                          side: BorderSide(color: style.colors.border),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: Style.spacing.sm,
                          ),
                        ),
                        FilterChip(
                          label: Text(
                            'Fehler',
                            style: context.typography.bodySmall.bold.withColor(
                              error
                                  ? style.colors.background
                                  : style.colors.foreground,
                            ),
                          ),
                          avatar: Icon(
                            Icons.error_outline,
                            size: 18,
                            color: error
                                ? style.colors.background
                                : style.colors.mutedForeground,
                          ),
                          selected: error,
                          showCheckmark: false,
                          onSelected: (_) => manager.toggleError(),
                          backgroundColor: style.colors.background,
                          selectedColor: style.colors.error,
                          side: BorderSide(color: style.colors.border),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: Style.spacing.sm,
                          ),
                        ),
                        FilterChip(
                          label: Text(
                            'Offen',
                            style: context.typography.bodySmall.bold.withColor(
                              open
                                  ? style.colors.background
                                  : style.colors.foreground,
                            ),
                          ),
                          avatar: Icon(
                            Icons.hourglass_top,
                            size: 18,
                            color: open
                                ? style.colors.background
                                : style.colors.mutedForeground,
                          ),
                          selected: open,
                          showCheckmark: false,
                          onSelected: (_) => manager.toggleOpen(),
                          backgroundColor: style.colors.background,
                          selectedColor: style.colors.info,
                          side: BorderSide(color: style.colors.border),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: Style.spacing.sm,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(Style.spacing.md),
              CardBox(
                padding: EdgeInsets.all(Style.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Endpoint / Methode',
                      style: context.typography.subtitle,
                    ),
                    Gap(Style.spacing.md),
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
                    Gap(Style.spacing.md),
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
            ],
          ),
        ),
      ),
    );
  }
}
