import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_search_bar_with_stats.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_list_page/widgets/credit_list_search_bar_stats.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_helper.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_page/new_matrix_user_page.dart';

class PupilsMatrixContactsListPage extends WatchingWidget {
  const PupilsMatrixContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pupilManager = di<PupilProxyManager>();
    final pupilsFilter = di<PupilsFilter>();
    final filterStateManager = di<FiltersStateManager>();
    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.contact_mail_rounded,
        title: 'Matrix Kontakte',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: CustomScrollView(
            slivers: [
              const SliverGap(5),
              GenericSliverAppBarWithSearchWidget(
                height: 110,
                searchWidgetWithStatsRow: GenericListSearchBarWithStats(
                  statsWidget: CreditListSearchBarStats(
                    filteredPupils: pupilsFilter.filteredPupils,
                  ),
                  searchType: SearchType.pupil,
                  hintText: 'Schüler/in suchen',
                  refreshFunction: pupilsFilter.refreshs,
                  onChanged: (value) =>
                      pupilsFilter.textFilter.setFilterText(value),
                  searchTextSource: pupilsFilter.textFilter,
                  filtersActive: filterStateManager.filtersActive,
                  onResetFilters: filterStateManager.resetFilters,
                  showFilterBottomSheet: (context) =>
                      showGenericFilterBottomSheet(
                        context: context,
                        filterList: [const CommonPupilFiltersWidget()],
                      ),
                ),
              ),
              GenericSliverListWithEmptyListCheck(
                itemsListenable: pupilsFilter.filteredPupils,
                itemBuilder: (_, pupil) {
                  final missingContacts =
                      pupil.tutorInfo?.parentsContact == null ||
                      pupil.contact == null;
                  final subtleBorder = AppColors.canvasColor;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 1.0,
                    ),
                    child: Card(
                      color: missingContacts
                          ? const Color.fromARGB(255, 251, 232, 176)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: missingContacts ? Colors.orange : subtleBorder,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Gap(5),
                              AvatarWithBadges(pupil: pupil, size: 80),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(10),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute<void>(
                                                builder: (ctx) =>
                                                    PupilProfilePage(
                                                      pupil: pupil,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            '${pupil.firstName} ${pupil.lastName}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        if (pupil.family != null)
                                          Row(
                                            children: [
                                              const Gap(10),
                                              Icon(
                                                Icons.group,
                                                size: 25,
                                                color:
                                                    AppColors.backgroundColor,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text('Kontakt: '),
                                              ),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (pupil.contact ==
                                                            null) {
                                                          if (!di
                                                              .isRegistered<
                                                                MatrixPolicyManager
                                                              >()) {
                                                            di<
                                                                  NotificationService
                                                                >()
                                                                .showInformationDialog(
                                                                  NotificationType
                                                                      .error,
                                                                  'Es sind keine Matrix-Admindaten hinterlegt.',
                                                                );
                                                            return;
                                                          }
                                                          Navigator.of(
                                                            context,
                                                          ).push(
                                                            MaterialPageRoute<
                                                              void
                                                            >(
                                                              builder: (ctx) => NewMatrixUserPage(
                                                                pupil: pupil,
                                                                matrixId:
                                                                    MatrixPolicyHelper.generateMatrixId(
                                                                      isParent:
                                                                          false,
                                                                    ),
                                                                displayName:
                                                                    '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (${pupil.group})',
                                                              ),
                                                            ),
                                                          );
                                                          return;
                                                        }
                                                        final confirm =
                                                            await confirmationDialog(
                                                              context: context,
                                                              title:
                                                                  'Messenger öffnen',
                                                              message:
                                                                  'Nachricht an ${pupil.firstName} schicken?',
                                                            );
                                                        if (confirm == true &&
                                                            context.mounted) {
                                                          MatrixPolicyHelper.launchMatrixUrl(
                                                            context,
                                                            pupil.contact!,
                                                          );
                                                        }
                                                      },
                                                      onLongPress: () async {
                                                        final result =
                                                            await longTextFieldDialog(
                                                              title: 'Kontakt',
                                                              labelText:
                                                                  'Kontakt',
                                                              initialValue:
                                                                  pupil.contact,
                                                              parentContext:
                                                                  context,
                                                            );
                                                        if (result == null ||
                                                            result.value ==
                                                                pupil.contact) {
                                                          return;
                                                        }

                                                        await PupilMutator()
                                                            .updateStringProperty(
                                                              pupilId:
                                                                  pupil.pupilId,
                                                              property:
                                                                  PupilStringProperty
                                                                      .contact,
                                                              propertyValue: (
                                                                value: result
                                                                    .value,
                                                              ),
                                                            );
                                                      },
                                                      child: Text(
                                                        pupil.contact ??
                                                            'nicht vorhanden',
                                                        style: TextStyle(
                                                          color:
                                                              pupil.contact ==
                                                                  null
                                                              ? Colors.black
                                                              : AppColors
                                                                    .backgroundColor,
                                                          fontWeight:
                                                              pupil.contact ==
                                                                  null
                                                              ? FontWeight.bold
                                                              : FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            const Gap(10),
                                            IconButton(
                                              iconSize: 18,
                                              icon: const Icon(Icons.copy),
                                              onPressed: () {
                                                if (pupil.contact == null) {
                                                  return;
                                                }
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: pupil.contact!,
                                                  ),
                                                );
                                                di<NotificationService>()
                                                    .showSnackBar(
                                                      NotificationType.success,
                                                      'In die Zwischenablage kopiert',
                                                    );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text('Elternkontakt: '),
                                              ),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (pupil
                                                                .tutorInfo
                                                                ?.parentsContact ==
                                                            null) {
                                                          if (!di
                                                              .isRegistered<
                                                                MatrixPolicyManager
                                                              >()) {
                                                            di<
                                                                  NotificationService
                                                                >()
                                                                .showInformationDialog(
                                                                  NotificationType
                                                                      .error,
                                                                  'Es sind keine Matrix-Admindaten hinterlegt.',
                                                                );
                                                            return;
                                                          }
                                                          String?
                                                          pupilSiblingsGroups;
                                                          if (pupil.family !=
                                                              null) {
                                                            pupilSiblingsGroups =
                                                                [
                                                                      ...pupilManager
                                                                          .getSiblings(
                                                                            pupil,
                                                                          ),
                                                                      pupil,
                                                                    ]
                                                                    .map(
                                                                      (e) => e
                                                                          .group,
                                                                    )
                                                                    .toList()
                                                                    .join();
                                                          }
                                                          Navigator.of(
                                                            context,
                                                          ).push(
                                                            MaterialPageRoute<
                                                              void
                                                            >(
                                                              builder: (ctx) => NewMatrixUserPage(
                                                                pupil: pupil,
                                                                matrixId:
                                                                    MatrixPolicyHelper.generateMatrixId(
                                                                      isParent:
                                                                          true,
                                                                    ),
                                                                displayName:
                                                                    pupilSiblingsGroups !=
                                                                        null
                                                                    ? 'Fa. ${pupil.lastName} (E) $pupilSiblingsGroups'
                                                                    : '${pupil.firstName} ${pupil.lastName.substring(0, 1).toUpperCase()}. (E) ${pupil.group}',
                                                                isParent: true,
                                                              ),
                                                            ),
                                                          );
                                                          return;
                                                        }
                                                        final confirm =
                                                            await confirmationDialog(
                                                              context: context,
                                                              title:
                                                                  'Messenger öffnen',
                                                              message:
                                                                  'Nachricht an ${pupil.firstName}s Erziehungsberechtigte schicken?',
                                                            );
                                                        if (confirm == true &&
                                                            context.mounted) {
                                                          MatrixPolicyHelper.launchMatrixUrl(
                                                            context,
                                                            pupil
                                                                .tutorInfo!
                                                                .parentsContact!,
                                                          );
                                                        }
                                                      },
                                                      onLongPress: () async {
                                                        final result =
                                                            await longTextFieldDialog(
                                                              title:
                                                                  'Elternkontakt',
                                                              labelText:
                                                                  'Elternkontakt',
                                                              initialValue: pupil
                                                                  .tutorInfo
                                                                  ?.parentsContact,
                                                              parentContext:
                                                                  context,
                                                            );
                                                        if (result == null ||
                                                            result.value ==
                                                                pupil
                                                                    .tutorInfo
                                                                    ?.parentsContact) {
                                                          return;
                                                        }
                                                        final TutorInfo
                                                        tutorInfo =
                                                            pupil.tutorInfo ==
                                                                null
                                                            ? TutorInfo(
                                                                parentsContact:
                                                                    '@${result.value}',
                                                                createdBy:
                                                                    di<
                                                                          HubSessionManager
                                                                        >()
                                                                        .signedInUser!
                                                                        .userName!,
                                                              )
                                                            : pupil.tutorInfo!
                                                                  .copyWith(
                                                                    parentsContact:
                                                                        '@${result.value}',
                                                                  );
                                                        await PupilMutator()
                                                            .updateTutorInfo(
                                                              pupilId:
                                                                  pupil.pupilId,
                                                              tutorInfo:
                                                                  tutorInfo,
                                                            );
                                                      },
                                                      child: Text(
                                                        pupil
                                                                .tutorInfo
                                                                ?.parentsContact ??
                                                            'nicht vorhanden',
                                                        style: TextStyle(
                                                          color:
                                                              pupil
                                                                      .tutorInfo
                                                                      ?.parentsContact ==
                                                                  null
                                                              ? Colors.black
                                                              : AppColors
                                                                    .backgroundColor,
                                                          fontWeight:
                                                              pupil
                                                                      .tutorInfo
                                                                      ?.parentsContact ==
                                                                  null
                                                              ? FontWeight.bold
                                                              : FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            const Gap(10),
                                            IconButton(
                                              iconSize: 18,
                                              icon: const Icon(Icons.copy),
                                              onPressed: () {
                                                if (pupil
                                                        .tutorInfo
                                                        ?.parentsContact ==
                                                    null) {
                                                  return;
                                                }
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text:
                                                        pupil
                                                            .tutorInfo
                                                            ?.parentsContact ??
                                                        'Kein Elternkontakt vorhanden!',
                                                  ),
                                                );
                                                di<NotificationService>()
                                                    .showSnackBar(
                                                      NotificationType.success,
                                                      'In die Zwischenablage kopiert',
                                                    );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GenericBottomNavBar(
        actions: [
          GenericFilterButton(
            isSearchBar: false,
            filtersActive: di<FiltersStateManager>().filtersActive,
            onLongPress: () => di<FiltersStateManager>().resetFilters(),
            showBottomSheetFunction: (context) => showGenericFilterBottomSheet(
              context: context,
              filterList: [const CommonPupilFiltersWidget()],
            ),
          ),
        ],
      ),
    );
  }
}
