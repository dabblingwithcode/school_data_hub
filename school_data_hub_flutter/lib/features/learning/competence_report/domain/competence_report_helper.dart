import 'package:school_data_hub_client/school_data_hub_client.dart';

class CompetenceReportHelper {
  static List<CompetenceReportItem> sortItems(
    List<CompetenceReportItem> items,
  ) {
    final List<CompetenceReportItem> rootItems = [];
    final List<CompetenceReportItem> childItems = [];

    for (final item in items) {
      if (item.parentItem == null) {
        rootItems.add(item);
      } else {
        childItems.add(item);
      }
    }

    childItems.sort((a, b) {
      if (a.parentItem == b.parentItem) {
        if (a.order == null && b.order == null) return 0;
        if (a.order == null) return 1;
        if (b.order == null) return -1;
        return a.order!.compareTo(b.order!);
      }
      return (a.parentItem ?? 0).compareTo(b.parentItem ?? 0);
    });

    return [...rootItems, ...childItems];
  }

  static Map<int, int> generateRootItemsMap(
    List<CompetenceReportItem> items,
  ) {
    final Map<int, CompetenceReportItem> itemsMap = {
      for (final item in items) item.publicId: item,
    };
    final Map<int, int> cache = {};

    int findRoot(int publicId) {
      if (cache.containsKey(publicId)) {
        return cache[publicId]!;
      }
      final item = itemsMap[publicId]!;
      if (item.parentItem == null) {
        cache[publicId] = publicId;
        return publicId;
      }
      final rootId = findRoot(item.parentItem!);
      cache[publicId] = rootId;
      return rootId;
    }

    final Map<int, int> result = {};
    for (final item in items) {
      result[item.publicId] = findRoot(item.publicId);
    }
    return result;
  }
}
