import 'package:flutter/foundation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

class SupportCategoryStatusProxy with ChangeNotifier {
  SupportCategoryStatus supportCategoryStatus;
  late List<HubDocument> documents;
  SupportCategoryStatusProxy({required this.supportCategoryStatus}) {
    documents = supportCategoryStatus.documents ?? [];
  }

  int get status => supportCategoryStatus.status;
  String get comment => supportCategoryStatus.comment;
  String get createdBy => supportCategoryStatus.createdBy;
  DateTime get createdAt => supportCategoryStatus.createdAt;
  int get pupilId => supportCategoryStatus.pupilId;
  int get supportCategoryId => supportCategoryStatus.supportCategoryId;
}
