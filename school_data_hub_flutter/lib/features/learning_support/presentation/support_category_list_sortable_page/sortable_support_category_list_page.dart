import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_bottom_nav_bar_no_filter.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/widgets/support_category_tree_sortable.dart';

class SortableSupportCategoryListPage extends WatchingWidget {
  const SortableSupportCategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SupportCategory> categories = watchValue(
      (SupportCategoryManager m) => m.supportCategories,
    );

    // When leaving this page, sort and notify so other pages see the
    // correct order. Order updates during drag don't notify listeners
    // to avoid conflicting with the ReorderableListView animation.
    onDispose(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        di<SupportCategoryManager>().sortAndNotifyCategories();
      });
    });

    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.category_rounded,
        title: 'Kategoriereihenfolge ändern',
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            di<SupportCategoryManager>().fetchSupportCategories(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SupportCategoryTreeSortable(categories: categories),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GenericBottomNavBarNoFilter(),
    );
  }
}
