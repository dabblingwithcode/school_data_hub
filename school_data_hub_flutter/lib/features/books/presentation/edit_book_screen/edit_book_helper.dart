import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';

/// Helper class for navigating to the edit book page
class EditBookHelper {
  /// Navigate to the edit book page for a given library book
  static Future<void> navigateToEditBook(
    BuildContext context,
    LibraryBookProxy libraryBook,
  ) async {
    await context.push(RoutePaths.learningBooksEdit, extra: libraryBook);
  }
}
