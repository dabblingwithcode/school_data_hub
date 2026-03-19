enum SchoolListFilter { publicLists, myLists, otherLists }

Map<SchoolListFilter, bool> initialSchoolListFilterValues = {
  SchoolListFilter.publicLists: false,
  SchoolListFilter.myLists: false,
  SchoolListFilter.otherLists: false,
};

enum SchoolListEntryFilter {
  yesResponse,
  noResponse,
  nullResponse,
  commentResponse,
}

typedef SchoolListEntryFilterRecord = ({
  SchoolListEntryFilter filter,
  bool value,
});

Map<SchoolListEntryFilter, bool> initialSchoolListEntryFilterValues = {
  SchoolListEntryFilter.yesResponse: false,
  SchoolListEntryFilter.noResponse: false,
  SchoolListEntryFilter.nullResponse: false,
  SchoolListEntryFilter.commentResponse: false,
};
