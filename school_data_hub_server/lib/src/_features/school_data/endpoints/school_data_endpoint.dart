import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SchoolDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<SchoolData?> getSchoolData(Session session) async {
    var schoolData = await SchoolData.db.findFirstRow(
      session,
      include: SchoolData.include(
        logo: HubDocument.include(),
        officialSeal: HubDocument.include(),
      ),
    );
    return schoolData;
  }
}
