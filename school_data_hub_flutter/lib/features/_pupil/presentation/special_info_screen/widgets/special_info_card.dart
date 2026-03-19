import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/special_info_screen/widgets/special_info_card_view_model.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class SpecialInfoCard extends WatchingWidget {
  final PupilProxy pupil;
  const SpecialInfoCard(this.pupil, {super.key});

  @override
  Widget build(BuildContext context) {
    return CardBox(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarWithBadges(pupil: pupil, size: 80),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: GestureDetector(
                                    onTap: () {
                                      di<FiltersStateManager>().resetFilters();
                                      di<BottomNavManager>()
                                          .setPupilProfileNavPage(0);
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (ctx) =>
                                              PupilProfilePage(pupil: pupil),
                                        ),
                                      );
                                    },
                                    child: _SpecialInfoNameRow(pupil: pupil),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(4),
                          const Row(
                            children: [
                              Text('Besondere Informationen:'),
                              Gap(4),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                _SpecialInfoContent(pupil: pupil),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when [pupil.firstName] or [pupil.lastName] changes.
class _SpecialInfoNameRow extends WatchingWidget {
  final PupilProxy pupil;

  const _SpecialInfoNameRow({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final firstName = watchPropertyValue((m) => m.firstName, target: pupil);
    final lastName = watchPropertyValue((m) => m.lastName, target: pupil);
    return Row(
      children: [
        Text(
          firstName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.subtitle.bold,
        ),
        const Gap(4),
        Text(
          lastName,
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.left,
          style: context.typography.subtitle,
        ),
        const Gap(4),
      ],
    );
  }
}

/// Rebuilds only when [pupil.specialInformation] changes.
class _SpecialInfoContent extends WatchingWidget {
  final PupilProxy pupil;

  const _SpecialInfoContent({required this.pupil});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final specialInformation = watchPropertyValue(
      (m) => m.specialInformation,
      target: pupil,
    );
    final parts = specialInformation?.split('|') ?? [];
    final info = parts.isNotEmpty
        ? parts[0]
        : (specialInformation ?? 'keine Infos');
    final createdBy = parts.length > 1 ? parts[1] : null;
    final createdAt = parts.length > 2 ? parts[2] : null;
    final viewModel = SpecialInfoCardViewModel(pupil);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () async {
                  if (!di<HubSessionManager>().isAdmin ||
                      di<HubSessionManager>().userName == pupil.groupTutor) {
                    di<NotificationManager>().showInformationDialog(
                      NotificationType.error,
                      'Nur Klassenleitungen und Admins können diese Informationen bearbeiten!',
                    );
                    return;
                  }
                  final result = await longTextFieldDialog(
                    title: 'Besondere Infos',
                    labelText: 'Besondere Infos',
                    initialValue: info,
                    parentContext: context,
                  );
                  if (result == null || result.value == info) {
                    return;
                  }

                  await PupilMutator().updateStringProperty(
                    pupilId: pupil.pupilId,
                    property: PupilStringProperty.specialInformation,
                    propertyValue: result.value != null
                        ? (
                            value: [
                              result.value,
                              di<HubSessionManager>().userName,
                              DateTime.now().formatDateForUser(),
                            ].join('|'),
                          )
                        : (value: null),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 3,
                      style: context.typography.subtitle.bold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (createdBy != null && createdAt != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  if (!di<HubSessionManager>().isAdmin ||
                      di<HubSessionManager>().userName == pupil.groupTutor) {
                    di<NotificationManager>().showInformationDialog(
                      NotificationType.error,
                      'Nur Klassenleitungen und Admins können diese Informationen bearbeiten!',
                    );
                    return;
                  }
                  final newCreatedBy = await shortTextfieldDialog(
                    title: 'Erstellt von bearbeiten',
                    hintText: 'Name',
                    labelText: 'Erstellt von',
                    textinField: createdBy,
                    context: context,
                  );
                  if (newCreatedBy != null && newCreatedBy != createdBy) {
                    await viewModel.updateMetadata(newCreatedBy: newCreatedBy);
                  }
                },
                child: Text(
                  createdBy,
                  style: context.typography.body.withColor(
                    style.colors.mutedForeground.withValues(alpha: 0.7),
                  ),
                ),
              ),
              Text(
                ', ',
                style: context.typography.body.withColor(
                  style.colors.mutedForeground.withValues(alpha: 0.7),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!di<HubSessionManager>().isAdmin ||
                      di<HubSessionManager>().userName == pupil.groupTutor) {
                    di<NotificationManager>().showInformationDialog(
                      NotificationType.error,
                      'Nur Klassenleitungen und Admins können diese Informationen bearbeiten!',
                    );
                    return;
                  }
                  final initialDate =
                      createdAt.tryParseDateForUser() ?? DateTime.now();
                  final newDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: style.colors.accent,
                            onPrimary: style.colors.background,
                            onSurface: style.colors.interactive,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: style.colors.accent,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (newDate != null) {
                    final newCreatedAt = newDate.formatDateForUser();
                    if (newCreatedAt != createdAt) {
                      await viewModel.updateMetadata(
                        newCreatedAt: newCreatedAt,
                      );
                    }
                  }
                },
                child: Text(
                  createdAt,
                  style: context.typography.body.withColor(
                    style.colors.mutedForeground.withValues(alpha: 0.7),
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
      ],
    );
  }
}
