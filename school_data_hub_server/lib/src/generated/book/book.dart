/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../book/book_tagging/book_tagging.dart' as _i2;
import '../book/library_book.dart' as _i3;

abstract class Book implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Book._({
    this.id,
    required this.isbn,
    required this.title,
    required this.author,
    required this.description,
    required this.readingLevel,
    required this.imageId,
    required this.imageUrl,
    this.tags,
    this.libraryBooks,
  });

  factory Book({
    int? id,
    required int isbn,
    required String title,
    required String author,
    required String description,
    required String readingLevel,
    required String imageId,
    required String imageUrl,
    List<_i2.BookTagging>? tags,
    List<_i3.LibraryBook>? libraryBooks,
  }) = _BookImpl;

  factory Book.fromJson(Map<String, dynamic> jsonSerialization) {
    return Book(
      id: jsonSerialization['id'] as int?,
      isbn: jsonSerialization['isbn'] as int,
      title: jsonSerialization['title'] as String,
      author: jsonSerialization['author'] as String,
      description: jsonSerialization['description'] as String,
      readingLevel: jsonSerialization['readingLevel'] as String,
      imageId: jsonSerialization['imageId'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i2.BookTagging.fromJson((e as Map<String, dynamic>)))
          .toList(),
      libraryBooks: (jsonSerialization['libraryBooks'] as List?)
          ?.map((e) => _i3.LibraryBook.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = BookTable();

  static const db = BookRepository._();

  @override
  int? id;

  int isbn;

  String title;

  String author;

  String description;

  String readingLevel;

  String imageId;

  String imageUrl;

  List<_i2.BookTagging>? tags;

  List<_i3.LibraryBook>? libraryBooks;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Book copyWith({
    int? id,
    int? isbn,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    String? imageId,
    String? imageUrl,
    List<_i2.BookTagging>? tags,
    List<_i3.LibraryBook>? libraryBooks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      'title': title,
      'author': author,
      'description': description,
      'readingLevel': readingLevel,
      'imageId': imageId,
      'imageUrl': imageUrl,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (libraryBooks != null)
        'libraryBooks': libraryBooks?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'isbn': isbn,
      'title': title,
      'author': author,
      'description': description,
      'readingLevel': readingLevel,
      'imageId': imageId,
      'imageUrl': imageUrl,
      if (tags != null)
        'tags': tags?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (libraryBooks != null)
        'libraryBooks':
            libraryBooks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static BookInclude include({
    _i2.BookTaggingIncludeList? tags,
    _i3.LibraryBookIncludeList? libraryBooks,
  }) {
    return BookInclude._(
      tags: tags,
      libraryBooks: libraryBooks,
    );
  }

  static BookIncludeList includeList({
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTable>? orderByList,
    BookInclude? include,
  }) {
    return BookIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Book.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Book.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookImpl extends Book {
  _BookImpl({
    int? id,
    required int isbn,
    required String title,
    required String author,
    required String description,
    required String readingLevel,
    required String imageId,
    required String imageUrl,
    List<_i2.BookTagging>? tags,
    List<_i3.LibraryBook>? libraryBooks,
  }) : super._(
          id: id,
          isbn: isbn,
          title: title,
          author: author,
          description: description,
          readingLevel: readingLevel,
          imageId: imageId,
          imageUrl: imageUrl,
          tags: tags,
          libraryBooks: libraryBooks,
        );

  /// Returns a shallow copy of this [Book]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Book copyWith({
    Object? id = _Undefined,
    int? isbn,
    String? title,
    String? author,
    String? description,
    String? readingLevel,
    String? imageId,
    String? imageUrl,
    Object? tags = _Undefined,
    Object? libraryBooks = _Undefined,
  }) {
    return Book(
      id: id is int? ? id : this.id,
      isbn: isbn ?? this.isbn,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      readingLevel: readingLevel ?? this.readingLevel,
      imageId: imageId ?? this.imageId,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags is List<_i2.BookTagging>?
          ? tags
          : this.tags?.map((e0) => e0.copyWith()).toList(),
      libraryBooks: libraryBooks is List<_i3.LibraryBook>?
          ? libraryBooks
          : this.libraryBooks?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class BookTable extends _i1.Table<int> {
  BookTable({super.tableRelation}) : super(tableName: 'book') {
    isbn = _i1.ColumnInt(
      'isbn',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    author = _i1.ColumnString(
      'author',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    readingLevel = _i1.ColumnString(
      'readingLevel',
      this,
    );
    imageId = _i1.ColumnString(
      'imageId',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
  }

  late final _i1.ColumnInt isbn;

  late final _i1.ColumnString title;

  late final _i1.ColumnString author;

  late final _i1.ColumnString description;

  late final _i1.ColumnString readingLevel;

  late final _i1.ColumnString imageId;

  late final _i1.ColumnString imageUrl;

  _i2.BookTaggingTable? ___tags;

  _i1.ManyRelation<_i2.BookTaggingTable>? _tags;

  _i3.LibraryBookTable? ___libraryBooks;

  _i1.ManyRelation<_i3.LibraryBookTable>? _libraryBooks;

  _i2.BookTaggingTable get __tags {
    if (___tags != null) return ___tags!;
    ___tags = _i1.createRelationTable(
      relationFieldName: '__tags',
      field: Book.t.id,
      foreignField: _i2.BookTagging.t.bookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BookTaggingTable(tableRelation: foreignTableRelation),
    );
    return ___tags!;
  }

  _i3.LibraryBookTable get __libraryBooks {
    if (___libraryBooks != null) return ___libraryBooks!;
    ___libraryBooks = _i1.createRelationTable(
      relationFieldName: '__libraryBooks',
      field: Book.t.id,
      foreignField: _i3.LibraryBook.t.bookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LibraryBookTable(tableRelation: foreignTableRelation),
    );
    return ___libraryBooks!;
  }

  _i1.ManyRelation<_i2.BookTaggingTable> get tags {
    if (_tags != null) return _tags!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'tags',
      field: Book.t.id,
      foreignField: _i2.BookTagging.t.bookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BookTaggingTable(tableRelation: foreignTableRelation),
    );
    _tags = _i1.ManyRelation<_i2.BookTaggingTable>(
      tableWithRelations: relationTable,
      table: _i2.BookTaggingTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _tags!;
  }

  _i1.ManyRelation<_i3.LibraryBookTable> get libraryBooks {
    if (_libraryBooks != null) return _libraryBooks!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'libraryBooks',
      field: Book.t.id,
      foreignField: _i3.LibraryBook.t.bookId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LibraryBookTable(tableRelation: foreignTableRelation),
    );
    _libraryBooks = _i1.ManyRelation<_i3.LibraryBookTable>(
      tableWithRelations: relationTable,
      table: _i3.LibraryBookTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _libraryBooks!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        isbn,
        title,
        author,
        description,
        readingLevel,
        imageId,
        imageUrl,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'tags') {
      return __tags;
    }
    if (relationField == 'libraryBooks') {
      return __libraryBooks;
    }
    return null;
  }
}

class BookInclude extends _i1.IncludeObject {
  BookInclude._({
    _i2.BookTaggingIncludeList? tags,
    _i3.LibraryBookIncludeList? libraryBooks,
  }) {
    _tags = tags;
    _libraryBooks = libraryBooks;
  }

  _i2.BookTaggingIncludeList? _tags;

  _i3.LibraryBookIncludeList? _libraryBooks;

  @override
  Map<String, _i1.Include?> get includes => {
        'tags': _tags,
        'libraryBooks': _libraryBooks,
      };

  @override
  _i1.Table<int> get table => Book.t;
}

class BookIncludeList extends _i1.IncludeList {
  BookIncludeList._({
    _i1.WhereExpressionBuilder<BookTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Book.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Book.t;
}

class BookRepository {
  const BookRepository._();

  final attach = const BookAttachRepository._();

  final attachRow = const BookAttachRowRepository._();

  final detach = const BookDetachRepository._();

  final detachRow = const BookDetachRowRepository._();

  /// Returns a list of [Book]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Book>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTable>? orderByList,
    _i1.Transaction? transaction,
    BookInclude? include,
  }) async {
    return session.db.find<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Book] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Book?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookTable>? orderByList,
    _i1.Transaction? transaction,
    BookInclude? include,
  }) async {
    return session.db.findFirstRow<Book>(
      where: where?.call(Book.t),
      orderBy: orderBy?.call(Book.t),
      orderByList: orderByList?.call(Book.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Book] by its [id] or null if no such row exists.
  Future<Book?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    BookInclude? include,
  }) async {
    return session.db.findById<Book>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Book]s in the list and returns the inserted rows.
  ///
  /// The returned [Book]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Book>> insert(
    _i1.Session session,
    List<Book> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Book>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Book] and returns the inserted row.
  ///
  /// The returned [Book] will have its `id` field set.
  Future<Book> insertRow(
    _i1.Session session,
    Book row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Book>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Book]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Book>> update(
    _i1.Session session,
    List<Book> rows, {
    _i1.ColumnSelections<BookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Book>(
      rows,
      columns: columns?.call(Book.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Book]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Book> updateRow(
    _i1.Session session,
    Book row, {
    _i1.ColumnSelections<BookTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Book>(
      row,
      columns: columns?.call(Book.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Book]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Book>> delete(
    _i1.Session session,
    List<Book> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Book>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Book].
  Future<Book> deleteRow(
    _i1.Session session,
    Book row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Book>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Book>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Book>(
      where: where(Book.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Book>(
      where: where?.call(Book.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class BookAttachRepository {
  const BookAttachRepository._();

  /// Creates a relation between this [Book] and the given [BookTagging]s
  /// by setting each [BookTagging]'s foreign key `bookId` to refer to this [Book].
  Future<void> tags(
    _i1.Session session,
    Book book,
    List<_i2.BookTagging> bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.any((e) => e.id == null)) {
      throw ArgumentError.notNull('bookTagging.id');
    }
    if (book.id == null) {
      throw ArgumentError.notNull('book.id');
    }

    var $bookTagging =
        bookTagging.map((e) => e.copyWith(bookId: book.id)).toList();
    await session.db.update<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Book] and the given [LibraryBook]s
  /// by setting each [LibraryBook]'s foreign key `bookId` to refer to this [Book].
  Future<void> libraryBooks(
    _i1.Session session,
    Book book,
    List<_i3.LibraryBook> libraryBook, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('libraryBook.id');
    }
    if (book.id == null) {
      throw ArgumentError.notNull('book.id');
    }

    var $libraryBook =
        libraryBook.map((e) => e.copyWith(bookId: book.id)).toList();
    await session.db.update<_i3.LibraryBook>(
      $libraryBook,
      columns: [_i3.LibraryBook.t.bookId],
      transaction: transaction,
    );
  }
}

class BookAttachRowRepository {
  const BookAttachRowRepository._();

  /// Creates a relation between this [Book] and the given [BookTagging]
  /// by setting the [BookTagging]'s foreign key `bookId` to refer to this [Book].
  Future<void> tags(
    _i1.Session session,
    Book book,
    _i2.BookTagging bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.id == null) {
      throw ArgumentError.notNull('bookTagging.id');
    }
    if (book.id == null) {
      throw ArgumentError.notNull('book.id');
    }

    var $bookTagging = bookTagging.copyWith(bookId: book.id);
    await session.db.updateRow<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Book] and the given [LibraryBook]
  /// by setting the [LibraryBook]'s foreign key `bookId` to refer to this [Book].
  Future<void> libraryBooks(
    _i1.Session session,
    Book book,
    _i3.LibraryBook libraryBook, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.id == null) {
      throw ArgumentError.notNull('libraryBook.id');
    }
    if (book.id == null) {
      throw ArgumentError.notNull('book.id');
    }

    var $libraryBook = libraryBook.copyWith(bookId: book.id);
    await session.db.updateRow<_i3.LibraryBook>(
      $libraryBook,
      columns: [_i3.LibraryBook.t.bookId],
      transaction: transaction,
    );
  }
}

class BookDetachRepository {
  const BookDetachRepository._();

  /// Detaches the relation between this [Book] and the given [BookTagging]
  /// by setting the [BookTagging]'s foreign key `bookId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tags(
    _i1.Session session,
    List<_i2.BookTagging> bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.any((e) => e.id == null)) {
      throw ArgumentError.notNull('bookTagging.id');
    }

    var $bookTagging =
        bookTagging.map((e) => e.copyWith(bookId: null)).toList();
    await session.db.update<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Book] and the given [LibraryBook]
  /// by setting the [LibraryBook]'s foreign key `bookId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> libraryBooks(
    _i1.Session session,
    List<_i3.LibraryBook> libraryBook, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.any((e) => e.id == null)) {
      throw ArgumentError.notNull('libraryBook.id');
    }

    var $libraryBook =
        libraryBook.map((e) => e.copyWith(bookId: null)).toList();
    await session.db.update<_i3.LibraryBook>(
      $libraryBook,
      columns: [_i3.LibraryBook.t.bookId],
      transaction: transaction,
    );
  }
}

class BookDetachRowRepository {
  const BookDetachRowRepository._();

  /// Detaches the relation between this [Book] and the given [BookTagging]
  /// by setting the [BookTagging]'s foreign key `bookId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> tags(
    _i1.Session session,
    _i2.BookTagging bookTagging, {
    _i1.Transaction? transaction,
  }) async {
    if (bookTagging.id == null) {
      throw ArgumentError.notNull('bookTagging.id');
    }

    var $bookTagging = bookTagging.copyWith(bookId: null);
    await session.db.updateRow<_i2.BookTagging>(
      $bookTagging,
      columns: [_i2.BookTagging.t.bookId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Book] and the given [LibraryBook]
  /// by setting the [LibraryBook]'s foreign key `bookId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> libraryBooks(
    _i1.Session session,
    _i3.LibraryBook libraryBook, {
    _i1.Transaction? transaction,
  }) async {
    if (libraryBook.id == null) {
      throw ArgumentError.notNull('libraryBook.id');
    }

    var $libraryBook = libraryBook.copyWith(bookId: null);
    await session.db.updateRow<_i3.LibraryBook>(
      $libraryBook,
      columns: [_i3.LibraryBook.t.bookId],
      transaction: transaction,
    );
  }
}
