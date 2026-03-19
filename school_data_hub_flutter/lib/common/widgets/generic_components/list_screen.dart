import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/domain/search_text_source.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/content_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/filter_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/search_row.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_sheet.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/sliver_search_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

/// Configuration for the search bar built by [ListScreen].
/// [showFilterBottomSheet] is optional when [ListScreen.filterSheetChildren] is set.
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
/// List pages import only this file; AppHeader, FilterSheet,
/// SearchRow, and showSheet are used exclusively here.
/// Use [iconData] + [title] for the app bar, or [appBar] for a custom one.
/// Use [filterSheetChildren] for the filter sheet (composition); no callback needed in the list page.
class ListScreen<T> extends StatelessWidget {
  /// When set, used as the app bar. Otherwise [iconData] and [title] are used to build [AppHeader].
  final PreferredSizeWidget? appBar;
  final IconData? iconData;
  final String? title;
  final double sliverAppBarHeight;
  final Widget? searchWidgetWithStatsRow;
  final GenericListSearchBarConfig? searchBarConfig;

  /// When set, the filter sheet is shown with these children; [ListScreen] builds the sheet internally.
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

  const ListScreen({
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
    return AppHeader(iconData: iconData!, title: title!);
  }

  void Function(BuildContext) _effectiveShowFilter(BuildContext context) {
    if (filterSheetChildren != null) {
      final children = filterSheetChildren!;
      return (BuildContext ctx) {
        showSheet(ctx, FilterSheet(children: children));
      };
    }
    return searchBarConfig?.showFilterBottomSheet ?? (_) {};
  }

  @override
  Widget build(BuildContext context) {
    final showFilter = _effectiveShowFilter(context);
    final searchWidget =
        (searchWidgetWithStatsRow != null || searchBarConfig != null)
        ? _ListPageSearchWidget(
            searchWidgetWithStatsRow: searchWidgetWithStatsRow,
            searchBarConfig: searchBarConfig,
            showFilterBottomSheet: showFilter,
          )
        : null;
    return Scaffold(
      backgroundColor: backgroundColor ?? Style.of(context).colors.canvas,
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
                  SliverSearchBar(
                    height: sliverAppBarHeight,
                    searchWidgetWithStatsRow: searchWidget,
                  ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: Style.spacing.sm),
                  sliver: ContentSliverList<T>(
                    itemsListenable: itemsListenable,
                    itemBuilder: itemBuilder,
                    emptyMessage: emptyMessage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          (bottomNavigationBar != null ||
              (bottomBarActions?.isNotEmpty ?? false) ||
              filterSheetChildren != null)
          ? _ListPageBottomNavBar(
              bottomNavigationBar: bottomNavigationBar,
              bottomBarActions: bottomBarActions,
              filterSheetChildren: filterSheetChildren,
              showFilterBottomSheet: showFilter,
              filtersActive: searchBarConfig?.filtersActive,
              onResetFilters: searchBarConfig?.onResetFilters,
            )
          : null,
    );
  }
}

/// Private widget for the search section; used only by [ListScreen].
class _ListPageSearchWidget extends StatelessWidget {
  const _ListPageSearchWidget({
    this.searchWidgetWithStatsRow,
    this.searchBarConfig,
    required this.showFilterBottomSheet,
  });

  final Widget? searchWidgetWithStatsRow;
  final GenericListSearchBarConfig? searchBarConfig;
  final void Function(BuildContext) showFilterBottomSheet;

  @override
  Widget build(BuildContext context) {
    if (searchWidgetWithStatsRow != null) return searchWidgetWithStatsRow!;
    final config = searchBarConfig;
    if (config == null) return const SizedBox.shrink();
    return SearchRow(
      statsWidget: config.statsWidget,
      middleWidgets: config.middleWidgets,
      searchType: config.searchType,
      hintText: config.hintText,
      refreshFunction: config.refreshFunction,
      onChanged: config.onChanged,
      searchTextSource: config.searchTextSource,
      filtersActive: config.filtersActive,
      onResetFilters: config.onResetFilters,
      showFilterBottomSheet: showFilterBottomSheet,
    );
  }
}

/// Private widget for the bottom nav bar; used only by [ListScreen].
class _ListPageBottomNavBar extends StatelessWidget {
  const _ListPageBottomNavBar({
    this.bottomNavigationBar,
    this.bottomBarActions,
    this.filterSheetChildren,
    required this.showFilterBottomSheet,
    this.filtersActive,
    this.onResetFilters,
  });

  final Widget? bottomNavigationBar;
  final List<Widget>? bottomBarActions;
  final List<Widget>? filterSheetChildren;
  final void Function(BuildContext) showFilterBottomSheet;
  final ValueListenable<bool>? filtersActive;
  final VoidCallback? onResetFilters;

  @override
  Widget build(BuildContext context) {
    if (bottomNavigationBar != null) return bottomNavigationBar!;
    final actions = <Widget>[];

    if (bottomBarActions != null) actions.addAll(bottomBarActions!);
    if (filterSheetChildren != null && filtersActive != null) {
      actions.add(
        FilterButton(
          isSearchBar: false,
          filtersActive: filtersActive!,
          onLongPress: onResetFilters,
          showBottomSheetFunction: showFilterBottomSheet,
        ),
      );
    }
    if (actions.isEmpty) return const SizedBox.shrink();
    return ActionBar(actions: actions);
  }
}
