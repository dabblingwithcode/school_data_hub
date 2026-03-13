import 'package:school_data_hub_server/src/generated/protocol.dart';

class PupilSchemas {
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
