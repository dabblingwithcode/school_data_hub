import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/core/router/router_notifier.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/error_screen.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_screen.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_screen/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/no_connection_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/learn_resources_menu_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/pupil_lists_menu_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/school_lists_menu_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/tools_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/scaffold_with_nav_bar.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_screen/settings_screen.dart';

// --- Feature screen imports for top-level routes ---
// Pupil lists
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_screen/schoolday_event_list_screen.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/missed_schooldays_pupil_list_screen/missed_schooldays_pupil_list_screen.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/attendance_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/credit/credit_list_screen/credit_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/special_info_screen/special_info_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/religion_screen/religion_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/family_language_lessons_list_screen/family_language_lessons_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/after_school_care_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/public_media_auth_screen/public_media_auth_list_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/pupil_matrix_contacts_list_screen/pupils_matrix_contacts_list_screen.dart';
// Learning (pupil list + resources)
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/pupil_list_learning_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_screen/learning_support_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_screen/competence_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_screen/support_category_list_screen.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_screen/workbook_list_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/books_main_menu_screen/books_main_menu_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_screen/competence_report_item_list_scope.dart';
// School lists
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_screen/school_lists_screen.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_screen/authorizations_list_screen.dart';
// Tools
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_screen/timetable_screen.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/schooldays_calendar_screen/schooldays_calendar_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/matrix_users_list_screen.dart';
// Pupil profile + utility screens
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_screen/edit_school_data_screen.dart';
import 'package:school_data_hub_flutter/app_utils/logger/presentation/logs_screen/logs_screen.dart';
import 'package:school_data_hub_flutter/features/user/presentation/change_password/change_password_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form_screen/book_search_form_screen.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_screen/chart_page_controller.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_screen/controller/statistics.dart';

final _log = Logger('AppRouter');

class AppRouter {
  final GoRouter router;

