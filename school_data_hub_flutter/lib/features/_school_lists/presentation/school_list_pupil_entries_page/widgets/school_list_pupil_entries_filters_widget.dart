import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_enums.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:flutter_it/flutter_it.dart';

final _schoolListFilterManager = di<SchoolListFilterManager>();

class SchoolListPupilEntriesFiltersWidget extends WatchingWidget {
  const SchoolListPupilEntriesFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Map<SchoolListEntryFilter, bool> activeFilters = watchValue(
      (SchoolListFilterManager x) => x.entryFilterState,
    );
    bool valueYesResponse =
        activeFilters[SchoolListEntryFilter.yesResponse]!;
    bool valueNoResponse =
        activeFilters[SchoolListEntryFilter.noResponse]!;
    bool valueNullResponse =
        activeFilters[SchoolListEntryFilter.nullResponse]!;
    bool valueCommentResponse =
        activeFilters[SchoolListEntryFilter.commentResponse]!;

    return Column(
      children: [
        const Row(children: [Text('Antwort:', style: AppStyles.subtitle)]),
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
                  _schoolListFilterManager.setEntryFilter(
                    entryFilterRecords: [
                      (
                        filter: SchoolListEntryFilter.yesResponse,
                        value: true,
                      ),
                      (
                        filter: SchoolListEntryFilter.noResponse,
                        value: false,
                      ),
                      (
                        filter: SchoolListEntryFilter.nullResponse,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }
                _schoolListFilterManager.setEntryFilter(
                  entryFilterRecords: [
                    (
                      filter: SchoolListEntryFilter.yesResponse,
                      value: false,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'Nein',
              selected: valueNoResponse,
              onSelected: (val) {
                if (val) {
                  _schoolListFilterManager.setEntryFilter(
                    entryFilterRecords: [
                      (
                        filter: SchoolListEntryFilter.noResponse,
                        value: true,
                      ),
                      (
                        filter: SchoolListEntryFilter.yesResponse,
                        value: false,
                      ),
                      (
                        filter: SchoolListEntryFilter.nullResponse,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }
                _schoolListFilterManager.setEntryFilter(
                  entryFilterRecords: [
                    (filter: SchoolListEntryFilter.noResponse, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'keine Antwort',
              selected: valueNullResponse,
              onSelected: (val) {
                if (val) {
                  _schoolListFilterManager.setEntryFilter(
                    entryFilterRecords: [
                      (
                        filter: SchoolListEntryFilter.nullResponse,
                        value: true,
                      ),
                      (
                        filter: SchoolListEntryFilter.yesResponse,
                        value: false,
                      ),
                      (
                        filter: SchoolListEntryFilter.noResponse,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }
                _schoolListFilterManager.setEntryFilter(
                  entryFilterRecords: [
                    (filter: SchoolListEntryFilter.nullResponse, value: val),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'Kommentar',
              selected: valueCommentResponse,
              onSelected: (val) {
                _schoolListFilterManager.setEntryFilter(
                  entryFilterRecords: [
                    (
                      filter: SchoolListEntryFilter.commentResponse,
                      value: val,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
