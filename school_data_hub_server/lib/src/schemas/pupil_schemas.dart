import 'package:school_data_hub_server/src/generated/protocol.dart';

class PupilSchemas {
  static PupilDataInclude allInclude = PupilData.include(
    avatar: HubDocument.include(),
    avatarAuth: HubDocument.include(),
    publicMediaAuthDocument: HubDocument.include(),
    creditTransactions: CreditTransaction.includeList(),
    supportLevelHistory: SupportLevel.includeList(),
    preSchoolMedical: PreSchoolMedical.include(
      preschoolMedicalFiles: HubDocument.includeList(),
    ),
    supportCategoryStatuses: SupportCategoryStatus.includeList(),
    supportGoals: SupportGoal.includeList(),
    competenceChecks: CompetenceCheck.includeList(
      include: CompetenceCheck.include(
        documents: HubDocument.includeList(),
      ),
    ),
    pupilBookLendings: PupilBookLending.includeList(
        include: PupilBookLending.include(
      pupilBookLendingFiles: HubDocument.includeList(),
    )),
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
