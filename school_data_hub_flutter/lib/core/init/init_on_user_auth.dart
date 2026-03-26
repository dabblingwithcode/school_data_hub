import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupil_media_auth_filters.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/filters/pupils_filter_impl.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/pupil_authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/filters/pupil_book_lending_filter_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/learning_content_selection.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_item_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/server_logs/data/server_logs_api_service.dart';
import 'package:school_data_hub_flutter/features/server_logs/domain/server_logs_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';

final _log = Logger('[Init][OnUserAuth]');

class InitOnUserAuth {
  static Future<void> registerManagers() async {
    if (await HubSecureStorage().containsKey(
      di<EnvManager>().storageKeyForMatrixCredentials,
    )) {
      _log.info(' Matrix credentials found');

      // Only register matrix managers if they're not already registered
      if (!di.hasScope(InitScope.onMatrixEnvScope.name)) {
        await InitManager.registerMatrixManagers();
      } else {
        _log.info(' Matrix managers already registered, skipping registration');
        // Ensure session configured flag is set even if skipping registration
        di<HubSessionManager>().setIsMatrixSessionConfigured(true);
      }
    } else {
      _log.info(' No matrix credentials found');
    }

    di.registerSingletonAsync<PupilIdentityManager>(
      () => PupilIdentityManager().init(),
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<HubStreamService>(
      () => HubStreamService().init(),
      dependsOn: [Client, HubSessionManager],
      dispose: (s) => s.dispose(),
    );

    di.registerSingletonAsync<SchoolCalendarManager>(
      () => SchoolCalendarManager().init(),
      dependsOn: [HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<SupportCategoryManager>(
      () => SupportCategoryManager().init(),
      dependsOn: [HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<PupilProxyManager>(
      () async {
        final manager = PupilProxyManager();
        await manager.init();
        return manager;
      },
      dependsOn: [PupilIdentityManager, HubSessionManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<LearningSupportManager>(
      () => LearningSupportManager().init(),
      dependsOn: [
        PupilProxyManager,
        SchoolCalendarManager,
        SupportCategoryManager,
        HubStreamService,
      ],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<BookManager>(
      () => BookManager().init(),
      dependsOn: [HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<PupilBookLendingManager>(
      () => PupilBookLendingManager().init(),
      dependsOn: [HubSessionManager, PupilProxyManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<SchoolDataMainManager>(
      () => SchoolDataMainManager().init(),
      dependsOn: [HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<WorkbookManager>(
      () => WorkbookManager().init(),
      dependsOn: [HubSessionManager, PupilProxyManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<PupilWorkbookManager>(
      () => PupilWorkbookManager().init(),
      dependsOn: [HubSessionManager, PupilProxyManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingleton<LearningContentSelection>(
      LearningContentSelection(),
      dispose: (s) => s.dispose(),
    );

    di.registerSingletonAsync<CompetenceManager>(
      () => CompetenceManager().init(),
      dependsOn: [HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<CompetenceFilterManager>(
      () => CompetenceFilterManager(),
      dependsOn: [CompetenceManager],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<CompetenceReportItemManager>(
      () => CompetenceReportItemManager().init(),
      dependsOn: [HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<CompetenceReportManager>(
      () => CompetenceReportManager().init(),
      dependsOn: [CompetenceReportItemManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<AuthorizationManager>(
      () => AuthorizationManager().init(),
      dependsOn: [HubSessionManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<AuthorizationFilterManager>(
      () {
        final manager = AuthorizationFilterManager()..init();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [AuthorizationManager],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<PupilAuthorizationFilterManager>(
      () {
        final manager = PupilAuthorizationFilterManager();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [AuthorizationManager],
      dispose: (m) => m.dispose(),
    );

    // Register FiltersStateManager before all filter managers so they can
    // register themselves during construction.
    di.registerSingleton<FiltersStateManager>(
      FiltersStateManagerImplementation(),
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<PupilBookLendingFilterManager>(
      () {
        final manager = PupilBookLendingFilterManager();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [PupilBookLendingManager],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<LearningSupportFilterManager>(
      () {
        final manager = LearningSupportFilterManager();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [PupilProxyManager],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<SchooldayEventManager>(
      () => SchooldayEventManager(),
      dependsOn: [SchoolCalendarManager, PupilProxyManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<SchooldayEventFilterManager>(
      () {
        final manager = SchooldayEventFilterManager();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [PupilProxyManager, SchooldayEventManager],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<AttendanceManager>(
      () => AttendanceManager(),
      dependsOn: [PupilProxyManager, SchoolCalendarManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<AttendancePupilFilterManager>(
      () {
        final manager = AttendancePupilFilterManager().init();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [AttendanceManager],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<PupilsFilter>(
      () {
        final manager = PupilsFilterImplementation(di<PupilProxyManager>());
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [
        PupilProxyManager,
        LearningSupportFilterManager,
        SchooldayEventFilterManager,
        AttendancePupilFilterManager,
      ],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<PupilMediaAuthFilterManager>(
      () {
        final manager = PupilMediaAuthFilterManager();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [PupilsFilter],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<SchoolListManager>(
      () => SchoolListManager().init(),
      dependsOn: [HubSessionManager, PupilProxyManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonWithDependencies<SchoolListFilterManager>(
      () {
        final manager = SchoolListFilterManager()..init();
        di<FiltersStateManager>().registerFilterManager(manager);
        return manager;
      },
      dependsOn: [PupilsFilter, SchoolListManager],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<UserManager>(
      () => UserManager().init(),
      dependsOn: [HubSessionManager, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerSingletonAsync<TimetableApiService>(
      () async => TimetableApiService(),
    );

    di.registerSingletonAsync<TimetableManager>(
      () => TimetableManager().init(),
      dependsOn: [HubSessionManager, TimetableApiService, HubStreamService],
      dispose: (m) => m.dispose(),
    );

    di.registerLazySingleton<ServerLogsApiService>(
      () => ServerLogsApiService(),
    );

    di.registerLazySingleton<ServerLogsManager>(
      () => ServerLogsManager(),
      dispose: (m) => m.dispose(),
    );

    _log.info('Managers depending on authentication are being initialized...');
  }
}
