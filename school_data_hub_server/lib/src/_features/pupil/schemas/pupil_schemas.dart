import 'package:school_data_hub_server/src/generated/protocol.dart';

class PupilSchemas {
  /// Minimal include for list views and startup — just enough for
  /// avatar display and support level badges.
  /// All scalar/embedded fields (publicMediaAuth, tutorInfo, etc.) come free.
  static PupilDataInclude listInclude = PupilData.include(
    avatar: HubDocument.include(),
    avatarAuth: HubDocument.include(),
    supportLevelHistory: SupportLevel.includeList(),
  );

  /// Include for hub stream events — covers frequently accessed relations
  /// without heavy nested data (competence checks, reports, documents).
  static PupilDataInclude streamInclude = PupilData.include(
    avatar: HubDocument.include(),
    avatarAuth: HubDocument.include(),
    publicMediaAuthDocument: HubDocument.include(),
    creditTransactions: CreditTransaction.includeList(),
    supportLevelHistory: SupportLevel.includeList(),
    supportCategoryStatuses: SupportCategoryStatus.includeList(),
    learningSupportPlans: LearningSupportPlan.includeList(
      include:
          LearningSupportPlan.include(schoolSemester: SchoolSemester.include()),
    ),
  );

  /// Strip heavy relations from a PupilData object for stream broadcasting.
  /// The client merge logic preserves existing cached relations.
  static PupilData slimForStream(PupilData pupil) {
    return pupil.copyWith(
      competenceChecks: null,
      competenceReports: null,
      competenceReportChecks: null,
      preSchoolMedical: null,
    );
  }

  // ── Domain-scoped includes (Phase 1: load sub-models alongside legacy fields) ──

  /// Communication domain: contact, communicationPupil, tutorInfo, specialInformation.
  /// These are embedded JSON columns on pupil_data — no relations needed.
  /// The sub-model is loaded via communicationData relation.
  static PupilCommunicationDataInclude communicationSubInclude =
      PupilCommunicationData.include();

  /// Preschool domain: kindergardenData, preSchoolMedical, kindergarden, preSchoolTest.
  static PupilPreschoolDataInclude preschoolSubInclude =
      PupilPreschoolData.include(
    preSchoolMedical: PreSchoolMedical.include(
      preschoolMedicalFiles: HubDocument.includeList(),
    ),
    kindergarden: Kindergarden.include(),
    preSchoolTest: PreSchoolTest.include(),
  );

  /// Media domain: avatar, avatarAuth, publicMediaAuth, publicMediaAuthDocument.
  static PupilMediaDataInclude mediaSubInclude = PupilMediaData.include(
    avatar: HubDocument.include(),
    avatarAuth: HubDocument.include(),
    publicMediaAuthDocument: HubDocument.include(),
  );

  /// Full include for detail views and single-pupil fetches.
  static PupilDataInclude allInclude = PupilData.include(
    avatar: HubDocument.include(),
    avatarAuth: HubDocument.include(),
    publicMediaAuthDocument: HubDocument.include(),
    creditTransactions: CreditTransaction.includeList(),
    supportLevelHistory: SupportLevel.includeList(),
    learningSupportPlans: LearningSupportPlan.includeList(
      include:
          LearningSupportPlan.include(schoolSemester: SchoolSemester.include()),
    ),
    preSchoolMedical: PreSchoolMedical.include(
      preschoolMedicalFiles: HubDocument.includeList(),
    ),
    supportCategoryStatuses: SupportCategoryStatus.includeList(),
    competenceChecks: CompetenceCheck.includeList(
      include: CompetenceCheck.include(
        documents: HubDocument.includeList(),
      ),
    ),
    competenceReports: CompetenceReport.includeList(
      include: CompetenceReport.include(
        competenceReportChecks: CompetenceReportCheck.includeList(),
      ),
    ),
  );
}

class LibraryBookSchemas {
  static LibraryBookInclude allInclude = LibraryBook.include(
    book: Book.include(
      tags: BookTagging.includeList(
        include: BookTagging.include(
          bookTag: BookTag.include(),
        ),
      ),
    ),
    location: LibraryBookLocation.include(),
  );
}

class PupilBookLendingSchemas {
  static PupilBookLendingInclude allInclude = PupilBookLending.include(
    pupilBookLendingFiles: HubDocument.includeList(),
    libraryBook: LibraryBookSchemas.allInclude,
  );
}
