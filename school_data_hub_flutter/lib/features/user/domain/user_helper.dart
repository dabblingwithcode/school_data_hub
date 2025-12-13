import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';
import 'package:watch_it/watch_it.dart';

final _log = Logger('UserHelper');

class UserHelper {
  static User? getUserByUserName(String userName) {
    final users = di<UserManager>().users.value;

    try {
      return users.firstWhere((user) => user.id == userName);
    } catch (e) {
      _log.warning('User with userName $userName not found: $e');
      return null;
    }
  }
}