  AppRouter({required GlobalKey<NavigatorState> navigatorKey})
    : router = GoRouter(
        navigatorKey: navigatorKey,
        refreshListenable: RouterNotifier(),
        initialLocation: RoutePaths.entryPoint,
        redirect: _redirect,
        errorBuilder: (context, state) {
          _log.severe('Router error: ${state.error}');
          return ErrorScreen(error: state.error?.toString() ?? 'Unknown error');
        },
        routes: [
          // --- Auth / Boot routes ---
          GoRoute(
            path: RoutePaths.entryPoint,
            builder: (context, state) => const EntryPoint(),
          ),
          GoRoute(
            path: RoutePaths.login,
            builder: (context, state) => const Login(),
          ),
          GoRoute(
            path: RoutePaths.loading,
            builder: (context, state) => const LoadingScreen(),
          ),
          GoRoute(
            path: RoutePaths.noConnection,
            builder: (context, state) => const NoConnectionScreen(),
          ),

          // --- Feature routes (full-screen, above shell — no bottom nav) ---
          // Pupil lists
          GoRoute(
            path: RoutePaths.pupilSchooldayEvents,
            builder: (_, __) => const SchooldayEventListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilMissedSchooldays,
            builder: (_, __) => const MissedSchooldaysPupilListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilAttendance,
            builder: (_, __) => const AttendanceListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilCredit,
            builder: (_, __) => const CreditListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilSpecialInfo,
            builder: (_, __) => const SpecialInfoListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilReligion,
            builder: (_, __) => const ReligionListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilFamilyLanguage,
            builder: (_, __) => const FamilyLanguageLessonsListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilAfterSchoolCare,
            builder: (_, __) => const AfterSchoolCareListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilPublicMediaAuth,
            builder: (_, __) => const PublicMediaAuthListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilMatrixContacts,
            builder: (_, __) => const PupilsMatrixContactsListScreen(),
          ),
          GoRoute(
            path: RoutePaths.pupilLearningSupport,
            builder: (_, __) => const LearningSupportListScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningPupilList,
            builder: (_, __) => const PupilListLearningScreen(),
          ),
          // School lists
          GoRoute(
            path: RoutePaths.schoolListsDetail,
            builder: (_, __) => const SchoolListsScreen(),
          ),
          GoRoute(
            path: RoutePaths.schoolAuthorizations,
            builder: (_, __) => const AuthorizationsListScreen(),
          ),
          // Learning resources
          GoRoute(
            path: RoutePaths.learningCompetences,
            builder: (_, __) => const CompetenceListScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningSupportCategory,
            builder: (_, __) => const CategoryListScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningWorkbooks,
            builder: (_, __) => const WorkbookListScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningBooks,
            builder: (_, __) => const BooksMainMenuScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningCompetenceReport,
            builder: (_, __) => const CompetenceReportItemListScope(),
          ),
          // Tools
          GoRoute(
            path: RoutePaths.toolsTimetable,
            builder: (_, __) => const TimetablePage(),
          ),
          GoRoute(
            path: RoutePaths.schoolCalendar,
            builder: (_, __) => const SchooldaysCalendarScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminMatrixUsers,
            builder: (_, __) => const MatrixUsersListScreen(),
          ),

          // Pupil profile (extra: PupilProxy)
          GoRoute(
            path: RoutePaths.pupilProfile,
            builder: (_, state) => PupilProfileScreen(
              pupil: state.extra! as PupilProxy,
            ),
          ),
          // Utility / no-param screens
          GoRoute(
            path: RoutePaths.schoolEdit,
            builder: (_, __) => const EditSchoolDataScreen(),
          ),
          GoRoute(
            path: RoutePaths.settingsLogs,
            builder: (_, __) => const LogsScreen(),
          ),
          GoRoute(
            path: RoutePaths.settingsChangePassword,
            builder: (_, __) => const UserChangePasswordScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningBooksSearch,
            builder: (_, __) => const BookSearchFormScreen(),
          ),
          GoRoute(
            path: RoutePaths.toolsCharts,
            builder: (_, __) => const ChartPageController(),
          ),
          GoRoute(
            path: RoutePaths.toolsStatistics,
            builder: (_, __) => const Statistics(),
          ),

          // --- Main app shell with bottom navigation (5 tabs) ---
          StatefulShellRoute(
            builder: (context, state, navigationShell) => navigationShell,
            navigatorContainerBuilder: (
              BuildContext context,
              StatefulNavigationShell navigationShell,
              List<Widget> children,
            ) =>
                ScaffoldWithNavBar(
              navigationShell: navigationShell,
              children: children,
            ),
            branches: [
              // Tab 0 — Pupil Lists
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.home,
                    builder: (context, state) =>
                        const PupilListsMenuScreen(),
                  ),
                ],
              ),
              // Tab 1 — School Lists
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.schoolLists,
                    builder: (context, state) =>
                        const SchoolListsMenuScreen(),
                  ),
                ],
              ),
              // Tab 2 — Learning Resources
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.learning,
                    builder: (context, state) =>
                        const LearnResourcesMenuScreen(),
                  ),
                ],
              ),
              // Tab 3 — Tools
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.tools,
                    builder: (context, state) => const ToolsScreen(),
                  ),
                ],
              ),
              // Tab 4 — Settings
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.settings,
                    builder: (context, state) => const SettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  /// Redirect guard — evaluates on every navigation and whenever
  /// [RouterNotifier] fires (connection/env/auth state changes).
  ///
  /// Only accesses core-scope singletons (always available).
  static String? _redirect(BuildContext context, GoRouterState state) {
    final envManager = di<EnvManager>();
    final connectivityMonitor = di<ServerpodConnectivityMonitor>();

    final isConnected = connectivityMonitor.isConnected.value;
    final envIsReady = envManager.envIsReady.value;
    final isAuthenticated = envManager.isAuthenticated.value;

    final path = state.uri.path;

    // 1. No connection → /no-connection
    if (!isConnected) {
      if (path == RoutePaths.noConnection) return null;
      return RoutePaths.noConnection;
    }

    // Connection restored — leave /no-connection
    if (path == RoutePaths.noConnection) {
      if (envIsReady && isAuthenticated) return RoutePaths.home;
      if (envIsReady) return RoutePaths.login;
      return RoutePaths.entryPoint;
    }

    // 2. Environment not ready
    if (!envIsReady) {
      // Active env selected but still loading
      if (envManager.activeEnv != null) {
        if (path == RoutePaths.loading) return null;
        return RoutePaths.loading;
      }
      // No env selected — show school key entry
      if (path == RoutePaths.entryPoint) return null;
      return RoutePaths.entryPoint;
    }

    // 3. Not authenticated → /login
    if (!isAuthenticated) {
      if (path == RoutePaths.login) return null;

      // Preserve deep link target for post-login redirect
      final from = state.uri.toString();
      if (from == RoutePaths.entryPoint ||
          from == RoutePaths.loading ||
          from == RoutePaths.noConnection) {
        return RoutePaths.login;
      }
      return '${RoutePaths.login}?from=${Uri.encodeComponent(from)}';
    }

    // 4. Authenticated — redirect away from auth/boot pages
    if (path == RoutePaths.login ||
        path == RoutePaths.entryPoint ||
        path == RoutePaths.loading ||
        path == RoutePaths.noConnection) {
      // Check for preserved deep link target
      final from = state.uri.queryParameters['from'];
      if (from != null && from.isNotEmpty) {
        return Uri.decodeComponent(from);
      }
      return RoutePaths.home;
    }

    // 5. Allow pass-through for all other routes
    return null;
  }
}
