class PopulatedServerSessionData {
  final bool schoolSemester;
  final bool schooldays;
  final bool competences;
  final bool supportCategories;

  PopulatedServerSessionData({
    required this.schoolSemester,
    required this.schooldays,
    required this.competences,
    required this.supportCategories,
  });

  copyWith({
    bool? schoolSemester,
    bool? schooldays,
    bool? competences,
    bool? supportCategories,
  }) =>
      PopulatedServerSessionData(
        schoolSemester: schoolSemester ?? this.schoolSemester,
        schooldays: schooldays ?? this.schooldays,
        competences: competences ?? this.competences,
        supportCategories: supportCategories ?? this.supportCategories,
      );
}
