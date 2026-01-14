import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/widgets/special_info_card_view_model.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class SpecialInfoCard extends WatchingWidget {
  final PupilProxy pupil;
  const SpecialInfoCard(this.pupil, {super.key});
  @override
  Widget build(BuildContext context) {
    watch(pupil);
    final viewModel = SpecialInfoCardViewModel(pupil);

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
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
                const Gap(15),
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
                                  child: InkWell(
                                    onTap: () {
                                      di<FiltersStateManager>().resetFilters();
                                      di<BottomNavManager>()
                                          .setPupilProfileNavPage(0);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              PupilProfilePage(pupil: pupil),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          pupil.firstName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(
                                          pupil.lastName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Gap(5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(5),
                          const Row(
                            children: [
                              Text('Besondere Informationen:'),
                              Gap(5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () async {
                          if (!di<HubSessionManager>().isAdmin ||
                              di<HubSessionManager>().userName ==
                                  pupil.groupTutor) {
                            di<NotificationService>().showInformationDialog(
                              'Nur Klassenleitungen und Admins können diese Informationen bearbeiten!',
                            );
                            return;
                          }
                          final result = await longTextFieldDialog(
                            title: 'Besondere Infos',
                            labelText: 'Besondere Infos',
                            initialValue: viewModel.info,
                            parentContext: context,
                          );
                          if (result == null ||
                              result.value == viewModel.info) {
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
                              viewModel.info,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 3,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (viewModel.createdBy != null && viewModel.createdAt != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (!di<HubSessionManager>().isAdmin ||
                              di<HubSessionManager>().userName ==
                                  pupil.groupTutor) {
                            di<NotificationService>().showInformationDialog(
                              'Nur Klassenleitungen und Admins können diese Informationen bearbeiten!',
                            );
                            return;
                          }
                          final newCreatedBy = await shortTextfieldDialog(
                            title: 'Erstellt von bearbeiten',
                            hintText: 'Name',
                            labelText: 'Erstellt von',
                            textinField: viewModel.createdBy ?? '',
                            context: context,
                          );
                          if (newCreatedBy != null &&
                              newCreatedBy != viewModel.createdBy) {
                            await viewModel.updateMetadata(
                              newCreatedBy: newCreatedBy,
                            );
                          }
                        },
                        child: Text(
                          viewModel.createdBy!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      Text(
                        ', ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withValues(alpha: 0.7),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (!di<HubSessionManager>().isAdmin ||
                              di<HubSessionManager>().userName ==
                                  pupil.groupTutor) {
                            di<NotificationService>().showInformationDialog(
                              'Nur Klassenleitungen und Admins können diese Informationen bearbeiten!',
                            );
                            return;
                          }
                          final initialDate =
                              viewModel.createdAt?.tryParseDateForUser() ??
                              DateTime.now();
                          final newDate = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColors.backgroundColor,
                                    onPrimary: Colors.white,
                                    onSurface: AppColors.interactiveColor,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.accentColor,
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (newDate != null) {
                            final newCreatedAt = newDate.formatDateForUser();
                            if (newCreatedAt != viewModel.createdAt) {
                              await viewModel.updateMetadata(
                                newCreatedAt: newCreatedAt,
                              );
                            }
                          }
                        },
                        child: Text(
                          viewModel.createdAt!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      const Gap(15),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
