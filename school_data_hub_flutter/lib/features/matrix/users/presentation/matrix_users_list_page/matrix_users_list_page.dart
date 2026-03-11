import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/matrix_event_reports_page/matrix_event_reports_page.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/matrix_rooms_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_app_user_map_scope.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_card.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_searchbar.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_users_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_page/new_matrix_user_page.dart';
import 'package:school_data_hub_flutter/features/user/data/user_api_service.dart';

class MatrixUsersListPage extends WatchingWidget {
  const MatrixUsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationData = watchValue(
      (NotificationService x) => x.notification,
    );

    return FutureBuilder(
      future: di.getAsync<MatrixPolicyManager>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: AppColors.canvasColor,
            appBar: const GenericAppBar(
              iconData: Icons.chat_rounded,
              title: 'Matrix-Konten',
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bitte warten',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const Gap(20),
                  if (notificationData.message.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        notificationData.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
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
    final pendingChanges = watchValue(
      (MatrixPolicyManager x) => x.pendingChanges,
    );
    final filtersOn = watchValue((MatrixPolicyFilterManager x) => x.filtersOn);
    final matrixUsers = watchValue(
      (MatrixPolicyFilterManager x) => x.filteredMatrixUsers,
    );

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
            searchWidgetWithStatsRow: MatrixUsersListSearchBar(
              matrixUsers: matrixUsers,
            ),
            itemsListenable:
                di<MatrixPolicyFilterManager>().filteredMatrixUsers,
            itemBuilder: (context, matrixUser) {
              final appUser = MatrixUserAppUserMapScope.of(
                context,
              )[matrixUser.id];
              return MatrixUsersListCard(matrixUser, appUser: appUser);
            },
            onRefresh: () async => matrixPolicyManager.fetchMatrixPolicy(),
            emptyMessage: 'Keine Ergebnisse',
            maxWidth: 800,
            backgroundColor: AppColors.canvasColor,
            bottomBarActions: _buildBottomBarActions(
              context,
              pendingChanges: pendingChanges,
              filtersOn: filtersOn,
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildBottomBarActions(
    BuildContext context, {
    required bool pendingChanges,
    required bool filtersOn,
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
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (ctx) => const NewMatrixUserPage(),
            ),
          );
        },
      ),
      IconButton(
        tooltip: 'Matrix-Räume',
        icon: const Icon(Icons.meeting_room_rounded, size: 30),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (ctx) => const MatrixRoomsListPage(),
            ),
          );
        },
      ),
      IconButton(
        tooltip: 'Event Reports',
        icon: const Icon(Icons.flag_circle_rounded, size: 30),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (ctx) => const MatrixEventReportsPage(),
            ),
          );
        },
      ),
      IconButton(
        tooltip: 'Zur Startseite',
        icon: const Icon(Icons.home, size: 35),
        onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      ),

      IconButton(
        tooltip: 'Filter',
        icon: Icon(
          Icons.filter_list,
          color: filtersOn ? Colors.deepOrange : Colors.white,
          size: 30,
        ),
        onPressed: () => showMatrixUsersListFilterBottomSheet(context),
        onLongPress: () =>
            di<MatrixPolicyFilterManager>().resetAllMatrixFilters(),
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
