import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/app_utils/secure_storage.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/core/init/init_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/authorization_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/domain/filters/pupil_authorization_filter_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/domain/filters/competence_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/filters/learning_support_filter_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupil_filter_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter_impl.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_identity_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:school_data_hub_flutter/features/timetable/timetable.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:watch_it/watch_it.dart';

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
      () async {
        final pupilIdentityManager = PupilIdentityManager();

        await pupilIdentityManager.init();

        _log.info('[PupilIdentityManager] initialized ✅️');

        return pupilIdentityManager;
      },
      dispose: (instance) {
        _log.info('[PupilIdentityManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<SchoolCalendarManager>(
      () async {
        final schoolCalendarManager = SchoolCalendarManager();

        await schoolCalendarManager.init();

        _log.info('[SchoolCalendarManager] initialized ✅️');

        return schoolCalendarManager;
      },
      dispose: (instance) {
        _log.info('[SchoolCalendarManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<SupportCategoryManager>(
      () async {
        final supportCategoryManager = SupportCategoryManager();

        await supportCategoryManager.init();

        _log.info('[SupportCategoryManager] initialized ✅️');

        return supportCategoryManager;
      },
      dispose: (instance) {
        _log.info('[SupportCategoryManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<PupilProxyManager>(
      () async {
        final pupilManager = PupilProxyManager();

        await pupilManager.init();

        _log.info('[PupilProxyManager] initialized ✅️');

        return pupilManager;
      },
      dependsOn: [PupilIdentityManager, HubSessionManager],
      dispose: (instance) {
        _log.info('[PupilProxyManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<LearningSupportManager>(
      () => LearningSupportManager(),
      dependsOn: [
        PupilProxyManager,
        SchoolCalendarManager,
        SupportCategoryManager,
      ],
      dispose: (instance) {
        _log.info('[LearningSupportManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<BookManager>(
      () async {
        final bookManager = BookManager();
        await bookManager.init();
        _log.info('[BookManager] initialized ✅️');
        return bookManager;
      },
      dependsOn: [],
      dispose: (instance) {
        _log.info('[BookManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<SchoolDataMainManager>(
      () async {
        final schoolDataManager = SchoolDataMainManager();
        await schoolDataManager.init();
        _log.info('[SchoolDataMainManager] initialized ✅️');
        return schoolDataManager;
      },
      dependsOn: [],
      dispose: (instance) {
        _log.info('[SchoolDataMainManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<WorkbookManager>(
      () async {
        final workbookManager = WorkbookManager();
        await workbookManager.init();
        _log.info('[WorkbookManager] initialized ✅️');
        return workbookManager;
      },
      dependsOn: [HubSessionManager, PupilProxyManager],
      dispose: (instance) {
        _log.info('[WorkbookManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<PupilWorkbookManager>(
      () async {
        final pupilWorkbookManager = PupilWorkbookManager();
        await pupilWorkbookManager.init();
        _log.info('[PupilWorkbookManager] initialized ✅️');
        return pupilWorkbookManager;
      },
      dispose: (instance) {
        _log.info('[PupilWorkbookManager] disposed 🚮');
        instance.dispose();
        return;
      },
      dependsOn: [HubSessionManager, PupilProxyManager],
    );

    di.registerSingletonAsync<CompetenceManager>(
      () async {
        final competenceManager = CompetenceManager();

        await competenceManager.init();

        _log.info('[CompetenceManager] initialized ✅️');

        return competenceManager;
      },
      dispose: (instance) {
        _log.info('[CompetenceManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<CompetenceFilterManager>(
      () {
        return CompetenceFilterManager();
      },
      dependsOn: [CompetenceManager],
      dispose: (instance) {
        _log.info('[CompetenceFilterManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonAsync<AuthorizationManager>(
      () async {
        final authorizationManager = AuthorizationManager();
        await authorizationManager.init();
        _log.info('[AuthorizationManager] initialized ✅️');
        return authorizationManager;
      },
      dependsOn: [HubSessionManager],
      dispose: (instance) {
        _log.info('[AuthorizationManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );
    di.registerSingletonWithDependencies<AuthorizationFilterManager>(
      () {
        final authorizationFilterManager = AuthorizationFilterManager();
        authorizationFilterManager.init();
        _log.info('[AuthorizationFilterManager] initialized ✅️');
        return authorizationFilterManager;
      },
      dependsOn: [AuthorizationManager],
      dispose: (instance) {
        _log.info('[AuthorizationFilterManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<PupilAuthorizationFilterManager>(
      () => PupilAuthorizationFilterManager(),
      dependsOn: [AuthorizationManager],
      dispose: (instance) {
        _log.info('[PupilAuthorizationFilterManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<PupilFilterManager>(
      () => PupilFilterManager(),
      dispose: (instance) {
        _log.info('[PupilFilterManager] disposed 🚮');
        instance.dispose();
        return;
      },
      dependsOn: [PupilProxyManager],
    );

    di.registerSingleton<FiltersStateManager>(
      FiltersStateManagerImplementation(),
      dispose: (instance) {
        _log.info('[FiltersStateManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<LearningSupportFilterManager>(
      () => LearningSupportFilterManager(),
      dependsOn: [PupilProxyManager, PupilFilterManager],
      dispose: (instance) {
        _log.info('[LearningSupportFilterManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<SchooldayEventManager>(
      () => SchooldayEventManager(),
      dependsOn: [SchoolCalendarManager, PupilProxyManager],
      dispose: (instance) {
        _log.info('[SchooldayEventManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<SchooldayEventFilterManager>(
      () {
        final schooldayEventFilterManager = SchooldayEventFilterManager();

        _log.info('[SchooldayEventFilterManager] initialized ✅️');
        return schooldayEventFilterManager;
      },
      dispose: (instance) {
        _log.info('[SchooldayEventFilterManager] disposed 🚮');
        instance.dispose();
        return;
      },
      dependsOn: [PupilProxyManager, PupilFilterManager, SchooldayEventManager],
    );

    di.registerSingletonWithDependencies<AttendanceManager>(
      () => AttendanceManager(),
      dependsOn: [PupilProxyManager, SchoolCalendarManager],
      dispose: (instance) {
        _log.info('[AttendanceManager] disposed 🚮');
        instance.dispose();
        return;
      },
    );

    di.registerSingletonWithDependencies<AttendancePupilFilterManager>(
      () {
        final attendancePupilFilterManager = AttendancePupilFilterManager();
        return attendancePupilFilterManager.init();
      },
      dispose: (instance) => instance.dispose(),
      dependsOn: [AttendanceManager],
    );

    di.registerSingletonWithDependencies<PupilsFilter>(
      () => PupilsFilterImplementation(di<PupilProxyManager>()),
      dispose: (instance) {
        instance.dispose();
        _log.info('[PupilsFilterImplementation] disposed 🚮');
        return;
      },
      dependsOn: [
        PupilProxyManager,

        PupilFilterManager,
        LearningSupportFilterManager,
        SchooldayEventFilterManager,
        AttendancePupilFilterManager,
      ],
    );

    di.registerSingletonAsync<SchoolListManager>(
      () async {
        final schoolListManager = SchoolListManager();
        await schoolListManager.init();
        _log.info('[SchoolListManager] initialized ✅️');
        return schoolListManager;
      },
      dispose: (instance) {
        _log.info('[SchoolListManager] disposed 🚮');
        instance.dispose();
        return;
      },
      dependsOn: [HubSessionManager, PupilProxyManager],
    );

    di.registerSingletonWithDependencies<SchoolListFilterManager>(
      () {
        final schoolListFilterManager = SchoolListFilterManager();
        schoolListFilterManager.init();
        _log.info('[SchoolListFilterManager] initialized ✅️');
        return schoolListFilterManager;
      },
      dispose: (instance) {
        _log.info('[SchoolListFilterManager] disposed 🚮');
        instance.dispose();
        return;
      },
      dependsOn: [PupilsFilter, SchoolListManager],
    );

    di.registerSingletonAsync<UserManager>(
      () async {
        final userManager = UserManager();
        await userManager.init();
        _log.info('[UserManager] initialized ✅️');
        return userManager;
      },
      dispose: (instance) {
        _log.info('[UserManager] disposed 🚮');
        instance.dispose();
        return;
      },
      dependsOn: [HubSessionManager],
    );

    di.registerSingletonAsync<TimetableApiService>(() async {
      final timetableApiService = TimetableApiService();
      _log.info('[TimetableApiService] initialized ✅️');
      return timetableApiService;
    });

    di.registerSingletonAsync<TimetableManager>(
      () async {
        final timetableManager = TimetableManager();
        await timetableManager.init();
        _log.info('[TimetableManager] initialized ✅️');
        return timetableManager;
      },
      dispose: (instance) {
        _log.info('[TimetableManager] disposed 🚮');
        instance.dispose();
        return;
      },
      dependsOn: [HubSessionManager, TimetableApiService],
    );

    _log.info('Managers depending on authentication are being initialized...');
  }
}
