import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

/// Inner sliver that watches [itemsListenable] and builds empty state or list.
/// Only this widget rebuilds when the list changes.
class _ListSliver<T> extends WatchingWidget {
  final ValueListenable<List<T>> itemsListenable;
  final Widget Function(BuildContext, T) itemBuilder;
  final String emptyMessage;

  const _ListSliver({
    required this.itemsListenable,
    required this.itemBuilder,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    final items = watch(itemsListenable).value;
    return items.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(emptyMessage, style: const TextStyle(fontSize: 18)),
              ),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return itemBuilder(context, items[index]);
              },
              childCount: items.length,
            ),
          );
  }
}

/// Generic sliver that shows either an empty-state message or a list.
/// Takes [itemsListenable]; only the inner [_ListSliver] watches it, so list
/// updates do not rebuild the parent page.
class GenericSliverListWithEmptyListCheck<T> extends StatelessWidget {
  final ValueListenable<List<T>> itemsListenable;
  final Widget Function(BuildContext, T) itemBuilder;
  final String emptyMessage;

  const GenericSliverListWithEmptyListCheck({
    super.key,
    required this.itemsListenable,
    required this.itemBuilder,
    this.emptyMessage = 'Keine Ergebnisse',
  });

  @override
  Widget build(BuildContext context) {
    return _ListSliver<T>(
      itemsListenable: itemsListenable,
      itemBuilder: itemBuilder,
      emptyMessage: emptyMessage,
    );
  }
}
