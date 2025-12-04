import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SchoolDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// TODO: we should be specific about which school data to get
  Future<SchoolData?> getSchoolData(Session session) async {
    var schoolData = await SchoolData.db.findFirstRow(session);
    return schoolData;
  }

  // TODO: rest of the endpoint methods
  // Endpoint implementation
}
