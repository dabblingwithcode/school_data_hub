import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/data/file_upload_service.dart';
import 'package:school_data_hub_flutter/common/services/hub_stream_service.dart';
import 'package:school_data_hub_flutter/common/services/notification_service.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/data/learning_support_api_service.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';

class SupportCategoryManager {
  final _notificationService = di<NotificationService>();

  final _envManager = di<EnvManager>();

  final _log = Logger('LearningSupportManager');

  final _learningSupportApiService = LearningSupportApiService();

  final _supportCategories = ValueNotifier<List<SupportCategory>>([]);
  ValueListenable<List<SupportCategory>> get supportCategories =>
      _supportCategories;

  // to avoid complicated lookups later on, we create a map
  // with references for each category to its root category
  Map<int, int> _rootCategoriesMap = {};

  StreamSubscription<dynamic>? _hubSubscription;

  SupportCategoryManager();

  void dispose() {
    _hubSubscription?.cancel();
    _hubSubscription = null;
    _supportCategories.dispose();
  }

  Future<SupportCategoryManager> init() async {
    await fetchSupportCategories();
    _hubSubscription = di<HubStreamService>().events.listen(_onHubEvent);
    return this;
  }

  void _onHubEvent(dynamic event) {
    if (event is SupportCategory) {
      upsertFromStream(event);
    } else if (event is HubDeleteEvent &&
        event.objectType == HubObjectType.supportCategory) {
      deleteFromStream(event.id);
    } else if (event is HubReconnected) {
      fetchSupportCategories();
    }
  }

  /// Shared comparator: order (nulls last), then categoryId.
  static int _compareSupportCategories(SupportCategory a, SupportCategory b) {
    if (a.order != null && b.order != null) {
      return a.order!.compareTo(b.order!);
    }
    if (a.order != null) return -1;
    if (b.order != null) return 1;
    return a.categoryId.compareTo(b.categoryId);
  }

  /// Sets the category list after sorting. Keeps order as single source of truth.
  void _setSupportCategories(List<SupportCategory> list) {
    final sorted = List<SupportCategory>.from(list);
    sorted.sort(_compareSupportCategories);
    _supportCategories.value = sorted;
    _rootCategoriesMap = LearningSupportHelper.generateRootCategoryMap(sorted);
  }

  void upsertFromStream(SupportCategory category) {
    final list = List<SupportCategory>.from(_supportCategories.value);
    final index = list.indexWhere((c) => c.categoryId == category.categoryId);
    if (index >= 0) {
      list[index] = category;
    } else {
      list.add(category);
    }
    _setSupportCategories(list);
  }

  void deleteFromStream(int categoryId) {
    final list = _supportCategories.value
        .where((c) => c.categoryId != categoryId)
        .toList();
    _setSupportCategories(list);
  }

  // - Getters

  SupportCategory getSupportCategory(int categoryId) {
    final SupportCategory goalCategory = supportCategories.value.firstWhere(
      (element) => element.categoryId == categoryId,
    );
    return goalCategory;
  }

  SupportCategory getRootSupportCategory(int categoryId) {
    final rootCategoryId = _rootCategoriesMap[categoryId];
    return getSupportCategory(rootCategoryId!);
  }

  int getRootSupportCategoryId(int categoryId) {
    return _rootCategoriesMap[categoryId]!;
  }

  Color getCategoryColor(int categoryId) {
    final rootCategory = getRootSupportCategory(categoryId);
    return LearningSupportHelper.getRootSupportCategoryColor(rootCategory);
  }

  List<SupportGoal> getGoalsForSupportCategory(int categoryId) {
    List<SupportGoal> goals = [];

    final List<PupilProxy> pupils = di<PupilProxyManager>().allPupils;
    for (PupilProxy pupil in pupils) {
      for (SupportGoal goal in pupil.supportGoals!) {
        if (goal.supportCategoryId == categoryId) {
          goals.add(goal);
        }
      }
    }
    return goals;
  }

  void clearData() {
    _supportCategories.value = [];
  }

  // - Repository calls

  Future<void> fetchSupportCategories() async {
    final List<SupportCategory>? supportCategories =
        await _learningSupportApiService.fetchSupportCategories();
    if (supportCategories == null) {
      return;
    }
    if (supportCategories.isNotEmpty) {
      _setSupportCategories(supportCategories);
      _envManager.setPopulatedEnvServerData(supportCategories: true);

      _notificationService.showSnackBar(
        NotificationType.success,
        '${supportCategories.length} Förderkategorien aktualisiert!',
      );
    }
    _log.info('Fetched ${supportCategories.length} support categories');
    return;
  }

  Future<void> importSupportCategoriesFromFile() async {
    final fileResponse = await ClientFileUpload.uploadFile(
      storageId: StorageId.private,
      folder: ServerStorageFolder.temp,
    );

    if (fileResponse.success == false || fileResponse.path == null) {
      if (!fileResponse.cancelled) {
        _notificationService.showSnackBar(
          NotificationType.error,
          'Die Datei konnte nicht hochgeladen werden!',
        );
      }
      return;
    }
    final List<SupportCategory> importedCategories =
        await _learningSupportApiService.importSupportCategoriesFromJsonFile(
          fileResponse.path!,
        );

    _setSupportCategories(importedCategories);
    _envManager.setPopulatedEnvServerData(supportCategories: true);

    _notificationService.showSnackBar(
      NotificationType.success,
      'Förderkategorien importiert',
    );
  }

