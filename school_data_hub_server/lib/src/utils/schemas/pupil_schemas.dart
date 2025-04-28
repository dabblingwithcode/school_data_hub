import 'package:school_data_hub_server/src/generated/protocol.dart';

class PupilSchemas {
  static PupilDataInclude allInclude = PupilData.include(
    avatar: HubDocument.include(),
    avatarAuth: HubDocument.include(),
    creditTransactions: CreditTransaction.includeList(),
    supportLevelHistory: SupportLevel.includeList(),
  );
}
