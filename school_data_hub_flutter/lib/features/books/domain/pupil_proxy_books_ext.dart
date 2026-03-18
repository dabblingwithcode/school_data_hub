import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';

extension PupilProxyBooks on PupilProxy {
  List<PupilBookLending> get pupilBookLendings =>
      di<PupilBookLendingManager>().getPupilBookLendings(pupilId);
}
