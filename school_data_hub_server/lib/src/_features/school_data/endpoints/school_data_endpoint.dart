import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SchoolDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<SchoolData> postSchoolData(
      Session session, SchoolData schoolData) async {
    final schooldataInDb = await session.db.insertRow(schoolData);
    return schooldataInDb;
  }

  /// TODO: we should be specific about which school data to get
  Future<SchoolData?> getSchoolData(Session session) async {
    var schoolData = await SchoolData.db.findFirstRow(session);
    return schoolData;
  }

  // TODO: rest of the endpoint methods
  // Endpoint implementation
}
