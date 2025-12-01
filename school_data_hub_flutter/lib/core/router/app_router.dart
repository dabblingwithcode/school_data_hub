import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/upload_image.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/widgets/landing_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/core/session/serverpod_connectivity_monitor.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/attendance_page/attendance_list_page.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/missed_classes_pupil_list_page/missed_classes_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/presentation/schoolday_event_list_page/schoolday_event_list_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/entry_point/entry_point_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/error_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/loading_page.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/login_page/login_controller.dart';
import 'package:school_data_hub_flutter/features/app_entry_point/no_connection_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/learn_resources_menu_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/pupil_lists_menu_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/school_lists_page.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/tools_page.dart';
import 'package:school_data_hub_flutter/features/app_settings/settings_page/settings_page.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/authorizations_list_page/authorizations_list_page.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_list_page/book_list_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form/book_search_form_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_form/select_book_tags_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_search_page/book_search_results_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/book_tag_management_page/book_tag_management_controller.dart';
import 'package:school_data_hub_flutter/features/books/presentation/books_main_menu_page/books_main_menu_page.dart';
import 'package:school_data_hub_flutter/features/books/presentation/new_book_page/new_book_controller.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/competence_list_page/competence_list_page.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/pupil_competence_list_page/learning_pupil_list_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/learning_support_list_page.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_learning_support_plan/controller/new_learning_support_plan_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/controller/new_support_category_status_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/controller/category_list_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/services/learning_support_plan_pdf_generator.dart';
import 'package:school_data_hub_flutter/features/matrix/presentation/set_matrix_environment_page/set_matrix_environment_controller.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/matrix_users_list_page/matrix_users_list_page.dart';
import 'package:school_data_hub_flutter/features/matrix/users/presentation/pupil_matrix_contacts_list_page/pupils_matrix_contacts_list_page.dart';
import 'package:school_data_hub_flutter/features/ogs/ogs_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/_credit/credit_list_page/credit_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/birthdays_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/family_language_lessons_page/family_language_lessons_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_identity_stream_page/pupil_identity_stream_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/religion_page/religion_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/special_info_page/special_info_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_set_avatar.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_page/edit_school_data_page.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/new_school_semester_page/new_school_semester_page.dart';
import 'package:school_data_hub_flutter/features/school_calendar/presentation/new_school_semester_page/schooldays_calendar_page/schooldays_calendar_page.dart';
import 'package:school_data_hub_flutter/features/school_lists/presentation/school_lists_page/school_lists_page.dart';
import 'package:school_data_hub_flutter/features/statistics/chart_page/chart_page_controller.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_page/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/classroom_list_page/classroom_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/learning_group_list_page/learning_group_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_lesson_group_page/new_lesson_group_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_scheduled_lesson_page/new_scheduled_lesson_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/new_timetable_page/new_timetable_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/subject_list_page/subject_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_page/timetable_page.dart';
import 'package:school_data_hub_flutter/features/timetable/presentation/timetable_slot_list_page/timetable_slot_list_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/change_password/change_password_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/create_user/create_user_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/reset_password/reset_user_password_page.dart';
import 'package:school_data_hub_flutter/features/user/presentation/user_list/user_list_page.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/workbook_list_page/controller/workbook_list_view_model.dart';
import 'package:watch_it/watch_it.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      refreshListenable: Listenable.merge([
        di<EnvManager>().isAuthenticated,
        di<EnvManager>().envIsReady,
        di<ServerpodConnectivityMonitor>().isConnected,
      ]),
      redirect: (context, state) {
        final envManager = di<EnvManager>();
        final connectivityMonitor = di<ServerpodConnectivityMonitor>();

        final isConnected = connectivityMonitor.isConnected.value;
        final envIsReady = envManager.envIsReady.value;
        final isAuthenticated = envManager.isAuthenticated.value;

        final path = state.uri.path;

        final isLoginLoc = path == '/login';
        final isLoadingLoc = path == '/loading';
        final isNoConnectionLoc = path == '/no-connection';
        final isEntryPointLoc = path == '/';

        // 1. Connection Check
        if (!isConnected) {
          return isNoConnectionLoc ? null : '/no-connection';
        }
        if (isNoConnectionLoc && isConnected) {
          // If connection restored, verify where to go based on other states
          if (envIsReady && isAuthenticated) return '/home';
          if (envIsReady && !isAuthenticated) return '/login';
          return '/';
        }

        // 2. Environment Ready Check
        if (!envIsReady) {
          // If we are trying to load an active environment
          if (envManager.activeEnv != null) {
            return isLoadingLoc ? null : '/loading';
          }
          
          // Handle deep link when env is not ready - redirect to login with preserved parameters
          if (isEntryPointLoc &&
              state.uri.queryParameters.containsKey('channelName')) {
            final from = state.uri.toString();
            return '/login?from=${Uri.encodeComponent(from)}';
          }

          // Otherwise we are at entry point selection
          return isEntryPointLoc ? null : '/';
        }

        // 3. Auth Check
        if (!isAuthenticated) {
          if (isLoginLoc) return null;

          // Don't redirect system pages to login with return param
          if (isEntryPointLoc || isLoadingLoc || isNoConnectionLoc) {
            // If it's entry point with deep link params, preserve them for login redirect
            if (isEntryPointLoc &&
                state.uri.queryParameters.containsKey('channelName')) {
              final from = state.uri.toString();
              return '/login?from=${Uri.encodeComponent(from)}';
            }
            return '/login';
          }

          // Save intended location for deep links
          final from = state.uri.toString();
          return '/login?from=${Uri.encodeComponent(from)}';
        }

        // 4. Authenticated User
        if (isAuthenticated) {
          if (isLoginLoc || isEntryPointLoc || isLoadingLoc) {
            final from = state.uri.queryParameters['from'];
            if (from != null && from.isNotEmpty) return from;
            return '/home';
          }
        }

        // 5. Deep Link Handling
        // If authenticated, we allow pass-through to feature routes

        // Handle redirect for root path with stream parameters
        if (path == '/' &&
            state.uri.queryParameters.containsKey('channelName')) {
          final channelName = state.uri.queryParameters['channelName'];
          final url = state.uri.queryParameters['url'];
          
          // Force redirect to the stream page
          return '/pupil-identity-stream?code=$channelName&instance=$url';
        }

        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const EntryPoint()),
        GoRoute(path: '/login', builder: (context, state) => const Login()),
        GoRoute(
          path: '/loading',
          builder: (context, state) => const LoadingPage(),
        ),
        GoRoute(
          path: '/no-connection',
          builder: (context, state) => const NoConnectionPage(),
        ),
        // Deep Link Route for Pupil Identity Stream Receiver
        GoRoute(
          path: '/pupil-identity-stream',
          builder: (context, state) {
            final code = state.uri.queryParameters['code'];
            final instanceUrl = state.uri.queryParameters['instance'];
            final extra = state.extra as Map<String, dynamic>?;

            if (extra != null &&
                extra['role'] == PupilIdentityStreamRole.sender) {
              return PupilIdentityStreamPage(
                role: PupilIdentityStreamRole.sender,
                encryptedData: extra['encryptedData'],
                selectedPupilIds: extra['selectedPupilIds'],
              );
            }

            return PupilIdentityStreamPage(
              role: PupilIdentityStreamRole.receiver,
              importedChannelName: code ?? extra?['importedChannelName'],
              expectedInstanceUrl: instanceUrl,
            );
          },
        ),
        GoRoute(
          path: '/crop-avatar',
          builder: (context, state) {
            final image = state.extra as XFile;
            return CropAvatarView(image: image);
          },
        ),
        GoRoute(
          path: '/scanner',
          builder: (context, state) {
            final overlayText = state.extra as String? ?? 'Scanner';
            return ScannerPage(overlayText: overlayText);
          },
        ),
        GoRoute(
          path: '/timetable',
          builder: (context, state) => const TimetablePage(),
        ),
        GoRoute(
          path: '/timetable/new',
          builder: (context, state) => const NewTimetablePage(),
        ),
        GoRoute(
          path: '/timetable/slots',
          builder: (context, state) => const TimetableSlotListPage(),
        ),
        GoRoute(
          path: '/timetable/groups',
          builder: (context, state) => const LearningGroupListPage(),
        ),
        GoRoute(
          path: '/timetable/subjects',
          builder: (context, state) => const SubjectListPage(),
        ),
        GoRoute(
          path: '/timetable/lesson',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final manager = di<TimetableManager>();

            return NewScheduledLessonPage(
              timetableManager: manager,
              editingLessonId: extra?['editingLessonId'],
              preselectedSlotId: extra?['preselectedSlotId'],
            );
          },
        ),
        GoRoute(
          path: '/timetable/lesson-group',
          builder: (context, state) => const NewLessonGroupPage(),
        ),
        GoRoute(
          path: '/classrooms',
          builder: (context, state) => const ClassroomListPage(),
        ),
        GoRoute(
          path: '/charts',
          builder: (context, state) => const ChartPageController(),
        ),
        GoRoute(
          path: '/statistics',
          builder: (context, state) => const Statistics(),
        ),
        GoRoute(
          path: '/select-pupils',
          builder: (context, state) {
            final selectablePupils = state.extra as List<PupilProxy>? ?? [];
            return SelectPupilsListPage(selectablePupils: selectablePupils);
          },
        ),
        GoRoute(
          path: '/birthdays',
          builder: (context, state) {
            final selectedDate = state.extra as DateTime;
            return BirthdaysView(selectedDate: selectedDate);
          },
        ),
        GoRoute(
          path: '/crop-document',
          builder: (context, state) {
            final image = state.extra as XFile;
            return CropDocumentView(image: image);
          },
        ),
        GoRoute(
          path: '/admin/edit-school-data',
          builder: (context, state) => const EditSchoolDataPage(),
        ),
        GoRoute(
          path: '/admin/create-user',
          builder: (context, state) => const CreateUserPage(),
        ),
        GoRoute(
          path: '/admin/users',
          builder: (context, state) => const UserListPage(),
        ),
        GoRoute(
          path: '/admin/reset-password',
          builder: (context, state) => const ResetUserPasswordPage(),
        ),
        GoRoute(
          path: '/admin/matrix/set-environment',
          builder: (context, state) => const SetMatrixEnvironment(),
        ),
        GoRoute(
          path: '/admin/calendar',
          builder: (context, state) => const SchooldaysCalendarPage(),
        ),
        GoRoute(
          path: '/admin/new-semester',
          builder: (context, state) => const NewSchoolSemesterPage(),
        ),
        // Learning Resources
        GoRoute(
          path: '/learning/competences',
          builder: (context, state) => const CompetenceListPage(),
        ),
        GoRoute(
          path: '/learning/categories',
          builder: (context, state) => const CategoryList(),
        ),
        GoRoute(
          path: '/learning/workbooks',
          builder: (context, state) => const WorkbookList(),
        ),
        GoRoute(
          path: '/learning/books',
          builder: (context, state) => const BooksMainMenuPage(),
        ),
        GoRoute(
          path: '/learning/books/tags',
          builder: (context, state) => const BookTagManagement(),
        ),
        GoRoute(
          path: '/learning/books/list',
          builder: (context, state) => const BookListPage(),
        ),
        GoRoute(
          path: '/learning/books/new',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return NewBook(
              isEdit: extra?['isEdit'] ?? false,
              isbn: extra?['isbn'] ?? 0,
            );
          },
        ),
        GoRoute(
          path: '/learning/books/search',
          builder: (context, state) => const BookSearchFormPage(),
        ),
        GoRoute(
          path: '/learning/books/select-tags',
          builder: (context, state) {
            final extra = state.extra as List<BookTag>?;
            return SelectBookTagsPage(initialSelectedTags: extra ?? []);
          },
        ),
        GoRoute(
          path: '/learning/books/search-results',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return BookSearchResultsPage(
              title: extra?['title'] as String?,
              author: extra?['author'] as String?,
              keywords: extra?['keywords'] as String?,
              location: extra?['location'] as LibraryBookLocation?,
              readingLevel: extra?['readingLevel'] as String?,
              borrowStatus: extra?['borrowStatus'] as BorrowedStatus?,
              selectedTags: extra?['selectedTags'] as List<BookTag>? ?? [],
            );
          },
        ),
        GoRoute(
          path: '/pupil/new-support-category-status',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return NewSupportCategoryStatus(
              appBarTitle: extra?['appBarTitle'] as String,
              pupilId: extra?['pupilId'] as int,
              goalCategoryId: extra?['goalCategoryId'] as int,
              elementType: extra?['elementType'] as String,
            );
          },
        ),
        GoRoute(
          path: '/pupil/new-learning-support-plan',
          builder: (context, state) {
            final pupil = state.extra as PupilProxy;
            return NewLearningSupportPlan(pupil: pupil);
          },
        ),
        GoRoute(
          path: '/pupil/learning-support-plan-pdf',
          builder: (context, state) {
            final file = state.extra as File;
            return LearningSupportPlanPdfViewPage(pdfFile: file);
          },
        ),
        GoRoute(
          path: '/pupil/schoolday-events',
          builder: (context, state) => const SchooldayEventListPage(),
        ),
        GoRoute(
          path: '/pupil/missed-schooldays',
          builder: (context, state) => const MissedSchooldayesPupilListPage(),
        ),
        GoRoute(
          path: '/pupil/attendance',
          builder: (context, state) => const AttendanceListPage(),
        ),
        GoRoute(
          path: '/pupil/credit',
          builder: (context, state) => const CreditListPage(),
        ),
        GoRoute(
          path: '/pupil/learning-lists',
          builder: (context, state) => const LearningPupilListPage(),
        ),
        GoRoute(
          path: '/pupil/support-lists',
          builder: (context, state) => const LearningSupportListPage(),
        ),
        GoRoute(
          path: '/pupil/special-info',
          builder: (context, state) => const SpecialInfoListPage(),
        ),
        GoRoute(
          path: '/pupil/religion',
          builder: (context, state) => const ReligionListPage(),
        ),
        GoRoute(
          path: '/pupil/family-language',
          builder: (context, state) => const FamilyLanguageLessonsListPage(),
        ),
        GoRoute(
          path: '/pupil/ogs',
          builder: (context, state) => const OgsListPage(),
        ),
        GoRoute(
          path: '/pupil/matrix-users',
          builder: (context, state) => const MatrixUsersListPage(),
        ),
        GoRoute(
          path: '/pupil/matrix-contacts',
          builder: (context, state) => const PupilsMatrixContactsListPage(),
        ),
        GoRoute(
          path: '/school/lists',
          builder: (context, state) => const SchoolListsPage(),
        ),
        GoRoute(
          path: '/school/authorizations',
          builder: (context, state) => const AuthorizationsListPage(),
        ),
        GoRoute(
          path: '/settings/change-password',
          builder: (context, state) => const UserChangePasswordPage(),
        ),
        GoRoute(
          path: '/pupil/:id',
          builder: (context, state) {
            final idStr = state.pathParameters['id'];
            if (idStr == null)
              return const ErrorPage(error: "Keine ID übergeben");
            final id = int.tryParse(idStr);
            if (id == null) return const ErrorPage(error: "Ungültige ID");

            final pupilManager = di<PupilManager>();
            final pupil = pupilManager.getPupilByPupilId(id);

            if (pupil == null) {
              return const ErrorPage(error: "Schüler nicht gefunden");
            }
            return PupilProfilePage(pupil: pupil);
          },
        ),
        StatefulShellRoute(
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home', // Default tab (Pupil Lists)
                  builder: (context, state) => const PupilListsMenuPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/school',
                  builder: (context, state) => const SchoolListsMenuPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/learning',
                  builder: (context, state) => const LearnResourcesMenuPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/tools',
                  builder: (context, state) => const ToolsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (context, state) => const SettingsPage(),
                ),
              ],
            ),
          ],
          navigatorContainerBuilder: (context, navigationShell, children) {
            return MainMenuBottomNavigation(
              navigationShell: navigationShell,
              children: children,
            );
          },
          builder: (context, state, navigationShell) {
            return navigationShell; // Just return the shell, the container builder handles the UI logic
          },
        ),
      ],
    );
  }
}
