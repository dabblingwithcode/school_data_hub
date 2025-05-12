// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'library_book_dto.g.dart';

@JsonSerializable()
class LibraryBookDTO {
  @JsonKey(name: "book_id")
  final String bookId;
  final int isbn;
  final String location;

  final bool available;

  factory LibraryBookDTO.fromJson(Map<String, dynamic> json) =>
      _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  LibraryBookDTO({
    required this.available,
    required this.bookId,
    required this.isbn,
    required this.location,
  });
}
