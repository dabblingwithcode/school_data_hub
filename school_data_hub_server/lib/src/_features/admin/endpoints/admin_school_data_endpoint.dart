import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AdminSchoolDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;
  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};
  Future<SchoolData> postSchoolData(
      Session session, SchoolData schoolData) async {
    final schooldataInDb = await session.db.insertRow(schoolData);
    return schooldataInDb;
  }
}
