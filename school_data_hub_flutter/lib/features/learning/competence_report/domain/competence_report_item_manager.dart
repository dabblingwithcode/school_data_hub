import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/core/client/hub_stream_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/data/competence_report_item_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_helper.dart';

class CompetenceReportItemManager {
  final _apiService = CompetenceReportItemApiService();
  final _notificationService = di<NotificationService>();

  final _items = ValueNotifier<List<CompetenceReportItem>>([]);
  ValueListenable<List<CompetenceReportItem>> get items => _items;

  StreamSubscription<dynamic>? _hubSubscription;

  CompetenceReportItemManager();

  Future<CompetenceReportItemManager> init() async {
    await fetchItems();
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _items.dispose();
  }

  void _onHubEvent(dynamic event) {
    if (event is CompetenceReportItem) {
      upsertItemFromStream(event);
    } else if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.competenceReportItem) {
      deleteItemFromStream(event.id);
    } else if (event is HubReconnected) {
      fetchItems();
    } else if (event is HubSelectiveReconnect) {
      if (event.changedTypes.contains(HubObjectType.competenceReportItem)) {
        fetchItems();
      }
    }
  }

  void upsertItemFromStream(CompetenceReportItem item) {
    final list = List<CompetenceReportItem>.from(_items.value);
    final index = list.indexWhere(
      (i) => (i.id != null && i.id == item.id) || i.publicId == item.publicId,
    );
    if (index >= 0) {
      list[index] = item;
    } else {
      list.add(item);
    }
    _items.value = CompetenceReportHelper.sortItems(list);
  }

  void deleteItemFromStream(int itemId) {
    final list = _items.value.where((i) => i.id != itemId).toList();
    _items.value = CompetenceReportHelper.sortItems(list);
  }

  Future<void> fetchItems() async {
    final fetched = await _apiService.fetchAllCompetenceReportItems();
    if (fetched != null) {
      _items.value = CompetenceReportHelper.sortItems(fetched);
    }
  }

  Future<void> postNewItem({
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
  }) async {
    final result = await _apiService.postCompetenceReportItem(
      parentItem: parentItem,
      name: name,
      level: level,
      order: order,
    );
    if (result != null) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugniskompetenz erstellt',
      );
    }
  }

  Future<void> updateItemOrder({
    required int publicId,
    required int order,
  }) async {
    final index = _items.value.indexWhere((i) => i.publicId == publicId);
    if (index == -1) return;

    final item = _items.value[index];
    final updatedItem = item.copyWith(order: order);
    await _apiService.updateCompetenceReportItem(updatedItem);
    // Hub stream will deliver the updated item; sortAndNotifyItems() on page
    // dispose commits order for other widgets.
  }

  /// Sorts the items list by order and notifies listeners.
  /// Call this after order updates are complete (e.g. when leaving the
  /// sortable page) so other pages see the correct order.
  void sortAndNotifyItems() {
    _items.value = CompetenceReportHelper.sortItems(
      List<CompetenceReportItem>.from(_items.value),
    );
  }

  Future<void> updateItem(CompetenceReportItem item) async {
    final result = await _apiService.updateCompetenceReportItem(item);
    if (result != null) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugniskompetenz aktualisiert',
      );
    }
  }

  Future<void> deleteItem(int publicId) async {
    final success = await _apiService.deleteCompetenceReportItem(publicId);
    if (success == true) {
      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugniskompetenz gelöscht',
      );
    } else if (success == false) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Fehler beim Löschen der Zeugniskompetenz',
      );
    }
  }

  CompetenceReportItem findItemById(int publicId) {
    return _items.value.firstWhere((i) => i.publicId == publicId);
  }

  bool isItemWithChildren(CompetenceReportItem item) {
    return _items.value.any((i) => i.parentItem == item.publicId);
  }
}
