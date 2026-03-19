import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/post_or_patch_support_category_screen/post_or_patch_support_category_screen.dart';

/// Redirects to [PostOrPatchSupportCategoryScreen] for create mode.
/// Kept for backwards compatibility; prefer pushing [PostOrPatchSupportCategoryScreen]
/// with [category] and [parentCategoryId] null directly.
class NewSupportCategoryScreen extends StatelessWidget {
  const NewSupportCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostOrPatchSupportCategoryScreen(
      category: null,
      parentCategoryId: null,
    );
  }
}
