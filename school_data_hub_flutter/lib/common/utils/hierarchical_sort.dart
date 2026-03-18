/// Generic utilities for sorting and root-mapping hierarchical (tree-structured)
/// items that have a publicId, an optional parentId, and an optional order.
class HierarchicalSort {
  HierarchicalSort._();

  /// Sorts items so that roots come first, followed by children ordered by
  /// parentId then by order within the same parent.
  static List<T> sort<T>({
    required List<T> items,
    required int? Function(T) getParent,
    required int? Function(T) getOrder,
  }) {
    final roots = <T>[];
    final children = <T>[];

    for (final item in items) {
      if (getParent(item) == null) {
        roots.add(item);
      } else {
        children.add(item);
      }
    }

    children.sort((a, b) {
      final parentA = getParent(a);
      final parentB = getParent(b);
      if (parentA == parentB) {
        final orderA = getOrder(a);
        final orderB = getOrder(b);
        if (orderA == null && orderB == null) return 0;
        if (orderA == null) return 1;
        if (orderB == null) return -1;
        return orderA.compareTo(orderB);
      }
      return (parentA ?? 0).compareTo(parentB ?? 0);
    });

    return [...roots, ...children];
  }

  /// Builds a map from each item's publicId to the publicId of its root
  /// ancestor. Orphans (parent not found) are treated as their own root.
  static Map<int, int> generateRootMap<T>({
    required List<T> items,
    required int Function(T) getPublicId,
    required int? Function(T) getParent,
  }) {
    final itemsById = <int, T>{
      for (final item in items) getPublicId(item): item,
    };
    final cache = <int, int>{};

    int findRoot(int publicId) {
      if (cache.containsKey(publicId)) return cache[publicId]!;

      final item = itemsById[publicId];
      if (item == null) {
        cache[publicId] = publicId;
        return publicId;
      }

      final parentId = getParent(item);
      if (parentId == null || !itemsById.containsKey(parentId)) {
        cache[publicId] = publicId;
        return publicId;
      }

      final rootId = findRoot(parentId);
      cache[publicId] = rootId;
      return rootId;
    }

    return {
      for (final item in items)
        getPublicId(item): findRoot(getPublicId(item)),
    };
  }
}
