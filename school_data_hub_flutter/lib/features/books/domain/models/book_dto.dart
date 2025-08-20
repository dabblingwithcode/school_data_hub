// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';

part 'book_dto.g.dart';

@JsonSerializable()
class BookDTO {
  final int isbn;
  final String title;
  final String author;
  final String? description;
  @JsonKey(name: "image_id")
  final String? imageId;
  @JsonKey(name: "reading_level")
  final String readingLevel;
  @JsonKey(name: "book_tags")
  final List<BookTag>? bookTags;

  factory BookDTO.fromJson(Map<String, dynamic> json) =>
      _$BookDTOFromJson(json);

  Map<String, dynamic> toJson() => _$BookDTOToJson(this);

  BookDTO({
    required this.author,
    required this.description,
    required this.imageId,
    required this.isbn,
    required this.readingLevel,
    required this.title,
    required this.bookTags,
  });
}
