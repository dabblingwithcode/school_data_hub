import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/domain/search_text_source.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_list_search_bar_with_stats.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_generic_bottom_sheet.dart';

/// Configuration for the search bar built by [GenericListPage].
/// [showFilterBottomSheet] is optional when [GenericListPage.filterSheetChildren] is set.
class GenericListSearchBarConfig {
  final Widget? statsWidget;
  final List<Widget>? middleWidgets;
  final SearchType searchType;
  final String hintText;
  final VoidCallback refreshFunction;
  final ValueChanged<String> onChanged;
  final SearchTextSource? searchTextSource;
  final ValueListenable<bool> filtersActive;
  final VoidCallback onResetFilters;
  final void Function(BuildContext context)? showFilterBottomSheet;

  const GenericListSearchBarConfig({
    this.statsWidget,
    this.middleWidgets,
    required this.searchType,
    required this.hintText,
    required this.refreshFunction,
    required this.onChanged,
    this.searchTextSource,
    required this.filtersActive,
    required this.onResetFilters,
    this.showFilterBottomSheet,
  });
}

/// Generic list page: Scaffold with appBar, optional search sliver, list sliver
/// (only the list watches [itemsListenable]), refresh, and optional bottom nav.
/// List pages import only this file; GenericAppBar, GenericFilterBottomSheet,
/// GenericListSearchBarWithStats, and showGenericBottomSheet are used exclusively here.
/// Use [iconData] + [title] for the app bar, or [appBar] for a custom one.
/// Use [filterSheetChildren] for the filter sheet (composition); no callback needed in the list page.
class GenericListPage<T> extends StatelessWidget {
  /// When set, used as the app bar. Otherwise [iconData] and [title] are used to build [GenericAppBar].
  final PreferredSizeWidget? appBar;
  final IconData? iconData;
  final String? title;
  final double sliverAppBarHeight;
  final Widget? searchWidgetWithStatsRow;
  final GenericListSearchBarConfig? searchBarConfig;
  /// When set, the filter sheet is shown with these children; [GenericListPage] builds the sheet internally.
  /// When non-null, a filter [IconButton] is added to the bottom bar (before [bottomBarActions]).
  final List<Widget>? filterSheetChildren;
  final ValueListenable<List<T>> itemsListenable;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<void> Function() onRefresh;
  final String emptyMessage;
  final Widget? bottomNavigationBar;
  final List<Widget>? bottomBarActions;
  final double? maxWidth;
  final List<Widget>? leadingSlivers;
  final Color? backgroundColor;

  const GenericListPage({
    super.key,
    this.appBar,
    this.iconData,
    this.title,
    this.sliverAppBarHeight = 110,
    this.searchWidgetWithStatsRow,
    this.searchBarConfig,
    this.filterSheetChildren,
    required this.itemsListenable,
    required this.itemBuilder,
    required this.onRefresh,
    this.emptyMessage = 'Keine Ergebnisse',
    this.bottomNavigationBar,
    this.bottomBarActions,
    this.maxWidth = 800,
    this.leadingSlivers,
    this.backgroundColor,
  }) : assert(
         appBar != null || (iconData != null && title != null),
         'Provide either appBar or both iconData and title',
       );

  PreferredSizeWidget get _effectiveAppBar {
    if (appBar != null) return appBar!;
    return GenericAppBar(iconData: iconData!, title: title!);
  }

  void Function(BuildContext) _effectiveShowFilter(BuildContext context) {
    if (filterSheetChildren != null) {
      final children = filterSheetChildren!;
      return (BuildContext ctx) {
        showGenericBottomSheet(
          ctx,
          GenericFilterBottomSheet(children: children),
        );
      };
    }
    return searchBarConfig?.showFilterBottomSheet ?? (_) {};
  }

  Widget? _buildSearchWidget(BuildContext context) {
    if (searchWidgetWithStatsRow != null) return searchWidgetWithStatsRow;
    final config = searchBarConfig;
    if (config == null) return null;
    return GenericListSearchBarWithStats(
      statsWidget: config.statsWidget,
      middleWidgets: config.middleWidgets,
      searchType: config.searchType,
      hintText: config.hintText,
      refreshFunction: config.refreshFunction,
      onChanged: config.onChanged,
      searchTextSource: config.searchTextSource,
      filtersActive: config.filtersActive,
      onResetFilters: config.onResetFilters,
      showFilterBottomSheet: _effectiveShowFilter(context),
    );
  }

  Widget? _buildBottomNavBar(BuildContext context) {
    if (bottomNavigationBar != null) return bottomNavigationBar;
    final actions = <Widget>[];
    if (filterSheetChildren != null) {
      actions.add(
        IconButton(
          tooltip: 'Filter',
          icon: const Icon(Icons.filter_list, size: 30),
          onPressed: () => _effectiveShowFilter(context)(context),
        ),
      );
    }
    if (bottomBarActions != null) actions.addAll(bottomBarActions!);
    if (actions.isEmpty) return null;
    return GenericBottomNavBar(actions: actions);
  }

  @override
  Widget build(BuildContext context) {
    final searchWidget = _buildSearchWidget(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _effectiveAppBar,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth ?? 800),
            child: CustomScrollView(
              slivers: [
                if (leadingSlivers != null) ...leadingSlivers!,
                if (leadingSlivers == null) const SliverGap(5),
                if (searchWidget != null)
                  GenericSliverAppBarWithSearchWidget(
                    height: sliverAppBarHeight,
                    searchWidgetWithStatsRow: searchWidget,
                  ),
                GenericSliverListWithEmptyListCheck<T>(
                  itemsListenable: itemsListenable,
                  itemBuilder: itemBuilder,
                  emptyMessage: emptyMessage,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }
}
