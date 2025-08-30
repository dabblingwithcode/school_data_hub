import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/attendance_manager.dart';
import 'package:school_data_hub_flutter/features/_attendance/domain/filters/attendance_pupil_filter.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/filters/schoolday_event_filter_manager.dart';
import 'package:school_data_hub_flutter/features/_schoolday_events/domain/schoolday_event_manager.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
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
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/filters/school_list_filter_manager.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:school_data_hub_flutter/features/timetable/data/timetable_api_service.dart';
import 'package:school_data_hub_flutter/features/timetable/timetable.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('DiOnUserAuth');

class DiInitOnUserAuth {
  static Future<void> registerManagers() async {
    di.registerSingleton<BottomNavManager>(BottomNavManager());

    di.registerSingletonAsync<PupilIdentityManager>(() async {
      final pupilIdentityManager = PupilIdentityManager();

      await pupilIdentityManager.init();

      _log.info('PupilIdentityManager initialized');

      return pupilIdentityManager;
    });

    di.registerSingletonAsync<SchoolCalendarManager>(() async {
      final schoolCalendarManager = SchoolCalendarManager();

      await schoolCalendarManager.init();

      _log.info('SchoolCalendarManager initialized');

      return schoolCalendarManager;
    });

    di.registerSingletonAsync<SupportCategoryManager>(() async {
      final supportCategoryManager = SupportCategoryManager();

      await supportCategoryManager.init();

      _log.info('SupportCategoryManager initialized');

      return supportCategoryManager;
    });

    di.registerSingletonAsync<PupilManager>(() async {
      final pupilManager = PupilManager();

      await pupilManager.init();

      _log.info('PupilManager initialized');

      return pupilManager;
    }, dependsOn: [PupilIdentityManager, HubSessionManager]);

    di.registerSingletonWithDependencies<LearningSupportManager>(
      () => LearningSupportManager(),
      dependsOn: [PupilManager, SchoolCalendarManager, SupportCategoryManager],
    );

    di.registerSingletonAsync<BookManager>(() async {
      log('Registering BookManager');
      final bookManager = BookManager();
      await bookManager.init();
      log('BookManager initialized');
      return bookManager;
    }, dependsOn: []);

    di.registerSingletonAsync<WorkbookManager>(() async {
      log('Registering WorkbookManager');
      final workbookManager = WorkbookManager();
      await workbookManager.init();
      log('WorkbookManager initialized');
      return workbookManager;
    }, dependsOn: [HubSessionManager, PupilManager]);
    di.registerSingletonAsync<CompetenceManager>(() async {
      final competenceManager = CompetenceManager();

      await competenceManager.init();

      _log.info('CompetenceManager initialized');

      return competenceManager;
    });

    di.registerSingletonWithDependencies<CompetenceFilterManager>(() {
      return CompetenceFilterManager();
    }, dependsOn: [CompetenceManager]);

    di.registerSingletonAsync<AuthorizationManager>(() async {
      log('Registering AuthorizationManager');
      final authorizationManager = AuthorizationManager();
      await authorizationManager.init();
      log('AuthorizationManager initialized');
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

    di.registerSingletonWithDependencies<LearningSupportFilterManager>(
      () => LearningSupportFilterManager(),
      dependsOn: [PupilManager, PupilFilterManager],
    );

    di.registerSingletonWithDependencies<SchooldayEventFilterManager>(() {
      _log.info('SchooldayEventFilterManager initializing');
      return SchooldayEventFilterManager();
    }, dependsOn: [PupilManager, PupilFilterManager]);

    di.registerSingletonWithDependencies<PupilsFilter>(
      () => PupilsFilterImplementation(di<PupilManager>()),
      dispose: (instance) => instance.dispose(),
      dependsOn: [PupilManager, PupilFilterManager],
    );

    di.registerSingleton<FiltersStateManager>(
      FiltersStateManagerImplementation(),
    );

    di.registerSingletonWithDependencies<AttendanceManager>(
      () => AttendanceManager(),
      dependsOn: [SchoolCalendarManager, PupilsFilter],
    );

    di.registerSingletonAsync<SchoolListManager>(() async {
      _log.info('Registering SchoolListManager');
      final schoolListManager = SchoolListManager();
      await schoolListManager.init();
      _log.info('SchoolListManager initialized');
      return schoolListManager;
    }, dependsOn: [HubSessionManager, PupilManager]);

    di.registerSingletonWithDependencies<SchoolListFilterManager>(() {
      final schoolListFilterManager = SchoolListFilterManager();
      schoolListFilterManager.init();
      return schoolListFilterManager;
    }, dependsOn: [PupilsFilter, SchoolListManager]);

    di.registerSingletonWithDependencies<AttendancePupilFilterManager>(
      () {
        final attendancePupilFilterManager = AttendancePupilFilterManager();
        return attendancePupilFilterManager.init();
      },
      dispose: (instance) => instance.dispose(),
      dependsOn: [AttendanceManager, PupilsFilter],
    );
    _log.info('Managers depending on authenticated session initialized');

    di.registerSingletonWithDependencies<SchooldayEventManager>(
      () => SchooldayEventManager(),
      dependsOn: [SchoolCalendarManager, PupilsFilter],
    );

    di.registerSingletonAsync<UserManager>(() async {
      _log.info('Registering UserManager');
      final userManager = UserManager();
      await userManager.init();
      _log.info('UserManager initialized');
      return userManager;
    }, dependsOn: [HubSessionManager]);

    di.registerSingleton<TimetableApiService>(TimetableApiService());

    di.registerSingletonAsync<TimetableManager>(() async {
      _log.info('Registering TimetableManager');
      final timetableManager = TimetableManager();
      await timetableManager.init();
      _log.info('TimetableManager initialized');
      return timetableManager;
    }, dependsOn: [HubSessionManager, TimetableApiService]);
  }
}
