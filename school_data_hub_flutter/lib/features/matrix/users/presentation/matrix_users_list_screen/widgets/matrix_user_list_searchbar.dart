import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_generic_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/widgets/matrix_search_text_field.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_users_list_filter_bottom_sheet.dart';

final _matrixPolicyFilterManager = di<MatrixPolicyFilterManager>();

class MatrixUsersListSearchBar extends WatchingWidget {
  final List<MatrixUser> matrixUsers;

  const MatrixUsersListSearchBar({required this.matrixUsers, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    bool filtersOn = watchValue((MatrixPolicyFilterManager x) => x.filtersOn);
    return Container(
      decoration: BoxDecoration(
        color: style.colors.canvas,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_alt_rounded, color: style.colors.accent),
                  const Gap(10),
                  Text(
                    matrixUsers.length.toString(),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: MatrixSearchTextField(
                    searchType: SearchType.matrixUser,
                    hintText: 'Konten suchen',
                    refreshFunction:
                        di<MatrixPolicyFilterManager>().setUsersFilterText,
                  ),
                ),
                InkWell(
                  onTap: () => showGenericBottomSheet(
                    context,
                    const GenericFilterBottomSheet(
                      children: [MatrixUsersFilterChips()],
                    ),
                  ),
                  onLongPress: () =>
                      _matrixPolicyFilterManager.resetAllMatrixFilters(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn
                          ? style.colors.warning
                          : style.colors.mutedForeground,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
