import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/theme/styles.dart';
import 'package:schuldaten_hub/common/widgets/themed_filter_chip.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupil_filter_enums.dart';
import 'package:schuldaten_hub/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/presentation/widgets/common_pupil_filters.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationPupilsFilterBottomSheet extends WatchingWidget {
  const AuthorizationPupilsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.pupilFilterState);
    bool valueYesResponse = activeFilters[PupilFilter.authorizationPositive]!;
    bool valueNoResponse = activeFilters[PupilFilter.authorizationNegative]!;
    bool valueNullResponse = activeFilters[PupilFilter.authorizationNoValue]!;
    bool valueCommentResponse =
        activeFilters[PupilFilter.authorizationComment]!;
    bool valueFileResponse = activeFilters[PupilFilter.authorizationNoFile]!;
    final filterLocator = locator<PupilFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          const FilterHeading(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const CommonPupilFiltersWidget(),
                  const Row(
                    children: [
                      Text(
                        'Antwort:',
                        style: AppStyles.subtitle,
                      )
                    ],
                  ),
                  const Gap(5),
                  Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      ThemedFilterChip(
                        label: 'Ja',
                        selected: valueYesResponse,
                        onSelected: (val) {
                          if (val) {
                            filterLocator.setPupilFilter(pupilFilterRecords: [
                              (
                                filter: PupilFilter.authorizationPositive,
                                value: true
                              ),
                              (
                                filter: PupilFilter.authorizationNegative,
                                value: false
                              ),
                              (
                                filter: PupilFilter.authorizationNoValue,
                                value: false
                              ),
                            ]);
                            return;
                          }
                          filterLocator.setPupilFilter(pupilFilterRecords: [
                            (
                              filter: PupilFilter.authorizationPositive,
                              value: val
                            )
                          ]);
                        },
                      ),
                      ThemedFilterChip(
                          label: 'Nein',
                          selected: valueNoResponse,
                          onSelected: (val) {
                            if (val) {
                              filterLocator.setPupilFilter(
                                pupilFilterRecords: [
                                  (
                                    filter: PupilFilter.authorizationNegative,
                                    value: true
                                  ),
                                  (
                                    filter: PupilFilter.authorizationPositive,
                                    value: false
                                  ),
                                  (
                                    filter: PupilFilter.authorizationNoValue,
                                    value: false
                                  ),
                                ],
                              );
                              return;
                            }
                            filterLocator.setPupilFilter(
                              pupilFilterRecords: [
                                (
                                  filter: PupilFilter.authorizationNegative,
                                  value: val
                                )
                              ],
                            );
                          }),
                      ThemedFilterChip(
                        label: 'keine Antwort',
                        selected: valueNullResponse,
                        onSelected: (val) {
                          if (val) {
                            filterLocator.setPupilFilter(
                              pupilFilterRecords: [
                                (
                                  filter: PupilFilter.authorizationNoValue,
                                  value: true
                                ),
                                (
                                  filter: PupilFilter.authorizationPositive,
                                  value: false
                                ),
                                (
                                  filter: PupilFilter.authorizationNegative,
                                  value: false
                                ),
                              ],
                            );
                            return;
                          }

                          filterLocator.setPupilFilter(
                            pupilFilterRecords: [
                              (
                                filter: PupilFilter.authorizationNoValue,
                                value: val
                              )
                            ],
                          );
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Kommentar',
                        selected: valueCommentResponse,
                        onSelected: (val) {
                          filterLocator.setPupilFilter(
                            pupilFilterRecords: [
                              (
                                filter: PupilFilter.authorizationComment,
                                value: val
                              ),
                            ],
                          );
                          return;
                        },
                      ),
                      ThemedFilterChip(
                        label: 'Kein Bild',
                        selected: valueFileResponse,
                        onSelected: (val) {
                          filterLocator.setPupilFilter(
                            pupilFilterRecords: [
                              (
                                filter: PupilFilter.authorizationNoFile,
                                value: val
                              ),
                            ],
                          );
                          return;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

showAuthorizationPupilsFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (_) => const AuthorizationPupilsFilterBottomSheet(),
  );
}
