import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/matrix_event_reports_screen/matrix_event_reports_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_screen/matrix_rooms_list_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_user_app_user_map_scope.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_user_list_card.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/widgets/matrix_users_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_screen/new_matrix_user_screen.dart';
import 'package:school_data_hub_flutter/features/user/data/user_api_service.dart';

class MatrixUsersListScreen extends WatchingWidget {
  const MatrixUsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final notificationData = watchValue(
      (NotificationManager x) => x.notification,
    );

    return FutureBuilder(
      future: di.getAsync<MatrixPolicyManager>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: style.colors.canvas,
            appBar: const AppHeader(
              iconData: Icons.chat_rounded,
              title: 'Matrix-Konten',
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bitte warten', style: context.typography.subtitle.bold),
                  const Gap(20),
                  if (notificationData.message.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        notificationData.message,
                        textAlign: TextAlign.center,
                        style: context.typography.body,
                      ),
                    ),
                    const Gap(20),
                  ],
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }

        return _MatrixUsersListContent(matrixPolicyManager: snapshot.data!);
      },
    );
  }
}

class _MatrixUsersListContent extends WatchingWidget {
  final MatrixPolicyManager matrixPolicyManager;

  const _MatrixUsersListContent({required this.matrixPolicyManager});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pendingChanges = watchValue(
      (MatrixPolicyManager x) => x.pendingChanges,
    );
    final filterManager = di<MatrixPolicyFilterManager>();

    return FutureBuilder<Map<String?, UserWithDevices>>(
      future: _loadAppUsersByMatrixId(),
      builder: (context, snapshot) {
        final appUserByMatrixId = snapshot.data ?? {};

        return MatrixUserAppUserMapScope(
          appUserByMatrixId: appUserByMatrixId,
          child: GenericListPage<MatrixUser>(
            iconData: Icons.chat_rounded,
            title: 'Matrix-Konten',
            sliverAppBarHeight: 110,
            searchBarConfig: GenericListSearchBarConfig(
              statsWidget: ValueListenableBuilder<List<MatrixUser>>(
                valueListenable: filterManager.filteredMatrixUsers,
                builder: (context, matrixUsers, _) => Row(
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
              searchType: SearchType.matrixUser,
              hintText: 'Konten suchen',
              refreshFunction: () => filterManager.setUsersFilterText(''),
              onChanged: filterManager.setUsersFilterText,
              filtersActive: filterManager.filtersOn,
              onResetFilters: filterManager.resetAllMatrixFilters,
            ),
            filterSheetChildren: const [MatrixUsersFilterChips()],
            itemsListenable: filterManager.filteredMatrixUsers,
            itemBuilder: (context, matrixUser) {
              final appUser = MatrixUserAppUserMapScope.of(
                context,
              )[matrixUser.id];
              return MatrixUsersListCard(matrixUser, appUser: appUser);
            },
            onRefresh: () async => matrixPolicyManager.fetchMatrixPolicy(),
            emptyMessage: 'Keine Ergebnisse',
            maxWidth: 800,
            backgroundColor: style.colors.canvas,
            bottomBarActions: _buildBottomBarActions(
              context,
              pendingChanges: pendingChanges,
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildBottomBarActions(
    BuildContext context, {
    required bool pendingChanges,
  }) {
    return [
      if (pendingChanges)
        IconButton(
          tooltip: 'Änderungen speichern',
          icon: const Icon(Icons.save, size: 30),
          onPressed: () => matrixPolicyManager.applyPolicyChanges(),
        ),
      IconButton(
        tooltip: 'neues Matrix-Konto',
        icon: const Icon(Icons.add, size: 30),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute<void>(
              builder: (ctx) => const NewMatrixUserScreen(),
            ),
          );
        },
      ),
      IconButton(
        tooltip: 'Matrix-Räume',
        icon: const Icon(Icons.meeting_room_rounded, size: 30),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute<void>(
              builder: (ctx) => const MatrixRoomsListScreen(),
            ),
          );
        },
      ),
      IconButton(
        tooltip: 'Event Reports',
        icon: const Icon(Icons.flag_circle_rounded, size: 30),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute<void>(
              builder: (ctx) => const MatrixEventReportsScreen(),
            ),
          );
        },
      ),
      IconButton(
        tooltip: 'Zur Startseite',
        icon: const Icon(Icons.home, size: 35),
        onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      ),
    ];
  }

  static Future<Map<String?, UserWithDevices>> _loadAppUsersByMatrixId() async {
    try {
      final list = await di<UserApiService>().getAllUsersWithDevices();
      if (list == null) return {};
      final map = <String?, UserWithDevices>{};
      for (final u in list) {
        final matrixId = u.user.matrixUserId;
        if (matrixId != null && matrixId.isNotEmpty) {
          map[matrixId] = u;
        }
      }
      return map;
    } catch (_) {
      return {};
    }
  }
}
