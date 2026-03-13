import 'package:school_data_hub_server/src/_features/hub/services/hub_updates_tracker.dart';
import 'package:school_data_hub_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CompetenceReportItemEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<CompetenceReportItem> postCompetenceReportItem(
    Session session, {
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
  }) async {
    final allItems = await CompetenceReportItem.db.find(session);
    final maxId = allItems.isNotEmpty
        ? allItems.map((i) => i.publicId).reduce((a, b) => a > b ? a : b)
        : 0;

    final item = CompetenceReportItem(
      publicId: maxId + 1,
      parentItem: parentItem,
      name: name,
      level: level,
      order: order,
    );

    final inserted = await CompetenceReportItem.db.insertRow(session, item);
    session.messages.postMessage('hub_events_stream', inserted);
    HubUpdatesTracker.instance.touch(HubObjectType.competenceReportItem);
    return inserted;
  }

  Future<List<CompetenceReportItem>> fetchAllCompetenceReportItems(
    Session session,
  ) async {
    return await CompetenceReportItem.db.find(session);
  }

  Future<CompetenceReportItem> updateCompetenceReportItem(
    Session session,
    CompetenceReportItem competenceReportItem,
  ) async {
    final updated = await CompetenceReportItem.db.updateRow(
      session,
      competenceReportItem,
    );
    session.messages.postMessage('hub_events_stream', updated);
    HubUpdatesTracker.instance.touch(HubObjectType.competenceReportItem);
    return updated;
  }

  Future<bool> deleteCompetenceReportItem(
    Session session,
    int publicId,
  ) async {
    final item = await CompetenceReportItem.db.findFirstRow(
      session,
      where: (t) => t.publicId.equals(publicId),
    );
    if (item == null) {
      throw Exception(
        'CompetenceReportItem with publicId $publicId not found.',
      );
    }

    final itemId = item.id!;
    await CompetenceReportItem.db.deleteRow(session, item);
    session.messages.postMessage(
      'hub_events_stream',
      HubDeleteEvent(
        objectType: HubObjectType.competenceReportItem,
        id: itemId,
      ),
    );
    return true;
  }
}
