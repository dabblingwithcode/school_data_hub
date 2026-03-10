# *ListPage files not yet using GenericListPage

Pages that **do** use GenericListPage (single import, composition):  
CreditListPage, AfterSchoolListPage, LearningSupportListPage, ReligionListPage, SpecialInfoListPage, FamilyLanguageLessonsListPage, ClassroomListPage, LearningGroupListPage, SubjectListPage, MissedSchooldaysPupilListPage, SchooldayEventListPage., MatrixRoomsListPage, MatrixUsersListPage

---

## Remaining *ListPage files and why not migrated

| File | Reason |
|------|--------|
| **attendance_list_page.dart** | Date picker / custom app bar (date range); plan is to add GenericDateAppBar or `titleWidget` variant before using GenericListPage. |
| **authorization_pupils_page.dart** | Custom scaffold and empty state; already uses GenericSliverListWithEmptyListCheck. Needs refactor to pass filterSheetChildren and use GenericListPage. |
| **book_list_page.dart** | Likely different layout or navigation; needs inspection. |
| **competence_list_page.dart** | Competence-specific UI (sortable or different list pattern); needs inspection. |
| **competence_report_item_list_page.dart** | Report-item list with its own navigation/actions; needs inspection. |
likely custom search/actions. |
| **pupil_list_learning_page.dart** | Learning goals PDF and custom bottom bar / filters; more complex flow. |
| **pupils_matrix_contacts_list_page.dart** | **No RefreshIndicator**, **complex list item** (inline card with many children). GenericListPage requires `onRefresh`; could pass no-op. Item builder is heavy. |
| **school_list_pupil_entries_page.dart** | School-list-specific (entries for one list); already uses GenericSliverListWithEmptyListCheck. |
| **school_semester_list_page.dart** | Semester list; may use different data source or actions. |
| **select_matrix_rooms_list_page.dart** | **Selection mode** (pick rooms); different UX and possibly controller-driven. |
| **select_matrix_users_list_page.dart** | **Selection mode** (pick users); same as above. |
| **select_pupils_list_page.dart** | **Selection mode** (SelectPupilsListPage), **WatchingStatefulWidget** with selectable list and different bottom bar. |
| **timetable_slot_list_page.dart** | Timetable slots; may have different structure. |
| **user_list_page.dart** | **StatefulWidget** (not WatchingWidget), custom filter/open logic. |
| **workbook_list_page.dart** | ViewModel-driven; needs inspection. |

Summary: **Selection-mode** and **StatefulWidget** pages need a separate pattern or escape hatch. Remaining list pages vary (date picker, custom scaffold, competence/sortable UI, Matrix, workbooks); each needs inspection for migration.
