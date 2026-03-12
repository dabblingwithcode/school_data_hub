import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/filters/authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/authorizations_list_page/widgets/authorization_card.dart';
import 'package:school_data_hub_flutter/features/_authorizations/presentation/new_authorization_page/new_authorization_page.dart';

class AuthorizationsListPage extends StatelessWidget {
  const AuthorizationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authorizationManager = di<AuthorizationManager>();
    final authorizationFilterManager = di<AuthorizationFilterManager>();
    final filtersStateManager = di<FiltersStateManager>();

    return GenericListPage<Authorization>(
      iconData: Icons.fact_check_rounded,
      title: 'Nachweis-Listen',
      backgroundColor: AppColors.canvasColor,
      maxWidth: 700,
      searchBarConfig: GenericListSearchBarConfig(
        statsWidget: ValueListenableBuilder<List<Authorization>>(
          valueListenable: authorizationFilterManager.filteredAuthorizations,
          builder: (context, authorizations, _) => Row(
            children: [
              const Text('Gesamt:', style: TextStyle(fontSize: 13)),
              const Gap(10),
              Text(
                authorizations.length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
          IconButton(
            tooltip: 'Neue Liste',
            icon: const Icon(Icons.add, size: 35),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (ctx) => const NewAuthorizationPage(),
                ),
              );
            },
          ),
      ],
    );
  }
}
