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

  // --- Authorizations ---
  static const authorizationNew = '/authorizations/new';
  static const authorizationPupils = '/authorizations/pupils';

  // --- School Lists ---
  static const schoolListNew = '/school/lists/new';
  static const schoolListEntries = '/school/lists/entries';

  // --- Schoolday Events ---
  static const schooldayEventNew = '/schoolday-events/new';

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

  // --- Workbooks ---
  static const workbookNew = '/learning/workbooks/new';

  // --- Learning Competence ---
  static const learningCompetenceEdit = '/learning/competences/edit';
  static const learningCompetenceGoalNew = '/learning/competence-goal/new';
  static const learningCompetenceCheck = '/learning/competence-check';
  static const learningCompetenceSelect = '/learning/competences/select';

  // --- Learning Competence Report ---
  static const learningCompetenceReportNew = '/learning/competence-report/new';
  static const learningCompetenceReportPupil =
      '/learning/competence-report/pupil';
  static const learningCompetenceReportItemEdit =
      '/learning/competence-report/item-edit';

  // --- Learning Support (additional) ---
  static const learningSupportCategoryEdit = '/learning/support/category/edit';
  static const learningSupportCategorySortable =
      '/learning/support/category/sortable';
  static const learningSupportCategorySelect =
      '/learning/support/category/select';
  static const learningSupportCategorySelectParent =
      '/learning/support/category/select-parent';
  static const learningSupportCategoryBulkStatus =
      '/learning/support/category/bulk-status';
  static const learningSupportGoalNew = '/learning/support/goal/new';

  // --- Books (additional) ---
  static const learningBooksEdit = '/learning/books/edit';
  static const learningBooksInfo = '/learning/books/info';

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

  // --- Timetable (additional) ---
  static const toolsTimetableNewLesson = '/tools/timetable/new-lesson';
  static const toolsTimetableNewLessonGroup =
      '/tools/timetable/new-lesson-group';
  static const toolsTimetableNewClassroom = '/tools/timetable/new-classroom';
  static const toolsTimetableNewSubject = '/tools/timetable/new-subject';
  static const toolsTimetableNewSlot = '/tools/timetable/new-slot';

  // --- Admin ---
  static const adminUsers = '/admin/users';
  static const adminUsersNew = '/admin/users/new';
  static const adminUsersResetPassword = '/admin/users/reset-password';
  static const adminMatrix = '/admin/matrix';
  static const adminMatrixUsers = '/admin/matrix/users';
  static const adminMatrixContacts = '/admin/matrix/contacts';
  static const adminMatrixSetEnv = '/admin/matrix/set-environment';

  // --- Matrix (additional) ---
  static const adminMatrixNewUser = '/admin/matrix/users/new';
  static const adminMatrixRooms = '/admin/matrix/rooms';
  static const adminMatrixRoomEdit = '/admin/matrix/rooms/edit';
  static const adminMatrixRoomNew = '/admin/matrix/rooms/new';
  static const adminMatrixEventReports = '/admin/matrix/event-reports';
  static const adminMatrixSelectUsers = '/admin/matrix/select-users';

  // --- Admin (additional) ---
  static const adminUsersBatchImport = '/admin/users/batch-import';

  // --- Settings ---
  static const settingsChangePassword = '/settings/change-password';
  static const settingsLogs = '/settings/logs';
  static const settingsShorebirdUpdate = '/settings/update';

  // --- Settings (additional) ---
  static const settingsServerDiagram = '/settings/server-diagram';
  static const settingsServerLogs = '/settings/server-logs';
  static const settingsMatrixCorporalLogs = '/settings/matrix-corporal-logs';

  // --- Utility ---
  static const utilScanner = '/util/scanner';
  static const utilCropAvatar = '/util/crop-avatar';
  static const utilCropDocument = '/util/crop-document';
  static const utilPdfViewer = '/util/pdf-viewer';

  // --- User (additional) ---
  static const utilSelectUsers = '/util/select-users';

  // --- Utility (additional) ---
  static const utilSelectPupils = '/util/select-pupils';

  /// Builds the pupil profile path with the given [internalId].
  static String pupilProfilePath(int internalId) =>
      '/pupil/$internalId';
}
