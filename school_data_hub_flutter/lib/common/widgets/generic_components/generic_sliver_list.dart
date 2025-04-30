import 'package:flutter/material.dart';

class GenericSliverListWithEmptyListCheck<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;

  const GenericSliverListWithEmptyListCheck({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Keine Ergebnisse',
                  style: TextStyle(fontSize: 18),
                ),
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
