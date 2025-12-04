import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/filters/matrix_policy_filter_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/domain/matrix_policy_manager.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_card.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_user_list_searchbar.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/widgets/matrix_users_list_view_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

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
    final matrixUsers = watchValue(
      (MatrixPolicyFilterManager x) => x.filteredMatrixUsers,
    );

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
                GenericSliverSearchAppBar(
                  title: MatrixUsersListSearchBar(matrixUsers: matrixUsers),
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
                          return MatrixUsersListCard(matrixUsers[index]);
                        }, childCount: matrixUsers.length),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MatrixUsersListViewBottomNavbar(),
    );
  }
}
