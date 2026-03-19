import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/search_input.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class UserListSearchBar extends StatelessWidget {
  final List<User> users;
  final TextEditingController searchController;
  final bool filtersOn;
  final ValueListenable<bool> filtersActive;
  final VoidCallback? onLongPress;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onResetFilters;
  final VoidCallback onOpenFilter;

  const UserListSearchBar({
    required this.users,
    required this.searchController,
    required this.filtersOn,
    required this.filtersActive,
    this.onLongPress,
    required this.onSearchChanged,
    required this.onResetFilters,
    required this.onOpenFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final int totalUsers = users.length;
    final int totalCredit = users.fold(0, (sum, user) => sum + user.credit);
    final int totalTimeUnits = users.fold(
      0,
      (sum, user) => sum + user.timeUnits,
    );
    final int adminCount = users
        .where((user) => user.role == Role.admin)
        .length;

    return Column(
      children: [
        const Gap(5),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.spacing.md),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people, color: style.colors.accent),
                  const Gap(10),
                  Text(
                    totalUsers.toString(),
                    style: context.typography.subtitle.bold
                        .withColor(style.colors.foreground),
                  ),
                  const Gap(10),
                  Text(
                    'Admins:',
                    style: context.typography.bodySmall.bold
                        .withColor(style.colors.accent),
                  ),
                  const Gap(10),
                  Text(
                    adminCount.toString(),
                    style: context.typography.subtitle.bold
                        .withColor(style.colors.foreground),
                  ),
                  const Gap(10),
                  Text(
                    'Gesamt Credit:',
                    style: context.typography.bodySmall.bold
                        .withColor(style.colors.accent),
                  ),
                  const Gap(10),
                  Text(
                    totalCredit.toString(),
                    style: context.typography.subtitle.bold
                        .withColor(style.colors.foreground),
                  ),
                  const Gap(10),
                  Text(
                    'Zeiteinheiten:',
                    style: context.typography.bodySmall.bold
                        .withColor(style.colors.accent),
                  ),
                  const Gap(10),
                  Text(
                    totalTimeUnits.toString(),
                    style: context.typography.subtitle.bold
                        .withColor(style.colors.foreground),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: Style.spacing.md,
            left: Style.spacing.md,
            right: Style.spacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: SearchInput(
                  searchType: SearchType.user,
                  hintText: 'Benutzer suchen',
                  refreshFunction: () {},
                  onChanged: onSearchChanged,
                  filtersActive: filtersActive,
                  onResetFilters: onResetFilters,
                ),
              ),
              const Gap(5),
              FilterButton(
                isSearchBar: true,
                filtersActive: filtersActive,
                onLongPress: onLongPress,
                showBottomSheetFunction: (_) => onOpenFilter(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
