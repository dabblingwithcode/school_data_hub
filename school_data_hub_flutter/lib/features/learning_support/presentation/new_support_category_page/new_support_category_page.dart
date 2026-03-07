import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/post_or_patch_support_category_page/post_or_patch_support_category_page.dart';

/// Redirects to [PostOrPatchSupportCategoryPage] for create mode.
/// Kept for backwards compatibility; prefer pushing [PostOrPatchSupportCategoryPage]
/// with [category] and [parentCategoryId] null directly.
class NewSupportCategoryPage extends StatelessWidget {
  const NewSupportCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostOrPatchSupportCategoryPage(
      category: null,
      parentCategoryId: null,
    );
  }
}
