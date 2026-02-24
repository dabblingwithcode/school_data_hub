import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/data/competence_report_item_api_service.dart';
import 'package:school_data_hub_flutter/features/learning/competence_report/domain/competence_report_helper.dart';

class CompetenceReportItemManager {
  final _apiService = CompetenceReportItemApiService();
  final _notificationService = di<NotificationService>();

  final _items = ValueNotifier<List<CompetenceReportItem>>([]);
  ValueListenable<List<CompetenceReportItem>> get items => _items;

  CompetenceReportItemManager();

  Future<CompetenceReportItemManager> init() async {
    await fetchItems();
    return this;
  }

  void dispose() {
    _items.dispose();
  }

  Future<void> fetchItems() async {
    final fetched = await _apiService.fetchAllCompetenceReportItems();
    _items.value = CompetenceReportHelper.sortItems(fetched);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugniskompetenzen aktualisiert!',
    );
  }

  Future<void> postNewItem({
    int? parentItem,
    required String name,
    List<String>? level,
    int? order,
  }) async {
    final newItem = await _apiService.postCompetenceReportItem(
      parentItem: parentItem,
      name: name,
      level: level,
      order: order,
    );

    _items.value = CompetenceReportHelper.sortItems([
      ..._items.value,
      newItem,
    ]);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugniskompetenz erstellt',
    );
  }

  Future<void> updateItemOrder({
    required int publicId,
    required int order,
  }) async {
    final index = _items.value.indexWhere((i) => i.publicId == publicId);
    if (index == -1) return;

    final item = _items.value[index];
    final updatedItem = item.copyWith(order: order);
    final verified = await _apiService.updateCompetenceReportItem(updatedItem);
    // Update in-place without notifying listeners.
    // The sortable widgets manage their own visual order via local state.
    // Call sortAndNotifyItems() when done (e.g. on page dispose)
    // to commit the sorted order for other widgets.
    _items.value[index] = verified;
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
    final updated = await _apiService.updateCompetenceReportItem(item);

    final list = List<CompetenceReportItem>.from(_items.value);
    final index = list.indexWhere((i) => i.publicId == updated.publicId);
    if (index != -1) {
      list[index] = updated;
    }
    _items.value = list;

    _notificationService.showSnackBar(
      NotificationType.success,
      'Zeugniskompetenz aktualisiert',
    );
  }

  Future<void> deleteItem(int publicId) async {
    final success = await _apiService.deleteCompetenceReportItem(publicId);
    if (success) {
      final list = List<CompetenceReportItem>.from(_items.value);
      list.removeWhere((i) => i.publicId == publicId);
      _items.value = list;

      _notificationService.showSnackBar(
        NotificationType.success,
        'Zeugniskompetenz gelöscht',
      );
    } else {
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
