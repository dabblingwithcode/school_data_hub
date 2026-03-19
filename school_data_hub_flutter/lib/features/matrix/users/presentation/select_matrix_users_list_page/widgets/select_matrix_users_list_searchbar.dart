import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/widgets/matrix_search_text_field.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';
import 'package:flutter_it/flutter_it.dart';

class SelectUserListSearchBar extends WatchingWidget {
  final List<MatrixUser> matrixUsers;
  final SelectMatrixUsersListController controller;
  const SelectUserListSearchBar({
    required this.matrixUsers,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final bool filtersOn = watchValue(
      (MatrixPolicyFilterManager x) => x.filtersOn,
    );
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
                  Icon(Icons.group_rounded, color: style.colors.accent),
                  const Gap(10),
                  Text(
                    matrixUsers.length.toString(),
                    style: context.typography.subtitle.bold,
                  ),
                  const Gap(10),
                  Text('Ausgewählt:', style: context.typography.bodySmall),
                  const Gap(10),
                  Text(
                    controller.selectedUsers.length.toString(),
                    style: context.typography.subtitle.bold,
                  ),
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
                  onTap: () => {},
                  onLongPress: () =>
                      di<MatrixPolicyFilterManager>().resetAllMatrixFilters(),
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
