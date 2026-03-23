import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/core/router/router_notifier.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/error_screen.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_screen.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_screen/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/no_connection_screen.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/scaffold_with_nav_bar.dart';

// --- Feature screen imports for top-level routes ---
// Pupil lists
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/schoolday_event_list_screen/schoolday_event_list_screen.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/presentation/new_schoolday_event_screen/new_schoolday_event_screen.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/missed_schooldays_pupil_list_screen/missed_schooldays_pupil_list_screen.dart';
import 'package:school_data_hub_flutter/features/attendance/presentation/attendance_screen/attendance_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/credit/credit_list_screen/credit_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/special_info_screen/special_info_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/religion_screen/religion_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/family_language_lessons_list_screen/family_language_lessons_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/after_school_care_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/public_media_auth_screen/public_media_auth_list_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_screen/select_pupils_list_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/pupil_matrix_contacts_list_screen/pupils_matrix_contacts_list_screen.dart';
// Learning (pupil list + resources)
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_screen/pupil_list_learning_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_screen/learning_support_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_screen/competence_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_sortable_screen/competence_sortable_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/post_or_patch_competence_screen/post_or_patch_competence_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/multi_pupil_competence_check_screen/multi_pupil_competence_check_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/select_competence_screen/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/new_competence_report_screen/new_competence_report_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/pupil_competence_report_screen/pupil_competence_report_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/post_or_patch_report_item_screen/post_or_patch_report_item_screen.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_items_sortable_list_screen/sortable_report_item_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_screen/support_category_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_screen/sortable_support_category_list_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/post_or_patch_support_category_screen/post_or_patch_support_category_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_screen/select_support_category_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_screen/select_parent_category_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/set_bulk_support_categoies_status_screen/set_bulk_support_categoies_status_scren.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_goal_screen/new_support_goal_screen.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_screen/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan_screen/controller/new_learning_support_plan_controller.dart' show NewLearningSupportPlan;
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_screen/workbook_list_screen.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_screen/new_workbook_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/books_main_menu_screen/books_main_menu_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_infos_screen/book_infos_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/edit_book_screen/edit_book_controller.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/presentation/competence_report_item_list_screen/competence_report_item_list_scope.dart';
// School lists
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_screen/school_lists_screen.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/new_list_screen/new_school_list_screen.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_list_pupil_entries_screen/school_list_pupil_entries_screen.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_screen/authorizations_list_screen.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/new_authorization_screen/new_authorization_screen.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorization_pupils_screen/authorization_pupils_screen.dart';
// School calendar
import 'package:school_data_hub_flutter/features/school_calendar/presentation/school_semester_list_screen/school_semester_list_screen.dart';
// Tools
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_screen/timetable_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_screen/new_timetable_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_screen/new_scheduled_lesson_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/lesson_group_list_page/lesson_group_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/lesson_group/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom/classroom_list_page/classroom_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom/new_classroom_page/new_classroom_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject_list_screen/subject_list_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_subject_screen/new_subject_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/timetable_slot_list_screen/timetable_slot_list_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot/new_timetable_slot_screen/new_timetable_slot_screen.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/schooldays_calendar_screen/schooldays_calendar_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_screen/matrix_users_list_screen.dart';
// Matrix
import 'package:school_data_hub_flutter/features/app_main_navigation/matrix_tools_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/set_matrix_environment_screen/set_matrix_environment_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/new_matrix_user_screen/new_matrix_user_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_rooms_list_screen/matrix_rooms_list_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/matrix_room_edit_screen/matrix_room_edit_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/presentation/new_matrix_room_screen/new_matrix_room_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/policy/presentation/matrix_event_reports_screen/matrix_event_reports_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/select_matrix_users_list_screen/controller/select_matrix_users_list_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/rooms/domain/models/matrix_room.dart';
import 'package:school_data_hub_flutter/features/matrix/users/domain/models/matrix_user.dart';
// Admin / User
import 'package:school_data_hub_flutter/features/user/presentation/user_list/user_list_screen.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/create_user_screen.dart' show CreateOrEditUserScreen;
import 'package:school_data_hub_flutter/features/user/presentation/reset_password/reset_user_password_screen.dart';
import 'package:school_data_hub_flutter/features/user/presentation/batch_import_users/batch_import_users_screen.dart';
import 'package:school_data_hub_flutter/features/user/presentation/select_users/select_users_screen.dart';
// Pupil profile + utility screens
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/birthdays_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_identity_stream_screen/pupil_identity_stream_screen.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_screen/edit_school_data_screen.dart';
import 'package:school_data_hub_flutter/app_utils/logger/presentation/logs_screen/logs_screen.dart';
import 'package:school_data_hub_flutter/features/user/presentation/change_password/change_password_screen.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form_screen/book_search_form_screen.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_screen/chart_page_controller.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_screen/controller/statistics.dart';
import 'package:school_data_hub_flutter/app_utils/shorebird_code_push_screen.dart';
import 'package:school_data_hub_flutter/features/server_model_diagram/presentation/server_model_diagram_screen.dart';
import 'package:school_data_hub_flutter/app_utils/pdf_viewer_screen.dart';
import 'package:school_data_hub_flutter/features/server_logs/presentation/server_logs_screen.dart';
import 'package:school_data_hub_flutter/features/matrix/logs/presentation/matrix_corporal_logs_screen.dart';

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

          // --- Previously missing routes: already have path constants ---
          GoRoute(
            path: RoutePaths.schoolSemesters,
            builder: (_, __) => const SchoolSemesterListScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningCompetencesSortable,
            builder: (_, __) => const CompetenceSortableListScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningCompetenceReportSortable,
            builder: (_, __) => const SortableReportItemListScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminUsers,
            builder: (_, __) => const UserListScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminUsersNew,
            builder: (_, __) => const CreateOrEditUserScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminUsersResetPassword,
            builder: (_, __) => const ResetUserPasswordScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminMatrix,
            builder: (_, __) => const MatrixToolsScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminMatrixSetEnv,
            builder: (_, __) => const SetMatrixEnvironmentScreen(),
          ),
          GoRoute(
            path: RoutePaths.settingsShorebirdUpdate,
            builder: (_, __) => const ShorebirdCodePushScreen(),
          ),

          // --- Authorizations ---
          GoRoute(
            path: RoutePaths.authorizationNew,
            builder: (_, __) => const NewAuthorizationScreen(),
          ),
          GoRoute(
            path: RoutePaths.authorizationPupils,
            builder: (_, state) => AuthorizationPupilsScreen(
              state.extra! as Authorization,
            ),
          ),

          // --- School Lists ---
          GoRoute(
            path: RoutePaths.schoolListNew,
            builder: (_, state) => NewSchoolListScreen(
              initialSchoolList: state.extra as SchoolList?,
            ),
          ),
          GoRoute(
            path: RoutePaths.schoolListEntries,
            builder: (_, state) => SchoolListPupilEntriesScreen(
              state.extra! as SchoolList,
            ),
          ),

          // --- Schoolday Events ---
          GoRoute(
            path: RoutePaths.schooldayEventNew,
            builder: (_, state) => NewSchooldayEventScreen(
              pupilId: state.extra! as int,
            ),
          ),

          // --- Workbooks ---
          GoRoute(
            path: RoutePaths.workbookNew,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return NewWorkbookScreen(
                isEdit: args['isEdit'] as bool,
                isbn: args['isbn'] as int,
                amount: args['amount'] as int?,
                workbook: args['workbook'] as Workbook?,
              );
            },
          ),

          // --- Learning Competence ---
          GoRoute(
            path: RoutePaths.learningCompetenceEdit,
            builder: (_, state) {
              final args = state.extra as Map<String, dynamic>?;
              return PostOrPatchCompetenceScreen(
                competence: args?['competence'] as Competence?,
                parentCompetence: args?['parentCompetence'] as int?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.learningCompetenceCheck,
            builder: (_, state) => MultiPupilCompetenceCheckScreen(
              competence: state.extra! as Competence,
            ),
          ),
          GoRoute(
            path: RoutePaths.learningCompetenceSelect,
            builder: (_, state) => SelectCompetence(
              onSelected:
                  state.extra
                      as void Function(BuildContext, Competence)?,
            ),
          ),

          // --- Learning Competence Report ---
          GoRoute(
            path: RoutePaths.learningCompetenceReportNew,
            builder: (_, state) => NewCompetenceReportScreen(
              pupil: state.extra! as PupilProxy,
            ),
          ),
          GoRoute(
            path: RoutePaths.learningCompetenceReportPupil,
            builder: (_, state) => PupilCompetenceReportScreen(
              pupil: state.extra! as PupilProxy,
            ),
          ),
          GoRoute(
            path: RoutePaths.learningCompetenceReportItemEdit,
            builder: (_, state) {
              final args = state.extra as Map<String, dynamic>?;
              return PostOrPatchReportItemScreen(
                parentItem: args?['parentItem'] as int?,
                item: args?['item'] as CompetenceReportItem?,
              );
            },
          ),

          // --- Learning Support ---
          GoRoute(
            path: RoutePaths.learningSupportCategoryEdit,
            builder: (_, state) {
              final args = state.extra as Map<String, dynamic>?;
              return PostOrPatchSupportCategoryScreen(
                category: args?['category'] as SupportCategory?,
                parentCategoryId: args?['parentCategoryId'] as int?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.learningSupportCategorySortable,
            builder: (_, __) => const SortableSupportCategoryListScreen(),
          ),
          GoRoute(
            path: RoutePaths.learningSupportCategorySelect,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return SelectSupportCategoryScreen(
                pupil: args['pupil'] as PupilProxy,
                elementType: args['elementType'] as String,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.learningSupportCategorySelectParent,
            builder: (_, state) => SelectParentCategoryScreen(
              movingCategoryId: state.extra! as int,
            ),
          ),
          GoRoute(
            path: RoutePaths.learningSupportCategoryBulkStatus,
            builder: (_, state) => SetBulkSupportCategoriesStatusScreen(
              pupil: state.extra! as PupilProxy,
            ),
          ),
          GoRoute(
            path: RoutePaths.learningSupportGoalNew,
            builder: (_, state) => NewSupportGoalScreen(
              state.extra! as NewSupportCategoryStatusController,
            ),
          ),
          GoRoute(
            path: RoutePaths.learningSupportNewPlan,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return NewLearningSupportPlan(
                pupil: args['pupil'] as PupilProxy,
                existingPlan: args['existingPlan'] as LearningSupportPlan?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.learningSupportNewStatus,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return NewSupportCategoryStatus(
                appBarTitle: args['appBarTitle'] as String,
                pupilId: args['pupilId'] as int,
                goalCategoryId: args['goalCategoryId'] as int,
                elementType: args['elementType'] as String,
                existingGoal: args['existingGoal'] as SupportGoal?,
              );
            },
          ),

          // --- Matrix ---
          GoRoute(
            path: RoutePaths.adminMatrixNewUser,
            builder: (_, state) {
              final args = state.extra as Map<String, dynamic>?;
              return NewMatrixUserScreen(
                matrixId: args?['matrixId'] as String?,
                displayName: args?['displayName'] as String?,
                pupil: args?['pupil'] as PupilProxy?,
                isParent: args?['isParent'] as bool?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.adminMatrixRooms,
            builder: (_, __) => const MatrixRoomsListScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminMatrixRoomEdit,
            builder: (_, state) => MatrixRoomEditScreen(
              room: state.extra! as MatrixRoom,
            ),
          ),
          GoRoute(
            path: RoutePaths.adminMatrixRoomNew,
            builder: (_, __) => const NewMatrixRoomScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminMatrixEventReports,
            builder: (_, __) => const MatrixEventReportsScreen(),
          ),
          GoRoute(
            path: RoutePaths.adminMatrixSelectUsers,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return SelectMatrixUsersList(
                args['selectableMatrixUsers'] as List<MatrixUser>?,
              );
            },
          ),

          // --- Admin / User ---
          GoRoute(
            path: RoutePaths.adminUsersBatchImport,
            builder: (_, __) => const BatchImportUsersScreen(),
          ),

          // --- Books ---
          GoRoute(
            path: RoutePaths.learningBooksEdit,
            builder: (_, state) => EditBook(
              libraryBook:
                  state.extra! as LibraryBookProxy,
            ),
          ),
          GoRoute(
            path: RoutePaths.learningBooksInfo,
            builder: (_, state) => BookInfosScreen(
              libraryId: state.extra! as String,
            ),
          ),

          // --- Timetable ---
          GoRoute(
            path: RoutePaths.toolsTimetableSlots,
            builder: (_, __) => const TimetableSlotListScreen(),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableGroups,
            builder: (_, __) => const LessonGroupListScreen(),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableClassrooms,
            builder: (_, __) => const ClassroomListScreen(),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableSubjects,
            builder: (_, __) => const SubjectListScreen(),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableNew,
            builder: (_, state) => NewTimetableScreen(
              timetable: state.extra as Timetable?,
            ),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableNewLesson,
            builder: (_, state) {
              final args = state.extra as Map<String, dynamic>?;
              return NewScheduledLessonScreen(
                timetableManager: di<TimetableManager>(),
                preselectedSlotId: args?['preselectedSlotId'] as int?,
                editingLessonId: args?['editingLessonId'] as int?,
                initialWeekday: args?['initialWeekday'] as Weekday?,
                initialStartTime: args?['initialStartTime'] as String?,
                initialClassroom: args?['initialClassroom'] as Classroom?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableNewLessonGroup,
            builder: (_, state) => NewLessonGroupScreen(
              lessonGroup: state.extra as LessonGroup?,
            ),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableNewClassroom,
            builder: (_, state) => NewClassroomScreen(
              classroom: state.extra as Classroom?,
            ),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableNewSubject,
            builder: (_, state) => NewSubjectScreen(
              subject: state.extra as Subject?,
            ),
          ),
          GoRoute(
            path: RoutePaths.toolsTimetableNewSlot,
            builder: (_, state) {
              final args = state.extra as Map<String, dynamic>?;
              return NewTimetableSlotScreen(
                timetableManager: di<TimetableManager>(),
                timetableSlot: args?['timetableSlot'] as TimetableSlot?,
              );
            },
          ),

          // --- Settings ---
          GoRoute(
            path: RoutePaths.settingsServerDiagram,
            builder: (_, __) => const ServerModelDiagramScreen(),
          ),
          GoRoute(
            path: RoutePaths.settingsServerLogs,
            builder: (_, __) => const ServerLogsScreen(),
          ),
          GoRoute(
            path: RoutePaths.settingsMatrixCorporalLogs,
            builder: (_, __) => const MatrixCorporalLogsScreen(),
          ),

          // --- Utility ---
          GoRoute(
            path: RoutePaths.pupilBirthdays,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return BirthdaysScreen(
                selectedDate: args['selectedDate'] as DateTime,
                endDate: args['endDate'] as DateTime?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.pupilIdentityStream,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return PupilIdentityStreamScreen(
                role: args['role'] as PupilIdentityStreamRole,
                encryptedData: args['encryptedData'] as String?,
                importedChannelName: args['importedChannelName'] as String?,
                selectedPupilIds: args['selectedPupilIds'] as List<int>?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.utilPdfViewer,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return PdfViewerScreen(
                pdfGenerator: args['pdfGenerator'] as Future<File> Function(),
                title: (args['title'] as String?) ?? 'PDF Vorschau',
              );
            },
          ),
          GoRoute(
            path: RoutePaths.utilSelectUsers,
            builder: (_, state) {
              final args = state.extra! as Map<String, dynamic>;
              return SelectUsersScreen(
                selectableUsers: args['selectableUsers'] as List<User>,
                authorizedUsers: args['authorizedUsers'] as String?,
                isMultiSelectMode: args['isMultiSelectMode'] as bool?,
              );
            },
          ),
          GoRoute(
            path: RoutePaths.utilSelectPupils,
            builder: (_, state) => SelectPupilsListScreen(
              selectablePupils: state.extra as List<PupilProxy>?,
            ),
          ),

          // --- Main app shell with bottom navigation (5 tabs via PageView) ---
          GoRoute(
            path: RoutePaths.home,
            builder: (_, state) =>
                ScaffoldWithNavBar(initialTab: state.extra as int?),
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
