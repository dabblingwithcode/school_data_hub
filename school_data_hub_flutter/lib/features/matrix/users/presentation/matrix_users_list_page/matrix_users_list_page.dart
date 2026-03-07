import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_page.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/matrix_event_reports_page/matrix_event_reports_page.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_page/matrix_rooms_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_card.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_searchbar.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_page/new_matrix_user_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_page/controller/select_matrix_users_list_controller.dart';
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

        return Scaffold(
          backgroundColor: AppColors.canvasColor,
          appBar: const GenericAppBar(
            iconData: Icons.chat_rounded,
            title: 'Matrix-Konten',
          ),
          body: RefreshIndicator(
            onRefresh: () async => matrixPolicyManager.fetchMatrixPolicy(),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: CustomScrollView(
                  slivers: [
                    const SliverGap(5),
                    GenericSliverAppBarWithSearchWidget(
                      searchWidgetWithStatsRow: MatrixUsersListSearchBar(
                        matrixUsers: matrixUsers,
                      ),
                      height: 110,
                    ),
                    matrixUsers.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Keine Ergebnisse',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate((
                              BuildContext context,
                              int index,
                            ) {
                              final matrixUser = matrixUsers[index];
                              final appUser = appUserByMatrixId[matrixUser.id];
                              return MatrixUsersListCard(
                                matrixUser,
                                appUser: appUser,
                              );
                            }, childCount: matrixUsers.length),
                          ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: GenericBottomNavBar(
            actions: [
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
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              ),
              IconButton(
                tooltip: 'Matrix-Konten für SuS ohne Kontakt erstellen',
                icon: const Icon(Icons.person_add_alt_1_rounded, size: 30),
                onPressed: () async {
                  final file = await matrixPolicyManager.users
                      .createMatrixCredentialsForPupilsWithoutContactInfo();
                  if (!context.mounted) return;
                  if (file != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => PdfViewerPage(pdfFile: file),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                tooltip: 'Mehrere neue Benutzer-Codes generieren',
                icon: const Icon(Icons.print, color: Colors.orange, size: 30),
                onPressed: () {
                  final matrixUsersList = matrixPolicyManager.matrixUsers.value;
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) =>
                          SelectMatrixUsersList(matrixUsersList),
                    ),
                  );
                },
              ),
              IconButton(
                tooltip: 'Filter',
                icon: Icon(
                  Icons.filter_list,
                  color: filtersOn ? Colors.deepOrange : Colors.white,
                  size: 30,
                ),
                onPressed: () {},
                onLongPress: () =>
                    di<MatrixPolicyFilterManager>().resetAllMatrixFilters(),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<Map<String?, UserWithDevices>> _loadAppUsersByMatrixId() async {
    try {
      final list = await di<UserApiService>().getAllUsersWithDevices();
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
