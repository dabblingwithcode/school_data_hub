import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/empty_state.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

/// Inner sliver that watches [itemsListenable] and builds empty state or list.
/// Only this widget rebuilds when the list changes.
class _ListSliver<T> extends WatchingWidget {
  final ValueListenable<List<T>> itemsListenable;
  final Widget Function(BuildContext, T) itemBuilder;
  final String emptyMessage;
  final double spacing;

  const _ListSliver({
    required this.itemsListenable,
    required this.itemBuilder,
    required this.emptyMessage,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final items = watch(itemsListenable).value;
    if (items.isEmpty) {
      return SliverToBoxAdapter(child: EmptyState(title: emptyMessage));
    }
    return SliverList.separated(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (context, index) => Gap(spacing),
    );
  }
}

/// Generic sliver that shows either an empty-state message or a list.
/// Takes [itemsListenable]; only the inner [_ListSliver] watches it, so list
/// updates do not rebuild the parent page.
///
/// Items are separated by [spacing] (defaults to [Style.spacing.sm] = 8px).
class ContentSliverList<T> extends StatelessWidget {
  final ValueListenable<List<T>> itemsListenable;
  final Widget Function(BuildContext, T) itemBuilder;
  final String emptyMessage;
  final double? spacing;

  const ContentSliverList({
    super.key,
    required this.itemsListenable,
    required this.itemBuilder,
    this.emptyMessage = 'Keine Ergebnisse',
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return _ListSliver<T>(
      itemsListenable: itemsListenable,
      itemBuilder: itemBuilder,
      emptyMessage: emptyMessage,
      spacing: spacing ?? Style.spacing.listCardSpacing,
    );
  }
}
