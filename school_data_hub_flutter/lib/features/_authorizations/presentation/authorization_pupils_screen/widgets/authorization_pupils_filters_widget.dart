import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/filters/pupil_authorization_filter_manager.dart';
import 'package:flutter_it/flutter_it.dart';

final _authFilterManager = di<PupilAuthorizationFilterManager>();

class AuthorizationPupilsFiltersWidget extends WatchingWidget {
  const AuthorizationPupilsFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Map<AuthorizationFilter, bool> activeFilters = watchValue(
      (PupilAuthorizationFilterManager x) => x.authorizationFilterState,
    );
    bool valueYesResponse = activeFilters[AuthorizationFilter.yes]!;
    bool valueNoResponse = activeFilters[AuthorizationFilter.no]!;
    bool valueNullResponse = activeFilters[AuthorizationFilter.nullResponse]!;
    bool valueCommentResponse =
        activeFilters[AuthorizationFilter.commentResponse]!;
    bool valueFileResponse = activeFilters[AuthorizationFilter.fileResponse]!;

    return Column(
      children: [
        Row(
          children: [Text('Antwort:', style: context.typography.subtitle)],
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
                  _authFilterManager.setFilter(
                    authorizationFilters: [
                      (
                        authorizationFilter: AuthorizationFilter.yes,
                        value: true,
                      ),
                      (
                        authorizationFilter: AuthorizationFilter.no,
                        value: false,
                      ),
                      (
                        authorizationFilter:
                            AuthorizationFilter.nullResponse,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }
                _authFilterManager.setFilter(
                  authorizationFilters: [
                    (
                      authorizationFilter: AuthorizationFilter.yes,
                      value: val,
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
                  _authFilterManager.setFilter(
                    authorizationFilters: [
                      (
                        authorizationFilter: AuthorizationFilter.no,
                        value: true,
                      ),
                      (
                        authorizationFilter: AuthorizationFilter.yes,
                        value: false,
                      ),
                      (
                        authorizationFilter:
                            AuthorizationFilter.nullResponse,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }
                _authFilterManager.setFilter(
                  authorizationFilters: [
                    (
                      authorizationFilter: AuthorizationFilter.no,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'keine Antwort',
              selected: valueNullResponse,
              onSelected: (val) {
                if (val) {
                  _authFilterManager.setFilter(
                    authorizationFilters: [
                      (
                        authorizationFilter:
                            AuthorizationFilter.nullResponse,
                        value: true,
                      ),
                      (
                        authorizationFilter: AuthorizationFilter.yes,
                        value: false,
                      ),
                      (
                        authorizationFilter: AuthorizationFilter.no,
                        value: false,
                      ),
                    ],
                  );
                  return;
                }

                _authFilterManager.setFilter(
                  authorizationFilters: [
                    (
                      authorizationFilter:
                          AuthorizationFilter.nullResponse,
                      value: val,
                    ),
                  ],
                );
              },
            ),
            ThemedFilterChip(
              label: 'Kommentar',
              selected: valueCommentResponse,
              onSelected: (val) {
                _authFilterManager.setFilter(
                  authorizationFilters: [
                    (
                      authorizationFilter:
                          AuthorizationFilter.commentResponse,
                      value: val,
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
                _authFilterManager.setFilter(
                  authorizationFilters: [
                    (
                      authorizationFilter:
                          AuthorizationFilter.fileResponse,
                      value: val,
                    ),
                  ],
                );
                return;
              },
            ),
          ],
        ),
      ],
    );
  }
}
