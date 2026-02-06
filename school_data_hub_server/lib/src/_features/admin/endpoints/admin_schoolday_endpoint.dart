import 'package:serverpod/serverpod.dart';

class AdminSchoolDayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;
  @override
  Set<Scope> get requiredScopes => {Scope('serverpod.admin')};
}
