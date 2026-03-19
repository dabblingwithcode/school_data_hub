import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/list_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_screen/widgets/authorization_card.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/new_authorization_screen/new_authorization_screen.dart';

class AuthorizationsListScreen extends StatelessWidget {
  const AuthorizationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final authorizationManager = di<AuthorizationManager>();
    final authorizationFilterManager = di<AuthorizationFilterManager>();
    final filtersStateManager = di<FiltersStateManager>();

    return ListScreen<Authorization>(
      iconData: Icons.fact_check_rounded,
      title: 'Nachweis-Listen',
      backgroundColor: style.colors.canvas,
      maxWidth: 700,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: ValueListenableBuilder<List<Authorization>>(
          valueListenable: authorizationFilterManager.filteredAuthorizations,
          builder: (context, authorizations, _) => Row(
            children: [
              Text('Gesamt:', style: context.typography.bodySmall),
              const Gap(10),
              Text(
                authorizations.length.toString(),
                style: context.typography.title.withColor(
                  style.colors.foreground,
                ),
              ),
            ],
          ),
        ),
        searchType: SearchType.authorization,
        hintText: 'Liste suchen',
        refreshFunction: authorizationManager.fetchAuthorizations,
        onChanged: authorizationFilterManager.onSearchText,
        filtersActive: filtersStateManager.filtersActive,
        onResetFilters: () => authorizationFilterManager.resetFilters(),
      ),
      itemsListenable: authorizationFilterManager.filteredAuthorizations,
      itemBuilder: (context, authorization) =>
          AuthorizationCard(authorization: authorization),
      onRefresh: () async => authorizationManager.fetchAuthorizations(),
      bottomBarActions: [
        if (di<HubSessionManager>().isAdmin == true)
          TappableIcon(
            tooltip: 'Neue Liste',
            icon: const Icon(Icons.add, size: 35),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => const NewAuthorizationScreen(),
                ),
              );
            },
          ),
      ],
    );
  }
}
