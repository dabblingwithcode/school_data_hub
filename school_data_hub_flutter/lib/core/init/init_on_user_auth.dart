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
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:school_data_hub_flutter/features/timetable/timetable.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
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
    di.registerSingletonAsync<PupilIdentityManager>(() async {
      final pupilIdentityManager = PupilIdentityManager();

      await pupilIdentityManager.init();

      _log.info('[PUPIL IDENTITY MANAGER] PupilIdentityManager initialized');

      return pupilIdentityManager;
    });

    di.registerSingletonAsync<SchoolCalendarManager>(() async {
      final schoolCalendarManager = SchoolCalendarManager();

      await schoolCalendarManager.init();

      _log.info('[SCHOOL CALENDAR MANAGER] SchoolCalendarManager initialized');

      return schoolCalendarManager;
    });

    di.registerSingletonAsync<SupportCategoryManager>(() async {
      final supportCategoryManager = SupportCategoryManager();

      await supportCategoryManager.init();

      _log.info(
        '[SUPPORT CATEGORY MANAGER] SupportCategoryManager initialized',
      );

      return supportCategoryManager;
    });

    di.registerSingletonAsync<PupilManager>(() async {
      final pupilManager = PupilManager();

      await pupilManager.init();

      _log.info('[PUPIL MANAGER] PupilManager initialized');

      return pupilManager;
    }, dependsOn: [PupilIdentityManager, HubSessionManager]);

    di.registerSingletonWithDependencies<LearningSupportManager>(
      () => LearningSupportManager(),
      dependsOn: [PupilManager, SchoolCalendarManager, SupportCategoryManager],
    );

    di.registerSingletonAsync<BookManager>(() async {
      final bookManager = BookManager();
      await bookManager.init();
      _log.info('[BOOK MANAGER] BookManager initialized');
      return bookManager;
    }, dependsOn: []);

    di.registerSingletonAsync<SchoolDataMainManager>(() async {
      final schoolDataManager = SchoolDataMainManager();
      await schoolDataManager.init();
      _log.info('[SCHOOL DATA MAIN MANAGER] SchoolDataMainManager initialized');
      return schoolDataManager;
    }, dependsOn: []);

    di.registerSingletonAsync<WorkbookManager>(() async {
      final workbookManager = WorkbookManager();
      await workbookManager.init();
      _log.info('[WORKBOOK MANAGER] WorkbookManager initialized');
      return workbookManager;
    }, dependsOn: [HubSessionManager, PupilManager]);

    di.registerSingletonAsync<CompetenceManager>(() async {
      final competenceManager = CompetenceManager();

      await competenceManager.init();

      _log.info('[COMPETENCE MANAGER] CompetenceManager initialized');

      return competenceManager;
    });

    di.registerSingletonWithDependencies<CompetenceFilterManager>(() {
      return CompetenceFilterManager();
    }, dependsOn: [CompetenceManager]);

    di.registerSingletonAsync<AuthorizationManager>(() async {
      final authorizationManager = AuthorizationManager();
      await authorizationManager.init();
      _log.info('[AUTHORIZATION MANAGER] AuthorizationManager initialized');
      return authorizationManager;
    }, dependsOn: [HubSessionManager]);

    di.registerSingletonWithDependencies<PupilAuthorizationFilterManager>(
      () => PupilAuthorizationFilterManager(),
      dependsOn: [AuthorizationManager],
    );

    di.registerSingletonWithDependencies<AuthorizationFilterManager>(
      () {
        final authorizationFilterManager = AuthorizationFilterManager();
        return authorizationFilterManager.init();
      },
      dispose: (instance) => instance.dispose(),
      dependsOn: [AuthorizationManager],
    );

    di.registerSingletonWithDependencies<PupilFilterManager>(
      () => PupilFilterManager(),
      dependsOn: [PupilManager],
    );

    di.registerSingleton<FiltersStateManager>(
      FiltersStateManagerImplementation(),
    );

    di.registerSingletonWithDependencies<LearningSupportFilterManager>(
      () => LearningSupportFilterManager(),
      dependsOn: [PupilManager, PupilFilterManager],
    );

    di.registerSingletonWithDependencies<SchooldayEventManager>(
      () => SchooldayEventManager(),
      dependsOn: [SchoolCalendarManager, PupilManager],
    );

    di.registerSingletonWithDependencies<SchooldayEventFilterManager>(() {
      final schooldayEventFilterManager = SchooldayEventFilterManager();

      _log.info(
        '[SCHOOLDAY EVENT FILTER MANAGER] SchooldayEventFilterManager initialized',
      );
      return schooldayEventFilterManager;
    }, dependsOn: [PupilManager, PupilFilterManager, SchooldayEventManager]);

    di.registerSingletonWithDependencies<AttendanceManager>(
      () => AttendanceManager(),
      dependsOn: [PupilManager, SchoolCalendarManager],
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
      () => PupilsFilterImplementation(di<PupilManager>()),
      dispose: (instance) => instance.dispose(),
      dependsOn: [
        PupilManager,
        PupilIdentityManager,
        PupilFilterManager,
        LearningSupportFilterManager,
        SchooldayEventFilterManager,
        AttendancePupilFilterManager,
      ],
    );

    di.registerSingletonAsync<SchoolListManager>(() async {
      final schoolListManager = SchoolListManager();
      await schoolListManager.init();
      _log.info('[SCHOOL LIST MANAGER] SchoolListManager initialized');
      return schoolListManager;
    }, dependsOn: [HubSessionManager, PupilManager]);

    di.registerSingletonWithDependencies<SchoolListFilterManager>(() {
      final schoolListFilterManager = SchoolListFilterManager();
      schoolListFilterManager.init();
      _log.info(
        '[SCHOOL LIST FILTER MANAGER] SchoolListFilterManager initialized',
      );
      return schoolListFilterManager;
    }, dependsOn: [PupilsFilter, SchoolListManager]);

    di.registerSingletonAsync<UserManager>(() async {
      final userManager = UserManager();
      await userManager.init();
      _log.info('[USER MANAGER] UserManager initialized');
      return userManager;
    }, dependsOn: [HubSessionManager]);

    di.registerSingletonAsync<TimetableApiService>(() async {
      final timetableApiService = TimetableApiService();
      _log.info('[TIMETABLE API SERVICE] TimetableApiService initialized');
      return timetableApiService;
    });

    di.registerSingletonAsync<TimetableManager>(() async {
      final timetableManager = TimetableManager();
      await timetableManager.init();
      _log.info('[TIMETABLE MANAGER] TimetableManager initialized');
      return timetableManager;
    }, dependsOn: [HubSessionManager, TimetableApiService]);

    _log.info('Managers depending on authentication are being initialized...');
  }
}
