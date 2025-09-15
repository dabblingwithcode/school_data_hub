import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/presentation/edit_book_page/edit_book_controller.dart';

/// Helper class for navigating to the edit book page
class EditBookHelper {
  /// Navigate to the edit book page for a given library book
  static Future<void> navigateToEditBook(
    BuildContext context,
    LibraryBookProxy libraryBook,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBook(libraryBook: libraryBook),
      ),
    );
  }
}

