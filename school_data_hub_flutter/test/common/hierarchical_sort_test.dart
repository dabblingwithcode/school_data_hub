import 'package:flutter_test/flutter_test.dart';
import 'package:school_data_hub_flutter/common/utils/hierarchical_sort.dart';

/// Simple test item with parent/child hierarchy.
class _Item {
  final int id;
  final int? parentId;
  final int? order;
  _Item(this.id, {this.parentId, this.order});
}

void main() {
  group('HierarchicalSort.sort', () {
    test('roots come first, then children', () {
      final items = [
        _Item(3, parentId: 1, order: 1),
        _Item(1),
        _Item(2, parentId: 1, order: 2),
      ];
      final sorted = HierarchicalSort.sort(
        items: items,
        getParent: (i) => i.parentId,
        getOrder: (i) => i.order,
      );
      expect(sorted.map((i) => i.id).toList(), [1, 3, 2]);
    });

    test('children sorted by parent then order', () {
      final items = [
        _Item(4, parentId: 2, order: 1),
        _Item(3, parentId: 1, order: 2),
        _Item(5, parentId: 2, order: 2),
        _Item(2, parentId: 1, order: 1),
      ];
      final sorted = HierarchicalSort.sort(
        items: items,
        getParent: (i) => i.parentId,
        getOrder: (i) => i.order,
      );
      // parent 1 children (order 1, 2), then parent 2 children (order 1, 2)
      expect(sorted.map((i) => i.id).toList(), [2, 3, 4, 5]);
    });

    test('null order sorts after non-null', () {
      final items = [
        _Item(3, parentId: 1),
        _Item(2, parentId: 1, order: 1),
      ];
      final sorted = HierarchicalSort.sort(
        items: items,
        getParent: (i) => i.parentId,
        getOrder: (i) => i.order,
      );
      expect(sorted.map((i) => i.id).toList(), [2, 3]);
    });

    test('empty list returns empty', () {
      final sorted = HierarchicalSort.sort<_Item>(
        items: [],
        getParent: (i) => i.parentId,
        getOrder: (i) => i.order,
      );
      expect(sorted, isEmpty);
    });

    test('all roots preserves order', () {
      final items = [_Item(3), _Item(1), _Item(2)];
      final sorted = HierarchicalSort.sort(
        items: items,
        getParent: (i) => i.parentId,
        getOrder: (i) => i.order,
      );
      expect(sorted.map((i) => i.id).toList(), [3, 1, 2]);
    });
  });

  group('HierarchicalSort.generateRootMap', () {
    test('root items map to themselves', () {
      final items = [_Item(1), _Item(2)];
      final map = HierarchicalSort.generateRootMap(
        items: items,
        getPublicId: (i) => i.id,
        getParent: (i) => i.parentId,
      );
      expect(map, {1: 1, 2: 2});
    });

    test('children map to their root ancestor', () {
      final items = [
        _Item(1),
        _Item(2, parentId: 1),
        _Item(3, parentId: 2),
      ];
      final map = HierarchicalSort.generateRootMap(
        items: items,
        getPublicId: (i) => i.id,
        getParent: (i) => i.parentId,
      );
      expect(map, {1: 1, 2: 1, 3: 1});
    });

    test('orphans (parent not in list) map to themselves', () {
      final items = [
        _Item(5, parentId: 99),
      ];
      final map = HierarchicalSort.generateRootMap(
        items: items,
        getPublicId: (i) => i.id,
        getParent: (i) => i.parentId,
      );
      expect(map, {5: 5});
    });

    test('multiple trees', () {
      final items = [
        _Item(1),
        _Item(2, parentId: 1),
        _Item(10),
        _Item(11, parentId: 10),
      ];
      final map = HierarchicalSort.generateRootMap(
        items: items,
        getPublicId: (i) => i.id,
        getParent: (i) => i.parentId,
      );
      expect(map, {1: 1, 2: 1, 10: 10, 11: 10});
    });

    test('deep chain resolves correctly', () {
      final items = [
        _Item(1),
        _Item(2, parentId: 1),
        _Item(3, parentId: 2),
        _Item(4, parentId: 3),
      ];
      final map = HierarchicalSort.generateRootMap(
        items: items,
        getPublicId: (i) => i.id,
        getParent: (i) => i.parentId,
      );
      expect(map, {1: 1, 2: 1, 3: 1, 4: 1});
    });

    test('empty list returns empty map', () {
      final map = HierarchicalSort.generateRootMap<_Item>(
        items: [],
        getPublicId: (i) => i.id,
        getParent: (i) => i.parentId,
      );
      expect(map, isEmpty);
    });
  });
}