  Future<bool> createSupportCategory({
    required String name,
    int? parentCategory,
  }) async {
    // Generate next categoryId as max(existing) + 1
    final maxId = _supportCategories.value.fold<int>(
      0,
      (max, c) => c.categoryId > max ? c.categoryId : max,
    );
    final newCategoryId = maxId + 1;

    // Compute order: count of siblings with the same parent (appends at end)
    final siblingCount = _supportCategories.value
        .where((c) => c.parentCategory == parentCategory)
        .length;

    final newCategory = SupportCategory(
      name: name,
      categoryId: newCategoryId,
      parentCategory: parentCategory,
      order: siblingCount,
      printable: false,
    );

    final success = await _learningSupportApiService.createSupportCategory(
      newCategory,
    );

    // if (success) {
    //   final categories = List<SupportCategory>.from(_supportCategories.value)
    //     ..add(newCategory);
    //   _setSupportCategories(categories);

    //   _notificationService.showSnackBar(
    //     NotificationType.success,
    //     'Kategorie "$name" erstellt',
    //   );
    // }

    return success;
  }

  Future<void> updateSupportCategoryOrder({
    required int categoryId,
    required int order,
  }) async {
    final index = _supportCategories.value.indexWhere(
      (c) => c.categoryId == categoryId,
    );
    if (index == -1) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kategorie nicht gefunden',
      );
      return;
    }

    final category = _supportCategories.value[index];
    final updatedCategory = category.copyWith(order: order);

    final success = await _learningSupportApiService.updateSupportCategory(
      updatedCategory,
    );

    if (success) {
      _log.info(
        'Support category order updated: ${updatedCategory.name} is now at position ${updatedCategory.order}',
      );
      // Update the item in-place without notifying listeners.
      // The sortable widgets manage their own visual order via local state.
      // Call sortAndNotifyCategories() when done (e.g. on page dispose)
      // to commit the sorted order for other widgets.

      //- The hub stream service will handle the update
      //_supportCategories.value[index] = updatedCategory;
    }
  }

  /// Sorts the categories list by order and notifies listeners.
  /// Call this after order updates are complete (e.g. when leaving the
  /// sortable page) so other pages see the correct order.
  void sortAndNotifyCategories() {
    _setSupportCategories(_supportCategories.value);
  }

  Future<void> updateSupportCategoryName({
    required int categoryId,
    required String name,
  }) async {
    final index = _supportCategories.value.indexWhere(
      (c) => c.categoryId == categoryId,
    );
    if (index == -1) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kategorie nicht gefunden',
      );
      return;
    }

    final category = _supportCategories.value[index];
    final updatedCategory = category.copyWith(name: name);

    final success = await _learningSupportApiService.updateSupportCategory(
      updatedCategory,
    );

    if (success) {
      final categories = List<SupportCategory>.from(_supportCategories.value);
      categories[index] = updatedCategory;
      _setSupportCategories(categories);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Kategorie aktualisiert',
      );
    }
  }

  Future<void> updateSupportCategoryParent({
    required int categoryId,
    required int? parentCategory,
  }) async {
    final index = _supportCategories.value.indexWhere(
      (c) => c.categoryId == categoryId,
    );
    if (index == -1) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kategorie nicht gefunden',
      );
      return;
    }

    final category = _supportCategories.value[index];
    final updatedCategory = category.copyWith(parentCategory: parentCategory);

    final success = await _learningSupportApiService.updateSupportCategory(
      updatedCategory,
    );

    if (success) {
      final categories = List<SupportCategory>.from(_supportCategories.value);
      categories[index] = updatedCategory;
      _setSupportCategories(categories);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Kategorie verschoben',
      );
    }
  }

  /// Returns the set of category IDs that are descendants of [categoryId]
  /// (including [categoryId] itself). Used to prevent circular references
  /// when reparenting.
  Set<int> getDescendantCategoryIds(int categoryId) {
    final descendants = <int>{categoryId};
    bool added = true;
    while (added) {
      added = false;
      for (final cat in _supportCategories.value) {
        if (cat.parentCategory != null &&
            descendants.contains(cat.parentCategory) &&
            !descendants.contains(cat.categoryId)) {
          descendants.add(cat.categoryId);
          added = true;
        }
      }
    }
    return descendants;
  }

  /// True if [categoryId] has at least one direct child category.
  bool hasChildren(int categoryId) {
    return _supportCategories.value.any((c) => c.parentCategory == categoryId);
  }

  Future<void> deleteSupportCategory(SupportCategory category) async {
    final success = await _learningSupportApiService.deleteSupportCategory(
      category,
    );
    if (success) {
      final list = _supportCategories.value
          .where((c) => c.categoryId != category.categoryId)
          .toList();
      _setSupportCategories(list);

      _notificationService.showSnackBar(
        NotificationType.success,
        'Kategorie gelöscht',
      );
    }
  }

  Future<void> updateSupportCategoryPrintable({
    required int categoryId,
    required bool printable,
  }) async {
    final index = _supportCategories.value.indexWhere(
      (c) => c.categoryId == categoryId,
    );
    if (index == -1) {
      _notificationService.showSnackBar(
        NotificationType.error,
        'Kategorie nicht gefunden',
      );
      return;
    }

    final category = _supportCategories.value[index];
    final updatedCategory = category.copyWith(printable: printable);

    final success = await _learningSupportApiService.updateSupportCategory(
      updatedCategory,
    );

    if (success) {
      final categories = List<SupportCategory>.from(_supportCategories.value);
      categories[index] = updatedCategory;
      _setSupportCategories(categories);
    }
  }
}
