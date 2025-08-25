import 'package:school_data_hub_server/src/helpers/create_first_admin.dart';
import 'package:serverpod/serverpod.dart';

class DevOpsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<void> resetDbAndCreateAdmin(Session session) async {
    // Get all table names from the database
    final result = await session.db.unsafeQuery(
      'SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = \'public\';',
    );

    // Truncate each table
    for (var row in result) {
      var tableName = row[0] as String;
      await session.db
          .unsafeQuery('TRUNCATE TABLE "$tableName" RESTART IDENTITY CASCADE;');
    }

    // Create a default admin user
    await createFirstAdmin(session);
  }
}
