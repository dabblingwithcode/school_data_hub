// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDTO _$BookDTOFromJson(Map<String, dynamic> json) => BookDTO(
  author: json['author'] as String,
  description: json['description'] as String?,
  imageId: json['image_id'] as String?,
  isbn: (json['isbn'] as num).toInt(),
  readingLevel: json['reading_level'] as String,
  title: json['title'] as String,
  bookTags: (json['book_tags'] as List<dynamic>?)
      ?.map((e) => BookTag.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BookDTOToJson(BookDTO instance) => <String, dynamic>{
  'isbn': instance.isbn,
  'title': instance.title,
  'author': instance.author,
  'description': instance.description,
  'image_id': instance.imageId,
  'reading_level': instance.readingLevel,
  'book_tags': instance.bookTags,
};
