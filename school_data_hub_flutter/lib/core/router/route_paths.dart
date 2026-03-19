/// Centralized route path constants.
///
/// Using constants avoids magic strings and enables IDE autocomplete.
/// Path parameters use `:param` syntax (go_router convention).
abstract final class RoutePaths {
  // --- Auth / Boot ---
  static const entryPoint = '/';
  static const login = '/login';
  static const loading = '/loading';
  static const noConnection = '/no-connection';

  // --- Shell tabs (bottom nav) ---
  static const home = '/home';
  static const schoolLists = '/school-lists';
  static const learning = '/learning';
  static const tools = '/tools';
  static const settings = '/settings';

  // --- Pupil ---
  static const pupilProfile = '/pupil/:internalId';
  static const pupilAttendance = '/pupil/attendance';
  static const pupilSchooldayEvents = '/pupil/schoolday-events';
  static const pupilMissedSchooldays = '/pupil/missed-schooldays';
  static const pupilCredit = '/pupil/credit';
  static const pupilSpecialInfo = '/pupil/special-info';
  static const pupilReligion = '/pupil/religion';
  static const pupilFamilyLanguage = '/pupil/family-language';
  static const pupilAfterSchoolCare = '/pupil/after-school-care';
  static const pupilLearningSupport = '/pupil/learning-support';
  static const pupilPublicMediaAuth = '/pupil/public-media-auth';
  static const pupilMatrixContacts = '/pupil/matrix-contacts';
  static const pupilSelect = '/pupil/select';
  static const pupilBirthdays = '/pupil/birthdays';
  static const pupilIdentityStream = '/pupil/identity-stream';

  // --- School ---
  static const schoolListsDetail = '/school/lists';
  static const schoolAuthorizations = '/school/authorizations';
  static const schoolEdit = '/school/edit';
  static const schoolCalendar = '/school/calendar';
  static const schoolSemesters = '/school/semesters';

  // --- Learning ---
  static const learningCompetences = '/learning/competences';
  static const learningCompetencesSortable = '/learning/competences/sortable';
  static const learningCompetenceReport = '/learning/competence-report';
  static const learningCompetenceReportSortable =
      '/learning/competence-report/sortable';
  static const learningPupilList = '/learning/pupil-list';
  static const learningSupportList = '/learning/support';
  static const learningSupportCategory = '/learning/support/category';
  static const learningSupportNewPlan = '/learning/support/new-plan';
  static const learningSupportNewStatus = '/learning/support/new-status';
  static const learningWorkbooks = '/learning/workbooks';
  static const learningBooks = '/learning/books';
  static const learningBooksList = '/learning/books/list';
  static const learningBooksNew = '/learning/books/new';
  static const learningBooksSearch = '/learning/books/search';
  static const learningBooksResults = '/learning/books/results';
  static const learningBooksTags = '/learning/books/tags';
  static const learningBooksSelectTags = '/learning/books/select-tags';

  // --- Tools ---
  static const toolsTimetable = '/tools/timetable';
  static const toolsTimetableNew = '/tools/timetable/new';
  static const toolsTimetableSlots = '/tools/timetable/slots';
  static const toolsTimetableSubjects = '/tools/timetable/subjects';
  static const toolsTimetableGroups = '/tools/timetable/groups';
  static const toolsTimetableLesson = '/tools/timetable/lesson';
  static const toolsTimetableLessonGroup = '/tools/timetable/lesson-group';
  static const toolsTimetableClassrooms = '/tools/timetable/classrooms';
  static const toolsStatistics = '/tools/statistics';
  static const toolsCharts = '/tools/charts';

  // --- Admin ---
  static const adminUsers = '/admin/users';
  static const adminUsersNew = '/admin/users/new';
  static const adminUsersResetPassword = '/admin/users/reset-password';
  static const adminMatrix = '/admin/matrix';
  static const adminMatrixUsers = '/admin/matrix/users';
  static const adminMatrixContacts = '/admin/matrix/contacts';
  static const adminMatrixSetEnv = '/admin/matrix/set-environment';

  // --- Settings ---
  static const settingsChangePassword = '/settings/change-password';
  static const settingsLogs = '/settings/logs';
  static const settingsShorebirdUpdate = '/settings/update';

  // --- Utility ---
  static const utilScanner = '/util/scanner';
  static const utilCropAvatar = '/util/crop-avatar';
  static const utilCropDocument = '/util/crop-document';
  static const utilPdfViewer = '/util/pdf-viewer';

  /// Builds the pupil profile path with the given [internalId].
  static String pupilProfilePath(int internalId) =>
      '/pupil/$internalId';
}
