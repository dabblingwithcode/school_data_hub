import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/utils/hierarchical_sort.dart';

class CompetenceReportHelper {
  static List<CompetenceReportItem> sortItems(
    List<CompetenceReportItem> items,
  ) {
    return HierarchicalSort.sort(
      items: items,
      getParent: (i) => i.parentItem,
      getOrder: (i) => i.order,
    );
  }

  static Map<int, int> generateRootItemsMap(
    List<CompetenceReportItem> items,
  ) {
    return HierarchicalSort.generateRootMap(
      items: items,
      getPublicId: (i) => i.publicId,
      getParent: (i) => i.parentItem,
    );
  }
}
